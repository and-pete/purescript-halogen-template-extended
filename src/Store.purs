-- | See comments in purescript-halogen-realworld's `Conduit.Store` module:
-- | https://github.com/thomashoneyman/purescript-halogen-realworld/blob/main/src/Store.purs

module Store where

import Prologue

import Control.Monad.State (class MonadState)
import Halogen as H

import Data.Profile (Profile)

type Store =
  { currentUser :: Maybe Profile
  }

data Action
  = LoginUser Profile
  | LogoutUser

reduce :: Store -> Action -> Store
reduce store = case _ of
  LoginUser profile ->
    store { currentUser = Just profile }

  LogoutUser ->
    store { currentUser = Nothing }

-- | Helper used in the `Store`-connected components (`Router`, `Home`
-- | and `Secrets`) to respond to changes in the global state
updateLocalState
  :: forall m rs ri
   . MonadState { currentUser :: Maybe Profile | rs } m
  => { context :: Maybe Profile | ri }
  -> m Unit
updateLocalState { context: newUser } = do
  oldUser <- H.gets _.currentUser
  when (oldUser /= newUser) do
    H.modify_ _ { currentUser = newUser }