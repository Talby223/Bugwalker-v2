module Web.View.Specs.Index where
import Web.View.Prelude

data IndexView = IndexView { specs :: [Spec] }

instance View IndexView where
    html IndexView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item active"><a href={SpecsAction}>Specs</a></li>
            </ol>
        </nav>
        <h1>Specs <a href={pathTo NewSpecAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>GameId</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach specs renderSpec}</tbody>
            </table>
        </div>
    |]


renderSpec spec = [hsx|
    <tr>
        <td><a href={ShowSpecAction (get #id spec)}>{get #gameId spec}</a></td>
        <td>{get #specName spec}</td>
        <td>{get #specDescription spec}</td>
        <td>
            <a href={EditSpecAction (get #id spec)} class="btn btn-primary btn-sm">
                <i class="fa fa-edit" />
            </a>
        </td> 
        <td><a href={DeleteSpecAction (get #id spec)} class="js-delete btn btn-danger btn-sm">
                <i class="fa fa-trash"/>
            </a>
        </td>
    </tr>
|]
