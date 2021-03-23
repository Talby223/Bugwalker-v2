module Web.Job.RunGameAssetUpdate where
import Web.Controller.Prelude

instance Job RunGameAssetUpdateJob where
    perform RunGameAssetUpdateJob { .. } = do
        putStrLn "Hello World!"
