module Web.View.Bugs.Index where
import Web.View.Prelude
import Data.Aeson

data IndexView = IndexView { bugs :: [Bug] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href={BugsAction}>Bugs</a></li>
            </ol>
        </nav>
        <h1>Index <a href={pathTo NewBugAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Bug</th>
                        <th></th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach bugs renderBug}</tbody>
            </table>
        </div>
    |]

instance ToJSON Bug where
    toJSON bug = object
        [ "id" .= get #spellId bug
        , "title" .= get #bugTitle bug
        , "body" .= get #bugDescription bug
        ]

renderBug bug = [hsx|
    <tr>
        <td><a href={ShowBugAction (get #id bug)}>{get #bugTitle bug}</a></td>
        <td>{get #spellId bug}</td>
        <td>{get #bugSeverity bug}</td>
        <td>{get #bugTags bug}</td>
        <td><a href={EditBugAction (get #id bug)} class="text-muted">Edit</a></td>
        <td><a href={DeleteBugAction (get #id bug)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
