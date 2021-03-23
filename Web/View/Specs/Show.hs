module Web.View.Specs.Show where
import Web.View.Prelude

data ShowView = ShowView { spec :: Spec }

instance View ShowView where
    html ShowView { .. } = [hsx|
        <nav>
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href={SpecsAction}>Specs</a></li>
                <li class="breadcrumb-item active">Show Spec</li>
            </ol>
        </nav>
        <h1>Show Spec</h1>
        <p>{spec}</p>
    |]
