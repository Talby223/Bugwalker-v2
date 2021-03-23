module Web.View.Specs.New where
import Web.View.Prelude

data NewView = NewView { spec :: Spec }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={SpecsAction}>Specs</a></li>
                <li class="breadcrumb-item active">New Spec</li>
            </ol>
        </nav>
        <h1>New Spec</h1>
        {renderForm spec}
    |]

renderForm :: Spec -> Html
renderForm spec = formFor spec [hsx|
    {(textField #gameId)}
    {(textField #gameClassId)}
    {(textField #specName)}
    {(textField #specDescription)}
    {(textField #specIcon)}
    {submitButton}
|]
