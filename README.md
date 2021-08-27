# Halogen Template (Extended)

..."extended" with SPA-like routing and a global store carrying the logged-in/logged-out state of a nominal user.

### Quick Start
```sh
git clone https://github.com/and-pete/purescript-halogen-template-extended.git halogen-project
cd halogen-project
npm install
npm run build
npm run serve
```

## Introduction (`and-pete/purescript-halogen-template-extended`)

This project can be viewed as either a fork/clone of [purescript-halogen-template](https://github.com/purescript-halogen/purescript-halogen-template) with extra features or as a fork/clone of [Real World Halogen](https://github.com/thomashoneyman/purescript-halogen-realworld) with the majority of its features stripped out.

The [purescript-halogen-template](https://github.com/purescript-halogen/purescript-halogen-template) repo is a fantastic place to start if today is Day #1 for you with Purescript's Halogen framework.

The primary purpose of this extended template is to demonstrate just two centrall features from Thomas Honeyman's excellent [Real World Halogen](https://github.com/thomashoneyman/purescript-halogen-realworld) app. Namely:
  - Hash-based routing & navigation (using [PureScript Routing Duplex](https://github.com/natefaubion/purescript-routing-duplex))
  - A global `Store` containing the profile of the currently logged-in user (using [PureScript Halogen Store](https://github.com/thomashoneyman/purescript-halogen-store))

There are 4 components in this project: a parent [Component.Router](https://github.com/and-pete/purescript-halogen-template-extended/blob/main/src/Component/Router.purs) module that has 3 child routes that each correspond to a "page" of the site.

These 3 child pages are the following:
  1) [Page.Home](https://github.com/and-pete/purescript-halogen-template-extended/blob/main/src/Page/Home.purs) (displays to all users)
  2) [Page.Login](https://github.com/and-pete/purescript-halogen-template-extended/blob/main/src/Page/Login.purs) (displays only to users that are logged out)
  3) [Page.Secrets](https://github.com/and-pete/purescript-halogen-template-extended/blob/main/src/Page/Secrets.purs) (displays only to users that are logged in)

The app's global state (i.e. [Store](https://github.com/and-pete/purescript-halogen-template-extended/blob/main/src/Store.purs)) (currently) contains only the logged-in/out state of the user. Through use of the [PureScript Halogen Store](https://github.com/thomashoneyman/purescript-halogen-store) library, the `Component.Router`, `Page.Home` and `Page.Secrets` components are connected to this global `Store` and each receive as input the new value of this state each time it changes. These components theen use this new input to update the copy of the user's profile in their own internal component state and then render themselves accordingly.

The `Page.Login` component, however, is not connected to the store.

Many modules in this template project will link directly to the corresponding module in Thomas's [Real World Halogen](https://github.com/thomashoneyman/purescript-halogen-realworld) project, where you can find his comments (`Main` and `Conduit.AppM` are good places to start). This `purescript-halogen-tempalte-extended` repositary is meant to be a cookbook-style template, so I have not included much in the way of comments (other than notes to myself).

There are many features of the [Real World Halogen](https://github.com/thomashoneyman/purescript-halogen-realworld) project that are beyond the scope of this extended template. For example:
  - Sending requests to a server using [purescript-affjax](https://pursuit.purescript.org/packages/purescript-affjax)
  - Encoding/decoding JSON using [purescript-codec-argonaut](https://pursuit.purescript.org/packages/purescript-codec-argonaut)
  - Proper forms and validation using [purescript-halogen-formless (Formless)](https://pursuit.purescript.org/packages/purescript-halogen-formless)
  - Integrating JavaScript libraries into your project using PureScript's FFI ("Foreign Function Interface")
  - Logging
  - How to integrate an interface (or "Capability") for CRUD-style operations

### TODO

  1)  Delete or improve the silly fake console that logs the route changes

Comments, feedback, etc. are all always welcome.

Enoy! -Peter :)

<!-- Modifications copyright (C) 2021 Peter Andersen -->