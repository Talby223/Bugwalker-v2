module Web.View.Specs.Edit where
import Web.View.Prelude

data EditView = EditView { spec :: Spec }

instance View EditView where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={SpecsAction}>Specs</a></li>
                <li class="breadcrumb-item active">Edit Spec</li>
            </ol>
        </nav>
        <h1>Edit Spec</h1>
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
