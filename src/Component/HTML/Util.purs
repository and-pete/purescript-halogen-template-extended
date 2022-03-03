-- | See comments in purescript-halogen-realworld's `Conduit.Component.HTML.Utils` module:
-- | https://github.com/thomashoneyman/purescript-halogen-realworld/blob/main/src/Component/HTML/Utils.purs

module App.Component.HTML.Util
  ( maybeElem
  , safeHref
  , whenElem
  )
  where

import Prologue

import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Routing.Duplex as RD

import App.Data.Route (Route, routeCodec)

safeHref :: forall r i. Route -> HH.IProp ( href :: String | r) i
safeHref = HP.href <<< append "#" <<< RD.print routeCodec

whenElem :: forall w i. Boolean -> (Unit -> HH.HTML w i) -> HH.HTML w i
whenElem cond f = if cond then f unit else HH.text ""

maybeElem :: forall w i a. Maybe a -> (a -> HH.HTML w i) -> HH.HTML w i
maybeElem (Just x) f = f x
maybeElem _ _ = HH.text ""