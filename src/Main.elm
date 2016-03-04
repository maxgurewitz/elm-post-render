module Main where

import Html exposing (..)
import Html.Events exposing (onClick)
import Effects as FX
import StartApp

main = app.html

app =
  StartApp.start
    { init = init
    , update = update
    , view = view
    , inputs = []
    }

type alias Model = { count : Int }

init = ({ count = 1 }, FX.none)

view address model =
  div
    []
    [ text (toString model.count)
    , button [ onClick address Increment ] [ text "increment" ]
    ]

type Action = Increment

update action model =
  case action of
    Increment -> ({ model | count = model.count + 1 }, FX.none)
