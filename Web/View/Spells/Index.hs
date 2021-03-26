module Web.View.Spells.Index where
import           Data.Aeson
import qualified Data.Text        as T
import           Web.View.Prelude

data IndexView = IndexView { spells :: [Spell] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <h1>Spells <a href={pathTo NewSpellAction} class="btn btn-primary ml-4">+ New</a></h1>

        <div id="spellsGrid" />
        <script src="/app/spells.js"></script> 
    |]

    json IndexView { .. } = toJSON spells

instance ToJSON Spell where
    toJSON spell = object
        [ "id" .= get #id spell
        , "spellId" .= get #gameId spell
        , "name" .= get #spellName spell
        , "description" .= get #spellDescription spell
        , "specs" .= get #specIds spell
        ]
