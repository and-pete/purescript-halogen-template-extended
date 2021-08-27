{ name = "halogen-template-extended"
, packages = ./packages.dhall
, sources =
    [ "src/**/*.purs"
    ]
, dependencies =
    [ "aff"
    , "arrays"
    , "bifunctors"
    , "console"
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
    , "transformers"
    , "web-events"
    , "web-uievents"
    ]
}
