module Web.Controller.Comments where

import Web.Controller.Prelude
import Web.View.Comments.Index
import Web.View.Comments.New
import Web.View.Comments.Edit
import Web.View.Comments.Show

instance Controller CommentsController where

    action CommentsAction = do
        comments <- query @Comment |> fetch
        render IndexView { .. }

    action NewCommentAction { bugId } = do
        ensureIsUser
        let comment = newRecord
                |> set #bugId bugId
                |> set #userId currentUserId
        post <- fetch bugId
        render NewView { .. }

    action ShowCommentAction { commentId } = do
        comment <- fetch commentId
        render ShowView { .. }

    action EditCommentAction { commentId } = do
        comment <- fetch commentId
        accessDeniedUnless (get #userId comment == currentUserId || get #userRole currentUser > 0)
        render EditView { .. }

    action UpdateCommentAction { commentId } = do
        comment <- fetch commentId
        comment
            |> buildComment
            |> ifValid \case
                Left comment -> render EditView { .. }
                Right comment -> do
                    comment <- comment |> updateRecord
                    setSuccessMessage "Comment updated"
                    redirectTo EditCommentAction { .. }

    action CreateCommentAction = do
        ensureIsUser
        let comment = newRecord @Comment
        comment
            |> buildComment
            |> ifValid \case
                Left comment -> do
                    post <- fetch (get #bugId comment)
                    render NewView { .. }
                Right comment -> do
                    comment <- comment |> createRecord
                    setSuccessMessage "Comment created"
                    redirectTo ShowBugAction { bugId = get #bugId comment }

    action DeleteCommentAction { commentId } = do
        ensureIsUser
        comment <- fetch commentId
        accessDeniedUnless (get #userId comment == currentUserId || get #userRole currentUser > 0)
        deleteRecord comment
        setSuccessMessage "Comment deleted"
        redirectTo CommentsAction

buildComment comment = comment
    |> fill @["userId","commentBody","commentStatus", "bugId"]

