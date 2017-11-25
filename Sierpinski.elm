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
     seed : Int}

init : (Model, Cmd Msg)
init =
   ((Model 0 1200 1), Cmd.none)

type Msg =
    Sierpinski
    | NewSeed Int

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
           (model, Random.generate NewSeed (Random.int 1 255))

        NewSeed seed ->
           (Model (model.step + 1) (model.side) seed, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

sierpinski : Model -> Color -> Collage Msg
sierpinski model color =
    case model.step of
        0 ->
            triangle model.side
                |> filled (uniform color)
        _ ->
            let
                seed0 =  Random.initialSeed model.seed
                (rand0, seed1) = Random.step (Random.list 3 (Random.int 0 255)) seed0
                (rand1, seed2) = Random.step (Random.list 3 (Random.int 0 255)) seed1
                (rand2, seed3) = Random.step (Random.list 3 (Random.int 0 255)) seed2

                smaller =
                    Model (model.step - 1) (model.side / 2) (Tuple.first (Random.step (Random.int 0 255) seed3))

            in
            vertical
                [ (sierpinski smaller (makeColor rand0))
                , horizontal [ (sierpinski smaller (makeColor rand1)), (sierpinski smaller (makeColor rand2)) ] |> center
                ]

view : Model -> Html Msg
view model =
    div [ onClick Sierpinski ] [(sierpinski model (Color.rgb 1 1 1)) |>svg]
