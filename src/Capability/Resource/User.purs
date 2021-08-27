-- | See comments in purescript-halogen-realworld's `Conduit.Capability.Resource.User` module:
-- | https://github.com/thomashoneyman/purescript-halogen-realworld/blob/main/src/Capability/Resource/User.purs

module App.Capability.Resource.User where

import Prologue

import Halogen as H

import App.Data.Profile (Profile)
import App.Data.Username (Username)

class Monad m <= MonadUser m where
  loginUser :: Username -> m (Maybe Profile)

instance MonadUser m => MonadUser ( H.HalogenM state action slots msg m ) where
  loginUser = H.lift <<< loginUser