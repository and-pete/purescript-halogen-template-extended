-- | See comments in purescript-halogen-realworld's `Conduit.Capability.Navigate` module:
-- | https://github.com/thomashoneyman/purescript-halogen-realworld/blob/main/src/Capability/Navigate.purs

module App.Capability.Navigate where

import Prologue

import Halogen as H

import App.Data.Route (Route)


class Monad m <= MonadNavigate m where
  navigate :: Route -> m Unit
  logoutUser :: m Unit

instance MonadNavigate m => MonadNavigate ( H.HalogenM state action slots msg m ) where
  navigate = H.lift <<< navigate
  logoutUser = H.lift logoutUser
