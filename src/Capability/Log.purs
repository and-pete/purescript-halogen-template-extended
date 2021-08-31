-- | A logger capability whose `AppM` implementation will add another string to
-- | the fake console rendered by the Router component. Just to keep the compl-
-- | -exity down of this repo.

-- | See comments in purescript-halogen-realworld's `Conduit.Capability.LogMessage` module:
-- | https://github.com/thomashoneyman/purescript-halogen-realworld/blob/main/src/Capability/LogMessages.purs
-- | and comments in:
-- | https://github.com/thomashoneyman/purescript-halogen-realworld/blob/main/src/Data/Log.purs

module App.Capability.Log where

import Prologue

import Halogen as H

class Monad m <= MonadLog m where
  logMessage :: String -> m Unit

instance MonadLog m => MonadLog ( H.HalogenM state action slots msg m ) where
  logMessage = H.lift <<< logMessage
