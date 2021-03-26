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

instance HasNewSessionUrl User where
    newSessionUrl _ = "/NewSession"

type instance CurrentUserRecord = User

data SessionsController
    = NewSessionAction
    | CreateSessionAction
    | DeleteSessionAction
    deriving (Eq, Show, Data)

    
data SpellsController
    = SpellsAction
    | NewSpellAction
    | ShowSpellAction { spellId :: !(Id Spell) }
    | CreateSpellAction
    | EditSpellAction { spellId :: !(Id Spell) }
    | UpdateSpellAction { spellId :: !(Id Spell) }
    | DeleteSpellAction { spellId :: !(Id Spell) }
    deriving (Eq, Show, Data)
