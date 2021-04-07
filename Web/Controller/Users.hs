module Web.Controller.Users where

import Web.Controller.Prelude
import Web.View.Users.Index
import Web.View.Users.New
import Web.View.Users.Edit
import Web.View.Users.Show

import qualified Data.Text as T
import Data.Char 

isPasswordLongEnough :: Text -> ValidatorResult
isPasswordLongEnough s
  | T.length s > 7 = Success
  | otherwise = Failure "Password needs to be at least 8 characters long." 

isAlphaNumeric :: Text -> ValidatorResult
isAlphaNumeric s
    | foldr ((&&) . isAlphaNum) True (T.unpack s) = Success
    | otherwise     = Failure "Please only use letters and numbers in your username" 


instance Controller UsersController where
    action UsersAction = do
        users <- query @User |> fetch
        render IndexView { .. }

    action NewUserAction = do
        let user = newRecord
        render NewView { .. }

    action ShowUserAction { userId } = do
        user <- fetch userId
        render ShowView { .. }

    action EditUserAction { userId } = do
        user <- fetch userId
        render EditView { .. }

    action UpdateUserAction { userId } = do
        user <- fetch userId
        user
            |> buildUser
            |> ifValid \case
                Left user -> render EditView { .. }
                Right user -> do
                    user <- user |> updateRecord
                    setSuccessMessage "User updated"
                    redirectTo EditUserAction { .. }

    action CreateUserAction = do
        let user = newRecord @User
        user
            |> fill @["username", "email", "passwordHash"]
            |> validateField #email isEmail
            |> validateField #passwordHash (hasMinLength 8)
            |> validateField #passwordHash nonEmpty
            |> validateField #username nonEmpty
            |> validateField #username (hasMinLength 3)
            |> validateField #username isAlphaNumeric
            |> validateIsUnique #username
            >>= validateIsUnique #email
            >>= ifValid \case
                Left user -> render NewView { .. }
                Right user -> do
                    hashed <- hashPassword (get #passwordHash user)
                    user <- user
                        |> set #passwordHash hashed
                        |> createRecord
                    setSuccessMessage "Glad to have you, Bugwalker! You may now log in."
                    redirectTo NewSessionAction


        let user = newRecord @User
        user
            |> buildUser
            |> ifValid \case
                Left user -> render NewView { .. } 
                Right user -> do
                    user <- user |> createRecord
                    setSuccessMessage "User created"
                    redirectTo UsersAction

    action DeleteUserAction { userId } = do
        user <- fetch userId
        deleteRecord user
        setSuccessMessage "User deleted"
        redirectTo UsersAction

buildUser user = user
    |> fill @["email","passwordHash","failedLoginAttempts","username","userRole","passwordSalt","userAvatar"]
