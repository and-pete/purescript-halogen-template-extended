-- | See comments in purescript-halogen-realworld's `Main` module:
-- | https://github.com/thomashoneyman/purescript-halogen-realworld/blob/main/src/Main.purs

-- | Modifications copyright (C) 2021 Peter Andersen

module Main where

import Prologue

import Halogen as H
import Halogen.Aff as HA
import Halogen.VDom.Driver (runUI)
import Routing.Hash as RH
import Routing.Duplex as RD

import App.AppM (runAppM)
import App.Component.Router as Router
import App.Data.Route (routeCodec)

main :: Effect Unit
main = HA.runHalogenAff do
  body <- HA.awaitBody
  
  let
    initialStore = { currentUser: Nothing }
    routerInput = unit
    
  componentAff <- runAppM initialStore Router.component

  halogenIO <- runUI componentAff routerInput body

  -- Listens to the route changes and tells the router component
  void $ liftEffect $ RH.matchesWith ( RD.parse routeCodec ) \mOld new ->
    when ( mOld /= Just new ) do
      launchAff_ $ halogenIO.query $ H.mkTell $ Router.Navigate new   
