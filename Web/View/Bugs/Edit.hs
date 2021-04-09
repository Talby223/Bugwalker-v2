module Web.View.Bugs.Edit where
import Web.View.Prelude

data EditView = EditView { bug :: Bug }

instance View EditView where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={BugsAction}>Bugs</a></li>
                <li class="breadcrumb-item active">Edit Bug</li>
            </ol>
        </nav>
        <h1>Edit Bug</h1>
        {renderForm bug}
    |]

renderForm :: Bug -> Html
renderForm bug = formFor bug [hsx|
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
