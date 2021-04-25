module Web.View.Bugs.Show where
import Web.View.Prelude

import qualified Text.MMark as MMark -- markdown library (mmark)


data ShowView = ShowView { bug :: Include "comments" Bug }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={BugsAction}>Bugs</a></li>
                <li class="breadcrumb-item active">Show Bug</li>
            </ol>
        </nav>
        <h1>{get #bugDescription bug}</h1>
        <h1>{get #bugContent bug |> renderMarkdown}</h1>
        <p>{get #createdAt bug |> timeAgo}</p>
        <p>{bug}</p>
        <div>{forEach (get #comments bug) renderComment}</div>

        <a href={NewCommentAction (get #id bug)}>Add Comment</a>
    |]

renderComment comment = [hsx|<div>{comment}</div>|]

renderMarkdown text = text

