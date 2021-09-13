-- Modifications copyright (C) 2021 Peter Andersen
{ name = "halogen-template-extended"
, packages = ./packages.dhall
, sources =
    [ "src/**/*.purs"
    ]
, dependencies =
    [ "aff"
    , "arrays"
    , "bifunctors"
    , "const"
    , "effect"
    , "either"
    , "foldable-traversable"
    , "halogen"
    , "halogen-store"
    , "maybe"
    , "newtype"
    , "prelude"
    , "psci-support"
    , "routing"
    , "routing-duplex"
    , "safe-coerce"
    , "transformers"
    , "web-events"
    , "web-uievents"
    ]
}
