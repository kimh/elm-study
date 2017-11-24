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
  Html.program { init = init, view = view, update = update, subscriptions = subscriptions }

type alias Model =
    {step : Int,
     side : Float,
     color : Color}

init : (Model, Cmd Msg)
init =
   ((Model 0 1200 Color.blue), Cmd.none)

type Msg =
    Sierpinski
    | RandCol (List Int)

makeColor colors =
    case colors of
        [ r, g, b ] ->
            Color.rgb r g b
        _ ->
            Color.black

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Sierpinski ->
           (model, Random.generate RandCol (Random.list 3 (Random.int 1 255)))

        RandCol rand ->
           (Model (model.step + 1) (model.side) (makeColor rand), Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

sierpinski : Model -> Collage Msg
sierpinski model =
    case model.step of
        0 ->
            triangle model.side
                |> filled (uniform model.color)
        _ ->
            let
                smaller =
                    Model (model.step - 1) (model.side / 2) model.color
                        |> sierpinski
            in
            vertical
                [ smaller
                , horizontal [ smaller, smaller ] |> center
                ]

view : Model -> Html Msg
view model =
    div [ onClick Sierpinski ] [(sierpinski model) |>svg]
