module Web.View.Spells.Show where
import Web.View.Prelude

data ShowView = ShowView { spell :: Spell }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={SpellsAction}>Spells</a></li>
                <li class="breadcrumb-item active">Show Spell</li>
            </ol>
        </nav>
        <h1>{get #spellName spell}</h1>
        <div class="row">
        <table class="table table-bordered table-striped">
            <tbody>
                <tr>
                    <td>Game Id</td>
                    <td>{get #gameId spell}</td>
                </tr>
                <tr>
                    <td>Db Id</td>
                    <td>{get #id spell}</td>
                </tr>
                <tr>
                    <td>Description</td>
                    <td>{get #spellDescription spell}</td>
                </tr>
                <tr>
                    <td>Specs</td>
                    <td>{get #specIds spell}</td>
                </tr>
            </tbody>
        </table>
        </div>
        <a href={SpellsAction} class="btn btn-primary"> &lt; All Spells</a>
    |]
