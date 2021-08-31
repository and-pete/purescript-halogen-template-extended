module App.Component.HTML.Navbar
  ( navbarPageWrapper
  ) where

import Prologue

import Halogen.HTML as HH
import Halogen.HTML.Properties as HP

import App.Data.Profile (Profile)
import App.Data.Route (Route(..))
import App.Component.HTML.Util (navItem, whenElem)

            
navbarPageWrapper
  :: forall w i r
   . { currentUser :: Maybe Profile, messageLog :: Array String | r }
  -> HH.HTML w i
  -> HH.HTML w i
navbarPageWrapper { currentUser, messageLog } innerHtml =
  HH.div
    [ HP.style wrapperStyle ]
    [ HH.div_ [ navbar, innerHtml ]
    , HH.div_ [ HH.hr_, fakeConsole messageLog ]
    ] 
  where
    navbar :: HH.HTML w i
    navbar =
      HH.ul_
        [ navItem Home "Home"

        , whenElem (isNothing currentUser) \_ ->
            navItem Login "Log in"

        , whenElem (isJust currentUser) \_ ->
            navItem Secrets "Secrets"
        ]

    fakeConsole :: Array String -> HH.HTML w i
    fakeConsole messages =
      HH.div
        [ HP.style consoleStyle  ]
        [ HH.h2 [ HP.style "font-variant: small-caps;"  ] [ HH.text "Fake Console: " ]
        , HH.ul_ $ map (\msg -> HH.li_ [ HH.text msg ]) messages
        ]

wrapperStyle :: String
wrapperStyle = 
  """
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  height: calc(100vh - 18px)
  """

consoleStyle :: String
consoleStyle =
  """
  min-height: 275px;
  background: #282c34;
  color: #e06c75;
  font-family: 'Consolas';
  padding: 5px 20px 5px 20px;
  """