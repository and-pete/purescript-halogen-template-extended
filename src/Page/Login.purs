module App.Page.Login where

import Prologue

import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Web.Event.Event as Event
import Web.UIEvent.MouseEvent (MouseEvent)
import Web.UIEvent.MouseEvent as MouseEvent

import App.Capability.Navigate (class MonadNavigate)
import App.Capability.Navigate as Navigate
import App.Capability.Resource.User (class MonadUser)
import App.Capability.Resource.User as User
import App.Data.Username as Username
import App.Data.Route (Route(..))

type Input = { redirect :: Boolean }

type State = { redirect :: Boolean }

data Action
  = HandleLogin MouseEvent String

type Slot = H.Slot (Const Void) Void Unit

component
  :: forall m q o
   . MonadEffect m
  => MonadNavigate m
  => MonadUser m
  => H.Component q Input o m
component =
  H.mkComponent { initialState, render, eval }
  where
    initialState :: Input -> State
    initialState = identity
    
    eval =
      H.mkEval H.defaultEval
        { handleAction = handleAction
        }
    
    render :: State -> H.ComponentHTML Action () m
    render _ =
      HH.div_
        [ HH.h1_ [ HH.text "Sign in" ]
        , HH.p_ [ HH.text "Please only click the button below if you are actually 'bloodninja'" ]
        , HH.button
          [ HE.onClick \mouseEvent -> HandleLogin mouseEvent hardcodedUsername
          ]
          [ HH.text "Sign in as user 'bloodninja'"
          ]
        ]
      where
      -- To keep it simple, I chose not to include any validation 
      -- or Formless forms in this example. Or even a normal form
      -- input. Just a single button sending a hardcoded username :)
      hardcodedUsername :: String
      hardcodedUsername = "bloodninja"
        
    handleAction
      :: Action
      -> H.HalogenM State Action () o m Unit
    handleAction = case _ of

      HandleLogin mouseEvent rawUsername -> do
        H.liftEffect $ Event.preventDefault (MouseEvent.toEvent mouseEvent)
        case Username.parse rawUsername of
          Nothing -> pure unit
          Just username -> do
            _ <- User.loginUser username
            shouldRedirect <- H.gets _.redirect
            when shouldRedirect $ Navigate.navigate Home