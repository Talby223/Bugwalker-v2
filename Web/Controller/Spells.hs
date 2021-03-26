module Web.Controller.Spells where

import Web.Controller.Prelude
import Web.View.Spells.Index
import Web.View.Spells.New
import Web.View.Spells.Edit
import Web.View.Spells.Show

instance Controller SpellsController where
    action SpellsAction = do
        spells <- query @Spell |> orderByAsc #gameId |> fetch
        render IndexView { .. }

    action NewSpellAction = do
        let spell = newRecord
        render NewView { .. }

    action ShowSpellAction { spellId } = do
        spell <- fetch spellId
        render ShowView { .. }

    action EditSpellAction { spellId } = do
        spell <- fetch spellId
        render EditView { .. }

    action UpdateSpellAction { spellId } = do
        spell <- fetch spellId
        spell
            |> buildSpell
            |> ifValid \case
                Left spell -> render EditView { .. }
                Right spell -> do
                    spell <- spell |> updateRecord
                    setSuccessMessage "Spell updated"
                    redirectTo EditSpellAction { .. }

    action CreateSpellAction = do
        let spell = newRecord @Spell
        spell
            |> buildSpell
            |> ifValid \case
                Left spell -> render NewView { .. } 
                Right spell -> do
                    spell <- spell |> createRecord
                    setSuccessMessage "Spell created"
                    redirectTo SpellsAction

    action DeleteSpellAction { spellId } = do
        spell <- fetch spellId
        deleteRecord spell
        setSuccessMessage "Spell deleted"
        redirectTo SpellsAction

buildSpell spell = spell
    |> fill @["buildId","gameId","spellName","spellDescription","spellIcon","specIds"]
