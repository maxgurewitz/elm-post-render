module Main where

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class)
import Effects as FX
import List
import Signal
import StartApp
import Task exposing (Task)

port setFocus : Signal Int
port setFocus =
  Signal.map
    .renderedCount
    app.model
  |> Signal.dropRepeats

port tasks : Signal (Task FX.Never ())
port tasks = app.tasks

main = app.html

app =
  StartApp.start
    { init = init
    , update = update
    , view = view
    , inputs = []
    }

type alias Model =
  { count : Int
  , renderedCount : Int
  }

onRenderIncrement = FX.tick (always RenderedIncrement)

init =
  ({ count = 1
  , renderedCount = 0
  }
  , onRenderIncrement
  )

incrementTask = FX.task (Task.succeed Increment)

view address model =
  let
    incrementButton = button [ onClick address Increment ] [ text "increment" ]
    boxes =
      List.repeat
        model.count
        (input
          [ class "box" ]
          []
        )
  in
    div
      []
      (incrementButton :: boxes)


type Action = Increment | RenderedIncrement

update action model =
  case action of
    Increment ->
      ({ model
          | count = model.count + 1
      }
      , onRenderIncrement
      )
    RenderedIncrement ->
      ({ model
          | renderedCount = model.count
      }
      , FX.none
      )

