module App.Page.Home
  ( Slot
  , component
  )
  where

import Prologue

import Halogen as H
import Halogen.HTML as HH
import Halogen.Store.Connect as HSC
import Halogen.Store.Monad (class MonadStore)
import Halogen.Store.Select as HSS

import App.Data.Username as Username
import App.Data.Profile (Profile)
import App.Store (Store)
import App.Store as Store

type Context = Maybe Profile
type Input = Unit
type ConnectedInput = HSC.Connected Context Input

type State =
  { currentUser :: Maybe Profile
  }

data Action
  = Receive { context :: Context, input :: Input } -- i.e. `Receive ConnectedInput`

type Slot = H.Slot (Const Void) Void Unit

component
  :: forall m q o
   . MonadEffect m
  => MonadStore Store.Action Store m
  => H.Component q Input o m
component =
  HSC.connect (HSS.selectEq _.currentUser) $ 
    H.mkComponent { initialState, render, eval }
  where
  
    initialState :: ConnectedInput -> State
    initialState =
      \{ context: currentUser } ->
        { currentUser
        }
    
    eval = H.mkEval H.defaultEval
      { handleAction = handleAction
      , receive = (Just <<< Receive) :: ConnectedInput -> Maybe Action
      }

    render :: State -> H.ComponentHTML Action () m
    render { currentUser } =
      HH.div_
        [ HH.h1_ [ HH.text "Home page" ]
        , content
        ]      
      where
      content = case currentUser of
        Nothing ->
          HH.p_ [ HH.text "Welcome, guest. Perhaps consider logging in?" ]
        Just profile ->
          HH.div_
            [ HH.p_
                [ HH.text ("WELCOME BACK, " <> Username.toString profile.username <> "!")
                ]
            , HH.p_
                [ HH.strong_
                  [ HH.text "Your secrets page (🕵) is now available via the navigation bar."
                  ]
                ]
            , HH.p_
                [ HH.text "On the secrets page, you can also sign out from this session"
                ]
            ]

    handleAction
      :: Action
      -> H.HalogenM State Action () o m Unit
    handleAction = case _ of
      Receive connectedInput ->
        Store.updateLocalState connectedInput