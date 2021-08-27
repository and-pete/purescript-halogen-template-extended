# Halogen Template (Extended)

..."extended" with SPA-like routing and a global store carrying the logged-in/logged-out state of a nominal user.

### Quick Start
```sh
git clone https://github.com/and-pete/purescript-halogen-template-extended halogen-project
cd halogen-project
npm install
npm run build
npm run serve
```

## Introduction (`and-pete/purescript-halogen-template-extended`)

This project can be viewed as either a fork/clone of [purescript-halogen-template](https://github.com/purescript-halogen/purescript-halogen-template) with extra features or as a fork/clone of [Real World Halogen](https://github.com/thomashoneyman/purescript-halogen-realworld) with the majority of its features stripped out.

The [purescript-halogen-template](https://github.com/purescript-halogen/purescript-halogen-template) repo is a fantastic place to start if today is Day #1 for you with Purescript's Halogen framework. I have included the rest of `purescript-halogen-template`'s README (as at 2021-08-27) below also under the heading "Introduction (purescript-halogen-template)", modified to reflect the build instructions for this project.

The primary purpose of this extended template is to add two key features from Thomas Honeyman's excellent [Real World Halogen](https://github.com/thomashoneyman/purescript-halogen-realworld) SPA app. Namely:
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

The original [purescript-halogen-template](https://github.com/purescript-halogen/purescript-halogen-template) README is included below. If this is Day #1 of Halogen for you, you should start with that simpler repository (...and of course with the [official PureScript Halogen Guide](https://purescript-halogen.github.io/purescript-halogen/)).

---

## Introduction (`purescript-halogen-template`)

This project is a template for starting a fresh project with the [Halogen](https://github.com/purescript-halogen/purescript-halogen) library for writing declarative, type-safe user interfaces.

You can learn more about Halogen with these resources:

- The [Halogen documentation](https://github.com/purescript-halogen/purescript-halogen/tree/master/docs), which includes a quick start guide and a concepts reference.
- The [Learn Halogen](https://github.com/jordanmartinez/learn-halogen) learning repository.
- The [Real World Halogen](https://github.com/thomashoneyman/purescript-halogen-realworld) application and guide. Note that the published article is written for the older halogen v4, but the code and comments cover the current halogen v5.
- The [API documentation](https://pursuit.purescript.org/packages/purescript-halogen) on Pursuit

You can chat with other Halogen users on the [PureScript Discourse](https://discourse.purescript.org), or join the [Functional Programming Slack](https://functionalprogramming.slack.com) ([invite link](https://fpchat-invite.herokuapp.com/)) in the `#purescript` and `#purescript-beginners` channels.

If you notice any problems with the below setup instructions, or have suggestions on how to make the new-user experience any smoother, please create an issue or pull-request.

Compatible with 0.14.4 of the PureScript compiler.

### Initial Setup

**Prerequisites:** This template assumes you already have Git and Node.js installed with `npm` somewhere on your path.

First, clone the repository and step into it:

```sh
git clone https://github.com/and-pete/purescript-halogen-template-extended.git halogen-project
cd halogen-project
```

Then, install the PureScript compiler, the [Spago](https://github.com/purescript/spago) package manager and build tool, and the [Parcel](https://github.com/parcel-bundler/parcel) bundler. You may either install PureScript tooling _globally_, to reduce duplicated `node_modules` across projects, or _locally_, so that each project uses specific versions of the tools.

To install the toolchain globally:
```sh
npm install -g purescript spago parcel
```

To install the toolchain locally (reads `devDependencies` from `package.json`):
```sh
npm install
```

### Building

You can now build the PureScript source code with:

```sh
# An alias for `spago build`
npm run build
```

### Launching the App

You can launch your app in the browser with:

```sh
# An alias for `parcel dev/index.html --out-dir dev-dist --open`
npm run serve
```

### Development Cycle

If you're using an [editor](https://github.com/purescript/documentation/blob/master/ecosystem/Editor-and-tool-support.md#editors) that supports [`purs ide`](https://github.com/purescript/purescript/tree/master/psc-ide) or are running [`pscid`](https://github.com/kRITZCREEK/pscid), you simply need to keep the previous `npm run serve` command running in a terminal. Any save to a file will trigger an incremental recompilation, rebundle, and web page refresh, so you can immediately see your changes.

If your workflow does not support automatic recompilation, then you will need to manually re-run `npm run build`. Even with automatic recompilation, a manual rebuild is occasionally required, such as when you add, remove, or modify module names, or notice any other unexpected behavior.

### Production

When you are ready to create a minified bundle for deployment, run the following command:
```sh
npm run build-prod
```

Parcel output appears in the `./dist/` directory.

You can test the production output locally with a tool like [`http-server`](https://github.com/http-party/http-server#installation). It seems that `parcel` should also be able to accomplish this, but it unfortunately will only serve development builds locally.
```sh
npm install -g http-server
http-server dist -o
```

If everything looks good, you can then upload the contents of `dist` to your preferred static hosting service.
