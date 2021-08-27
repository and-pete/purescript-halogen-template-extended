-- | Custom prelude module
module Prologue
  ( module Prelude
  , module Prologue
  , module Data.Bifunctor
  , module Data.Const
  , module Data.Either
  , module Data.Foldable
  , module Data.Maybe
  , module Data.Newtype
  , module Data.Traversable
  , module Data.Void
  , module Effect
  , module Effect.Class
  , module Effect.Aff
  , module Effect.Aff.Class
  , module Type.Proxy
  ) where

import Prelude hiding ((/))

import Data.Bifunctor
import Data.Const
import Data.Either
import Data.Foldable
import Data.Maybe
import Data.Newtype (class Newtype, unwrap)
import Data.Void
import Data.Traversable
import Effect
import Effect.Class
import Effect.Aff
import Effect.Aff.Class
import Type.Proxy