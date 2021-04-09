module Web.FrontController where

import IHP.RouterPrelude
import Web.Controller.Prelude
import Web.View.Layout (defaultLayout)

-- Controller Imports
import Web.Controller.Bugs
import Web.Controller.Users
import Web.Controller.Specs
import Web.Controller.Static
import Web.Controller.Sessions
import IHP.LoginSupport.Middleware
import Web.Controller.Sessions



instance FrontController WebApplication where
    controllers = 
        [ startPage WelcomeAction
        -- Generator Marker
        , parseRoute @BugsController
        , parseRoute @UsersController
        , parseRoute @SpecsController
        , parseRoute @SessionsController
        ]

        
instance InitControllerContext WebApplication where
    initContext = do
        setLayout defaultLayout
        initAutoRefresh
        initAuthentication @User
