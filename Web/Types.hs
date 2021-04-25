module Web.Types where

import IHP.Prelude
import IHP.ModelSupport
import Generated.Types
import IHP.LoginSupport.Types


data WebApplication = WebApplication deriving (Eq, Show)


data StaticController = WelcomeAction deriving (Eq, Show, Data)

data SpecsController
    = SpecsAction
    | NewSpecAction
    | ShowSpecAction { specId :: !(Id Spec) }
    | CreateSpecAction
    | EditSpecAction { specId :: !(Id Spec) }
    | UpdateSpecAction { specId :: !(Id Spec) }
    | DeleteSpecAction { specId :: !(Id Spec) }
    deriving (Eq, Show, Data)

data SessionsController
    = NewSessionAction
    | CreateSessionAction
    | DeleteSessionAction
    deriving (Eq, Show, Data)

instance HasNewSessionUrl User where
    newSessionUrl _ = "/NewSession"

type instance CurrentUserRecord = User

    
data UsersController
    = UsersAction
    | NewUserAction
    | ShowUserAction { userId :: !(Id User) }
    | CreateUserAction
    | EditUserAction { userId :: !(Id User) }
    | UpdateUserAction { userId :: !(Id User) }
    | DeleteUserAction { userId :: !(Id User) }
    deriving (Eq, Show, Data)

data BugsController
    = BugsAction
    | NewBugAction
    | ShowBugAction { bugId :: !(Id Bug) }
    | CreateBugAction
    | EditBugAction { bugId :: !(Id Bug) }
    | UpdateBugAction { bugId :: !(Id Bug) }
    | DeleteBugAction { bugId :: !(Id Bug) }
    deriving (Eq, Show, Data)
    
data CommentsController
    = CommentsAction
    | NewCommentAction { bugId :: !(Id Bug) }
    | ShowCommentAction { commentId :: !(Id Comment) }
    | CreateCommentAction
    | EditCommentAction { commentId :: !(Id Comment) }
    | UpdateCommentAction { commentId :: !(Id Comment) }
    | DeleteCommentAction { commentId :: !(Id Comment) }
    deriving (Eq, Show, Data)
