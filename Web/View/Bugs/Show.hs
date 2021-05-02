module Web.View.Bugs.Show where
import Web.View.Prelude

import qualified Text.MMark as MMark -- markdown library (mmark)


data ShowView = ShowView { bug :: Bug, comments :: [Include "userId" Comment] }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={BugsAction}>Bugs</a></li>
                <li class="breadcrumb-item active">Show Bug</li>
            </ol>
        </nav>
        <h1>{get #bugTitle bug}</h1>
        <p>{get #createdAt bug |> timeAgo}</p>
        <br>
        <p>{get #bugBlueTrackerLink bug}</p>
        <br>            
        <h2>{get #bugDescription bug}</h2>
        <p>{get #bugContent bug |> renderMarkdown}</p>
        <br>
        <div>{forEach comments renderComment}</div>
        <a href={NewCommentAction (get #id bug)}>Add Comment</a>
    |]

renderComment comment = [hsx|
    <div class="mt-4">
        <h5>{get #userId comment |> get #username}</h5>
        <p>{get #createdAt comment |> timeAgo}</p>
        <p>{get #commentBody comment}</p>
        <td><a href={EditCommentAction (get #id comment)} class="text-muted">Edit</a></td>
        <td><a href={DeleteCommentAction (get #id comment)} class="js-delete text-muted">Delete</a></td>        
    </div>
|]
renderMarkdown text = text