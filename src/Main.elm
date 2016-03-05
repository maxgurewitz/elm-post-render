module Main where

import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class)
import Effects as FX
import List
import Signal
import StartApp
import Debug



import Task

-- port setFocus : Signal Int
-- port setFocus = Signal.map .renderedCount app.model

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

onRenderIncrement = FX.tick
  (\_ ->
    let _ = Debug.log "loc1" "loc2"
    in RenderedIncrement)

init =
  ({ count = 1
  , renderedCount = 0
  }
  -- , onRenderIncrement
  , incrementTask
  )

incrementTask = FX.task (Task.succeed Increment)

view address model =
  let
    _ = Debug.log "boop" "bam"
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
      let
        _ = Debug.log "moop" "doop"
      in
        ({ model
            | count = model.count + 1
        }
        , onRenderIncrement
        )
    RenderedIncrement ->
      let
        _ = Debug.log "foo" "bar"
      in
        ({ model
            | renderedCount = model.count
        }
        , FX.none
        )

