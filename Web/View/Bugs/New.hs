module Web.View.Bugs.New where
import Web.View.Prelude

data NewView = NewView { bug :: Bug }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={BugsAction}>Bugs</a></li>
                <li class="breadcrumb-item active">New Bug</li>
            </ol>
        </nav>
        <h1>New Bug</h1>
        {renderForm bug}
    |]

renderForm :: Bug -> Html
renderForm bug = formFor bug [hsx|
    {(textField #bugTitle)}
    {(textField #spellId)}
    {(textField #bugSeverity)}
    {(textField #bugType)}
    {(textField #bugStatus)}
    {(textField #bugTags)}
    {(textField #bugDescription)}
    {(textField #bugContent)}
    {(textField #bugBlueTrackerLink)}
    {(textField #userId)}
    {(textField #bugPinned)}
    {submitButton}
|]
