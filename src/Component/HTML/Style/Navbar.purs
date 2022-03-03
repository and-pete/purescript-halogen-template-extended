module App.Component.HTML.Style.Navbar
  ( loggerCSS
  , mainAreaStyle
  , navCSS
  , navItemCSS
  , navListCSS
  , wrapperCSS
  )
  where

import Prologue

import Data.String as String

import App.Data.Route (Route(..))

-------------
-- | Styling
-------------
-- | Some simple inline CSS (would normally use Bootstrap/etc)
wrapperCSS :: Maybe Route -> String
wrapperCSS = case _ of
  Just Home -> css "#d3dbff"
  Just Login -> css "#f1e2f8"
  Just Secrets -> css "#ffd3db"
  _ -> ""
  where
  css :: String -> String
  css c = String.joinWith "; "
    [ "background-color: " <> c
    , "display: flex"
    , "flex-direction: column"
    , "justify-content: space-between"
    , "height: calc(100vh - 18px)"
    , "font-family: Helvetica Neue, Helvetica, Arial, sans-serif;"
    ]

mainAreaStyle :: String
mainAreaStyle = String.joinWith ";"
  [ "padding: 0.5rem 1.5rem"
  ]

-- <nav>
navCSS :: String
navCSS = String.joinWith ";"
  [ "display: flex"
  , "list-style: none"
  , "border-bottom: 1px solid black"
  ]

-- <ul>
navListCSS :: String
navListCSS = String.joinWith ";"
  [ "list-style-type: none"
  , "padding-left: 0"
  ]

-- <li>
navItemCSS :: String
navItemCSS = String.joinWith ";"
  [ "display: inline-block"
  , "padding: .5em 1em"
  , "justify-content: space-between"
  ]

loggerCSS :: String
loggerCSS =
  """
  min-height: 275px;
  background: #282c34;
  color: #e06c75;
  font-family: 'Consolas';
  padding: 5px 20px 5px 20px;
  """


