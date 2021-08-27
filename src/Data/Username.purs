-- | See comments in purescript-halogen-realworld (RHW)'s `Conduit.Data.Username` module:
-- | https://github.com/thomashoneyman/purescript-halogen-realworld/blob/main/src/Data/Username.purs

module Data.Username
  ( Username
  , parse
  , toString
  ) where

import Prologue

newtype Username = MkUsername String

-- | `Eq` instance is needed so that `Username` (and the larger `Profile` type)
-- | can be used with `Halogen.Store.Select.selectEq`
derive instance Eq Username

parse :: String -> Maybe Username
parse = case _ of
  ""  -> Nothing
  str -> Just (MkUsername str)

toString :: Username -> String
toString (MkUsername str) = str