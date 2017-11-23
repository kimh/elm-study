import Collage exposing (..)
import Collage.Layout exposing (..)
import Collage.Render exposing (svg)
import Color exposing (..)
import Html exposing (Html, button, div)
import Html.Events exposing (onClick)
import List exposing (..)
import Debug exposing (..)
import Random

main =
  Html.beginnerProgram { model = model, view = view, update = update }

type alias Model =
    {step : Int,
     side : Float}

model =
    Model 0 1200

type Msg =
    Sierpinski

update : Msg -> Model -> Model
update msg model =
    case msg of
        Sierpinski ->
            Model (model.step + 1) (model.side)

sierpinski : Model -> Collage Msg
sierpinski model =
    case model.step of
        0 ->
            triangle model.side
                |> filled (uniform Color.blue)
        _ ->
            let
                nstep = model.step - 1
                nside = model.side / 2
                nmodel = Model nstep nside
                smaller =
                    Model (model.step - 1) (model.side / 2)
                        |> sierpinski
            in
            vertical
                [ smaller
                , horizontal [ smaller, smaller ] |> center
                ]

view : Model -> Html Msg
view model =
    div [ onClick Sierpinski ] [(sierpinski model) |>svg]
