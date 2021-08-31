module App.Page.Secrets where

import Prologue

import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.Store.Connect as HSC
import Halogen.Store.Monad (class MonadStore)
import Halogen.Store.Select as HSS
import Web.Event.Event as Event
import Web.UIEvent.MouseEvent (MouseEvent)
import Web.UIEvent.MouseEvent as MouseEvent

import App.Capability.Navigate (class MonadNavigate)
import App.Capability.Navigate as Navigate
import App.Capability.Log (class MonadLog, logMessage)
import App.Capability.Resource.User (class MonadUser)
import App.Component.HTML.Util (maybeElem)
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
  = Initialize
  | Receive { context :: Context, input :: Input }  -- i.e. `Receive ConnectedInput`
  | HandleLogout MouseEvent

type Slot = H.Slot (Const Void) Void Unit

component
  :: forall m q o
   . MonadStore Store.Action Store m
  => MonadLog m
  => MonadNavigate m
  => MonadUser m
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
        
    eval =
      H.mkEval H.defaultEval
        { handleAction = handleAction
        , initialize = Just Initialize
        , receive = (Just <<< Receive)  :: ConnectedInput -> Maybe Action
        }
    
    render :: State -> H.ComponentHTML Action () m
    render { currentUser } =
      maybeElem currentUser \profile -> do
        let name :: String
            name = Username.toString profile.username
        HH.div_
          [ HH.h1_ [ HH.text (name <> "'s page of secrets") ]
          , HH.p_ [ HH.text ("Hello, " <> name <> ".\n") ]
          , HH.p_ [ HH.text "Your Secret: `traverse`" ]
          , HH.button
            [ HE.onClick \mouseEvent -> HandleLogout mouseEvent ]
            [ HH.text "Sign out"
            ]
          ]

    handleAction
      :: Action
      -> H.HalogenM State Action () o m Unit
    handleAction = case _ of
      Initialize -> do
        H.gets _.currentUser >>= case _ of
          -- If the profile is `Nothing`, the user should not
          -- even see this page. Log them out as something
          -- has gone wrong.
          Nothing -> Navigate.logoutUser
          Just _ ->  pure unit

      Receive connectedInput -> do
        Store.updateLocalState connectedInput
        
      HandleLogout mouseEvent -> do
        H.liftEffect $ Event.preventDefault (MouseEvent.toEvent mouseEvent)
        logMessage "Signing out"
        Navigate.logoutUser
