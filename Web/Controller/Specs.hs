module Web.Controller.Specs where

import Web.Controller.Prelude
import Web.View.Specs.Index
import Web.View.Specs.New
import Web.View.Specs.Edit
import Web.View.Specs.Show

instance Controller SpecsController where
    action SpecsAction = do
        specs <- query @Spec |> fetch
        render IndexView { .. }

    action NewSpecAction = do
        let spec = newRecord
        render NewView { .. }

    action ShowSpecAction { specId } = do
        spec <- fetch specId
        render ShowView { .. }

    action EditSpecAction { specId } = do
        spec <- fetch specId
        render EditView { .. }

    action UpdateSpecAction { specId } = do
        spec <- fetch specId
        spec
            |> buildSpec
            |> ifValid \case
                Left spec -> render EditView { .. }
                Right spec -> do
                    spec <- spec |> updateRecord
                    setSuccessMessage "Spec updated"
                    redirectTo EditSpecAction { .. }

    action CreateSpecAction = do
        let spec = newRecord @Spec
        spec
            |> buildSpec
            |> ifValid \case
                Left spec -> render NewView { .. } 
                Right spec -> do
                    spec <- spec |> createRecord
                    setSuccessMessage "Spec created"
                    redirectTo SpecsAction

    action DeleteSpecAction { specId } = do
        spec <- fetch specId
        deleteRecord spec
        setSuccessMessage "Spec deleted"
        redirectTo SpecsAction

buildSpec spec = spec
    |> fill @["gameId","gameClassId","specName","specDescription","specIcon"]
