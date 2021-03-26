module Web.View.Spells.New where
import Web.View.Prelude

data NewView = NewView { spell :: Spell }

instance View NewView where
    html NewView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={SpellsAction}>Spells</a></li>
                <li class="breadcrumb-item active">New Spell</li>
            </ol>
        </nav>
        <h1>New Spell</h1>
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
