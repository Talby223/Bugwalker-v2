module Web.Controller.Bugs where

import Web.Controller.Prelude
import Web.View.Bugs.Index
import Web.View.Bugs.New
import Web.View.Bugs.Edit
import Web.View.Bugs.Show

import qualified Text.MMark as MMark -- markdown library (mmark)



instance Controller BugsController where
    
    action BugsAction = do
        bugs <- query @Bug
            |> orderByDesc #createdAt 
            |> fetch
        render IndexView { .. }

    action NewBugAction = do
        ensureIsUser
        let bug = newRecord
        render NewView { .. }

    action ShowBugAction { bugId } = do
        bug <- fetch bugId
        comments <- bug
            |> get #comments
            |> orderBy #createdAt
            |> fetch
            >>= collectionFetchRelated #userId
        render ShowView { .. }

    action EditBugAction { bugId } = do
        bug <- fetch bugId
        accessDeniedUnless (get #userId bug == currentUserId || get #userRole currentUser > 0)
        render EditView { .. }
-- do we need access controls on the update bug action? I don't think so. 
    action UpdateBugAction { bugId } = do
        bug <- fetch bugId
        bug
            |> buildBug
            |> ifValid \case
                Left bug -> render EditView { .. }
                Right bug -> do
                    bug <- bug |> updateRecord
                    setSuccessMessage "Bug updated"
                    redirectTo EditBugAction { .. }

    action CreateBugAction = do
        let bug = newRecord @Bug
        bug
            |> buildBug
            |> validateField #bugTitle nonEmpty
            |> validateField #bugTitle (hasMinLength 8)
            |> ifValid \case
                Left bug -> render NewView { .. } 
                Right bug -> do
                    bug <- bug |> createRecord
                    setSuccessMessage "Bug created"
                    redirectTo BugsAction

    action DeleteBugAction { bugId } = do
        bug <- fetch bugId
        accessDeniedUnless (get #userId bug == currentUserId || get #userRole currentUser > 0)
        deleteRecord bug
        setSuccessMessage "Bug deleted"
        redirectTo BugsAction

buildBug bug = bug
    |> fill @["bugTitle","spellId","bugSeverity","bugType","bugStatus","bugTags","bugDescription","bugContent","bugBlueTrackerLink","userId","bugPinned"]
    |> validateField #bugDescription nonEmpty

isMarkdown :: Text -> ValidatorResult
isMarkdown text =
    case MMark.parse "" text of
        Left _ -> Failure "Please provide valid Markdown"
        Right _ -> Success
