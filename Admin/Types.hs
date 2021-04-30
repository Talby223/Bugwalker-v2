module Admin.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types
import IHP.LoginSupport.Types -- <---- ADD THIS IMPORT


data AdminApplication = AdminApplication deriving (Eq, Show)


data StaticController = WelcomeAction deriving (Eq, Show, Data)


-- ADD THIS TO THE END OF THE FILE

instance HasNewSessionUrl Admin where
    newSessionUrl _ = "/NewSession"

type instance CurrentAdminRecord = Admin

data SessionsController
    = NewSessionAction
    | CreateSessionAction
    | DeleteSessionAction
    deriving (Eq, Show, Data)