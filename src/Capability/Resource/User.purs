-- | See comments in purescript-halogen-realworld's `Conduit.Capability.Resource.User` module:
-- | https://github.com/thomashoneyman/purescript-halogen-realworld/blob/main/src/Capability/Resource/User.purs

module Capability.Resource.User where

import Prologue

import Halogen as H

import Data.Profile (Profile)
import Data.Username (Username)

class Monad m <= MonadUser m where
  loginUser :: Username -> m (Maybe Profile)

instance MonadUser m => MonadUser ( H.HalogenM state action slots msg m ) where
  loginUser = H.lift <<< loginUser