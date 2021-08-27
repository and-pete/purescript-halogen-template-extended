-- | See comments in purescript-halogen-realworld (RHW)'s `Conduit.Data.Profile` module:
-- | https://github.com/thomashoneyman/purescript-halogen-realworld/blob/main/src/Data/Profile.purs

-- | This is intentionally very stripped down from the RWH `Profile` module, to keep the focus here
-- | on the bare minimum required for SPA page routing and on having a global `Store` carrying the
-- | currently logged-in user's `Profile`.

module App.Data.Profile where

import App.Data.Username (Username)

type Profile =
  { username :: Username
  }
