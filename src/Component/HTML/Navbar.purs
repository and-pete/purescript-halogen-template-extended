module Component.HTML.Navbar
  ( navbarPageWrapper
  ) where

import Prologue

import Halogen.HTML as HH
import Halogen.HTML.Properties as HP

import Data.Profile (Profile)
import Data.Route (Route(..))
import Component.HTML.Util (navItem, whenElem)

            
navbarPageWrapper
  :: forall w i r
   . { currentUser :: Maybe Profile, changeLog :: Array String | r }
  -> HH.HTML w i
  -> HH.HTML w i
navbarPageWrapper { currentUser, changeLog } innerHtml =
  HH.div_
  [ HH.ul_
    [ navItem Home "Home"
    
    , whenElem (isNothing currentUser) \_ ->
        navItem Login "Log in"
        
    , whenElem (isJust currentUser) \_ ->
        navItem Secrets "Secrets"
   
    ]
  , HH.div_
      [ innerHtml
      , fakeConsole changeLog
      ]
  ]
  where
    fakeConsole :: Array String -> HH.HTML w i
    fakeConsole routeChangeLog =
      HH.div
       -- I (Peter) kind of whatevered the CSS here.
       -- Note to future self: stop reusing this.
       -- Do better. Be better.
       [ HP.style "margin-top: 300px; background: #282c34; color: #e06c75; padding-bottom: 200px"  ]
       [ HH.hr_
       , HH.div
           [ HP.style "font-family: 'Consolas'; padding-left: 20px;" ]
           [ HH.h2 [ HP.style "font-variant: small-caps;"  ] [ HH.text "Fake Console: " ]
           , HH.ul_ $ map (\msg -> HH.li_ [ HH.text msg ]) routeChangeLog
           ]
       ]
