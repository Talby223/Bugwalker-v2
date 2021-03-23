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
        <h1>Index <a href={pathTo NewSpecAction} class="btn btn-primary ml-4">+ New</a></h1>
        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Spec</th>
                        <th></th>
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
        <td>{spec}</td>
        <td><a href={ShowSpecAction (get #id spec)}>Show</a></td>
        <td><a href={EditSpecAction (get #id spec)} class="text-muted">Edit</a></td>
        <td><a href={DeleteSpecAction (get #id spec)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
