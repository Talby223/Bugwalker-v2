module Web.View.Bugs.Show where
import Web.View.Prelude

data ShowView = ShowView { bug :: Bug }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={BugsAction}>Bugs</a></li>
                <li class="breadcrumb-item active">Show Bug</li>
            </ol>
        </nav>
        <h1>Show Bug</h1>
        <p>{bug}</p>
    |]
