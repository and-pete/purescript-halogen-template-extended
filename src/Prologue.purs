-- | Custom prelude module
module Prologue
  ( module Prelude
  
  , module Data.Bifunctor
  , module Data.Const
  , module Data.Either
  , module Data.Foldable
  , module Data.Maybe
  , module Data.Newtype
  , module Data.Traversable
  , module Effect
  , module Effect.Class
  , module Effect.Aff
  , module Effect.Aff.Class
  , module Safe.Coerce
  , module Type.Proxy
  ) where

import Prelude

-- | This explicit import list cover more classes / types / functions
-- | than are used by this template project. They are provided for
-- | convenience as they have a good chance of being used as a project
-- | based on this template grows larger.

-- | If you define helpers in this custom prelude, they can be exported
-- | individually or by rexporting `module Prologue` in its entirety

import Data.Bifunctor (class Bifunctor, bimap, lmap, rmap)
import Data.Const (Const(..))
import Data.Either (Either(..), either, fromLeft, fromLeft', fromRight, fromRight', hush, isLeft, isRight, note, note')
import Data.Foldable (class Foldable, foldr, foldl, foldMap, fold, foldM, for_, sequence_, traverse_)
import Data.Maybe (Maybe(..), fromMaybe, isNothing, isJust, maybe)
import Data.Newtype (class Newtype, wrap, un, unwrap)
import Data.Traversable (class Traversable, for, sequence, traverse)
import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import Effect.Aff.Class (class MonadAff, liftAff)
import Effect.Class (class MonadEffect, liftEffect)
import Safe.Coerce (class Coercible, coerce)
import Type.Proxy (Proxy(..))