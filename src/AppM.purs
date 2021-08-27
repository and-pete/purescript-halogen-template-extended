-- | See comments in purescript-halogen-realworld's `Conduit.AppM` module:
-- | https://github.com/thomashoneyman/purescript-halogen-realworld/blob/main/src/AppM.purs

module AppM where

import Prologue

import Halogen as H
import Halogen.Store.Monad (class MonadStore)
import Halogen.Store.Monad as HSM
import Routing.Duplex as RD
import Routing.Hash as RH

import Capability.Navigate (class MonadNavigate, navigate)
import Capability.Resource.User (class MonadUser)
import Data.Username (Username)
import Data.Profile (Profile)
import Data.Route (Route(..), routeCodec)
import Store as Store
import Store (Store)

newtype AppM a = AppM (HSM.StoreT Store.Action Store Aff a)

runAppM :: forall q i o. Store -> H.Component q i o AppM -> Aff (H.Component q i o Aff)
runAppM initialStore =
  HSM.runStoreT initialStore Store.reduce <<< H.hoist (\(AppM m) -> m )

derive newtype instance functorAppM :: Functor AppM
derive newtype instance applyAppM :: Apply AppM
derive newtype instance applicativeAppM :: Applicative AppM
derive newtype instance bindAppM :: Bind AppM
derive newtype instance monadAppM :: Monad AppM
derive newtype instance monadEffectAppM :: MonadEffect AppM
derive newtype instance monadAffAppM :: MonadAff AppM
derive newtype instance monadStoreAppM :: MonadStore Store.Action Store AppM

-- | Instances of the `MonadNavigate` and `MonadUser` classes for
-- | our production AppM monad
instance MonadNavigate AppM where
  navigate :: Route -> AppM Unit
  navigate = liftEffect <<< RH.setHash <<< RD.print routeCodec
    
  logoutUser :: AppM Unit
  logoutUser = do
    HSM.updateStore Store.LogoutUser
    navigate Home

instance MonadUser AppM where
  -- | The return type is `Maybe Profile` to account for
  -- | potential authentication failures beyond the scope
  -- | of this Gist.
  loginUser :: Username -> AppM (Maybe Profile)
  loginUser username = do
    let profile = { username }
    HSM.updateStore $ Store.LoginUser profile
    pure (Just profile)
