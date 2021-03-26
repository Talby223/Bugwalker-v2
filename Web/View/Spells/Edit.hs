module Web.View.Spells.Edit where
import Web.View.Prelude

data EditView = EditView { spell :: Spell }

instance View EditView where
    html EditView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={SpellsAction}>Spells</a></li>
                <li class="breadcrumb-item active">Edit Spell</li>
            </ol>
        </nav>
        <h1>Edit Spell</h1>
        {renderForm spell}
    |]

renderForm :: Spell -> Html
renderForm spell = formFor spell [hsx|
    {(textField #buildId)}
    {(textField #gameId)}
    {(textField #spellName)}
    {(textField #spellDescription)}
    {(textField #spellIcon)}
    {(textField #specIds)}
    {submitButton}
|]
