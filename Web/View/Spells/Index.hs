module Web.View.Spells.Index where
import Web.View.Prelude
import qualified Data.Text as T

data IndexView = IndexView { spells :: [Spell] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href={SpellsAction}>Spells</a></li>
            </ol>
        </nav>
        <h1>Spells <a href={pathTo NewSpellAction} class="btn btn-primary ml-4">+ New</a></h1>
        <table class="table table-condensed table-striped table-hover">
            <thead>
                <th>SpellId</th>
                <th>Name</th>
                <th>Description</th>
            </thead>
            <tbody>
                {forEach spells renderSpell}
            </tbody>
        </table>
        <p>{length spells} Entries</p>
    |]

toJS spells = "[" ++ T.init (f spells) ++ "]"
    where f [] = ""
          f (x:xs) = "{\"spellId\":" ++ show (get #gameId x) ++ ",\"spellName\":\"" ++ get #spellName x ++ "\", \"spellDescription\":\"" ++ (T.filter (/= '"') (get #spellDescription x)) ++ "\"}," ++ f xs

renderSpell spell = [hsx|
    <tr>
        <td>{get #gameId spell}</td>
        <td><a href={ShowSpellAction (get #id spell)}>{get #spellName spell}</a></td>
        <td>{get #spellDescription spell}</td>
    </tr>
|]
