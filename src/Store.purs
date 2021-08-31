-- | See comments in purescript-halogen-realworld's `Conduit.Store` module:
-- | https://github.com/thomashoneyman/purescript-halogen-realworld/blob/main/src/Store.purs

module App.Store where

import Prologue

import Data.Array as A
import Control.Monad.State (class MonadState)
import Halogen as H

import App.Data.Profile (Profile)

type Store =
  { currentUser :: Maybe Profile
  , recentMessageLog :: Array String
  }

data Action
  = LoginUser Profile
  | LogoutUser
  | UpdateMessageLog String

reduce :: Store -> Action -> Store
reduce store = case _ of
  LoginUser profile ->
    store { currentUser = Just profile }

  LogoutUser ->
    store { currentUser = Nothing }
  
  UpdateMessageLog msg ->
    let
      -- Limits the nnumber of recent messages to 10
      prependMessage :: String -> Array String -> Array String
      prependMessage x xs
        | A.length xs < 10 = x `A.cons` xs
        | otherwise        = x `A.cons` (A.take 9 xs)
    in
      store { recentMessageLog = msg `prependMessage` store.recentMessageLog }

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