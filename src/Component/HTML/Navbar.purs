module App.Component.HTML.Navbar
  ( navbarPageWrapper
  ) where

import Prologue

import Halogen.HTML as HH
import Halogen.HTML.Properties as HP

import App.Data.Profile (Profile)
import App.Data.Route (Route(..))
import App.Component.HTML.Util (safeHref, whenElem)
import App.Component.HTML.Style.Navbar
  ( loggerCSS
  , mainAreaStyle
  , navCSS
  , navItemCSS
  , navListCSS
  , wrapperCSS
  )            

navbarPageWrapper
  :: forall w i r
   . { currentUser :: Maybe Profile, consoleHistory :: Array String, route :: Maybe Route | r }
  -> HH.HTML w i
  -> HH.HTML w i
navbarPageWrapper { currentUser, consoleHistory, route } innerHtml =
  HH.div
    [ HP.style (wrapperCSS route) ]
    [ HH.div
        [ HP.style mainAreaStyle ]
        [ navbar currentUser
        , innerHtml
        ]
    , HH.div_
        [ HH.hr_
        , logOutputPanel consoleHistory
        ]
    ]

navbar :: forall w i. Maybe Profile -> HH.HTML w i
navbar currentUser =
  HH.nav
  [ HP.style navCSS
  ]
  [ HH.ul
      [ HP.style navListCSS ]
      [ navItem Home "🏡" "Home"

      , whenElem (isNothing currentUser) \_ ->
          navItem Login "🔑" "Log in"

      , whenElem (isJust currentUser) \_ ->
          navItem Secrets "🕵" "Secrets️"
      ]
  ]

navItem :: forall w i. Route -> String -> String -> HH.HTML w i
navItem route emoji label =
  HH.li
    [ HP.style navItemCSS ]
    [ HH.text emoji
    , HH.a
        [ safeHref route, HP.style "margin-left: 0.25rem;" ]
        [ HH.text label ]
    ]


logOutputPanel :: forall w i. Array String -> HH.HTML w i
logOutputPanel msgs =
  HH.div
    [ HP.style loggerCSS  ]
    [ HH.h2_
        [ HH.text "Logger Output:" ]
    , HH.ul_
        (map (\x -> HH.li_ [ HH.text x ]) msgs)
    ]
