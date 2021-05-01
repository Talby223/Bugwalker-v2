module Web.Controller.Sessions where

import Web.Controller.Prelude
import Web.View.Sessions.New
import qualified IHP.AuthSupport.Controller.Sessions as Sessions

instance Controller SessionsController where
    action NewSessionAction = Sessions.newSessionAction @Admin
    action CreateSessionAction = Sessions.createSessionAction @Admin
    action DeleteSessionAction = Sessions.deleteSessionAction @Admin

instance Sessions.SessionsControllerConfig Admin