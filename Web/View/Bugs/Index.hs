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
                        <th></th>
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
        [ "id" .= get #id bug
        , "title" .= get #bugTitle bug
        , "description" .= get #bugDescription bug
        , "spell" .= get #spellId bug

        ]

renderBug bug = [hsx|
<div class="bugIndexBug">
    <div class="row">
        <div class="col-md-2">
            <img src="http://placekitten.com/80/80" class="bugIndexSpellImg rounded"/>
        </div>
        <div class="col-md-10">
            <div>
                <a href={ShowBugAction (get #id bug)}>{get #bugTitle bug} </a>
            </div>
            <div>
                <span class="badge badge-pill badge-primary">{get #bugTags bug}</span> <span class="badge badge-pill badge-primary">{get #bugTags bug}</span>    
            </div>  
        </div>
    </div>
</div>
|]


