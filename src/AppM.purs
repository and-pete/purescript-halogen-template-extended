-- | See comments in purescript-halogen-realworld's `Conduit.AppM` module:
-- | https://github.com/thomashoneyman/purescript-halogen-realworld/blob/main/src/AppM.purs

module App.AppM where

import Prologue

import Halogen as H
import Halogen.Store.Monad (class MonadStore, StoreT)
import Halogen.Store.Monad as HSM
import Routing.Duplex as RD
import Routing.Hash as RH

import App.Capability.Navigate (class MonadNavigate, navigate)
import App.Capability.Log (class MonadLog, logMessage)
import App.Capability.Resource.User (class MonadUser)
import App.Data.Username (Username)
import App.Data.Profile (Profile)
import App.Data.Route (Route(..), routeCodec)
import App.Store as Store
import App.Store (Store, Action(..))

-- | Production monad
newtype AppM a = AppM (StoreT Action Store Aff a)

runAppM :: forall q i o. Store -> H.Component q i o AppM -> Aff (H.Component q i o Aff)
runAppM initialStore =
  HSM.runStoreT initialStore Store.reduce <<< H.hoist (\(AppM m) -> m )

-- | `AppM` monad instances for classes from external libraries
derive newtype instance functorAppM :: Functor AppM
derive newtype instance applyAppM :: Apply AppM
derive newtype instance applicativeAppM :: Applicative AppM
derive newtype instance bindAppM :: Bind AppM
derive newtype instance monadAppM :: Monad AppM
derive newtype instance monadEffectAppM :: MonadEffect AppM
derive newtype instance monadAffAppM :: MonadAff AppM
derive newtype instance monadStoreAppM :: MonadStore Action Store AppM

-- | `AppM` monad instances for classes from internal `App.Capability.X` modules
instance MonadNavigate AppM where
  navigate :: Route -> AppM Unit
  navigate = liftEffect <<< RH.setHash <<< RD.print routeCodec
    
  logoutUser :: AppM Unit
  logoutUser = do
    HSM.updateStore LogoutUser
    navigate Home

instance MonadUser AppM where
  loginUser :: Username -> AppM (Maybe Profile)
  loginUser username = do
    let profile = { username }
    HSM.updateStore $ LoginUser profile
    pure (Just profile)

instance MonadLog AppM where
  logMessage :: String -> AppM Unit
  logMessage msg = do
    HSM.updateStore $ UpdateMessageLog msg