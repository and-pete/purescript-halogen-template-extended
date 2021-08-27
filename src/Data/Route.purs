-- | See comments in purescript-halogen-realworld (RHW)'s `Conduit.Data.Route` module:
-- | https://github.com/thomashoneyman/purescript-halogen-realworld/blob/main/src/Data/Route.purs

module App.Data.Route where

import Prologue

import Data.Generic.Rep (class Generic)
import Data.Show.Generic (genericShow)
import Routing.Duplex ( RouteDuplex', root )
import Routing.Duplex.Generic as RDG
import Routing.Duplex.Generic (noArgs)
import Routing.Duplex.Generic.Syntax ((/))

data Route
  = Home
  | Login
  | Secrets

derive instance genericRoute :: Generic Route _
derive instance eqRoute :: Eq Route
derive instance ordRoute :: Ord Route

instance showRoute :: Show Route where
  show = genericShow

routeCodec :: RouteDuplex' Route
routeCodec = root $ RDG.sum
  { "Home": noArgs
  , "Login": "login" / noArgs
  , "Secrets": "secrets" / noArgs
  }