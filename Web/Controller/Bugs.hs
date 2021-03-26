module Web.Controller.Bugs where

import Web.Controller.Prelude
import Web.View.Bugs.Index
import Web.View.Bugs.New
import Web.View.Bugs.Edit
import Web.View.Bugs.Show

instance Controller BugsController where
    action BugsAction = do
        bugs <- query @Bug |> fetch
        render IndexView { .. }

    action NewBugAction = do
        let bug = newRecord
        render NewView { .. }

    action ShowBugAction { bugId } = do
        bug <- fetch bugId
        render ShowView { .. }

    action EditBugAction { bugId } = do
        bug <- fetch bugId
        render EditView { .. }

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
            |> ifValid \case
                Left bug -> render NewView { .. } 
                Right bug -> do
                    bug <- bug |> createRecord
                    setSuccessMessage "Bug created"
                    redirectTo BugsAction

    action DeleteBugAction { bugId } = do
        bug <- fetch bugId
        deleteRecord bug
        setSuccessMessage "Bug deleted"
        redirectTo BugsAction

buildBug bug = bug
    |> fill @["spellId","bugSeverity","bugType","bugStatus","bugTags","bugDescription","bugContent","bugBlueTrackerLink","userId","bugPinned"]
