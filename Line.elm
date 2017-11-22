import Collage exposing (ngon, filled, uniform, group, rotate, Collage)
import Collage.Layout exposing (..)
import Collage.Render exposing (svg)
import Color exposing (..)
import Html exposing (Html, button, div)
import Html.Events exposing (onClick)
import List exposing (..)
import Debug exposing (..)
import Random

main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

type alias Tri =
    {base : Float,
     color : Color,
     degree: Float
    }

type alias Model = List Tri

type Msg =
    Matryoshka
    | Matryoshka2
    | RandCol (List Int)

init : (Model, Cmd Msg)
init =
  ([Tri 500 (rgb 50 255 255) 0], Cmd.none)


triangle: Float -> Collage.Shape
triangle base =
    ngon 3 base

getDegree degree =
    case degree of
        0 -> 180
        180 -> 0
        _ -> 0

makeColor colors =
    case colors of
        [ r, g, b ] ->
            Color.rgb r g b
        _ ->
            Color.black

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Matryoshka ->
            (model, Random.generate RandCol (Random.list 3 (Random.int 1 255)))

        Matryoshka2 ->
            (model, Random.generate RandCol (Random.list 3 (Random.int 1 255)))

        RandCol rand ->
            case (head model) of
                Nothing ->
                    (model, Cmd.none)
                Just tri ->
                    (((Tri (tri.base / 2) (makeColor rand) (getDegree tri.degree)) :: model), Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

makeTriangle : Tri -> Collage Msg
makeTriangle tri =
     let
         gap = spacer 50 50
     in
         triangle tri.base
                  -- todo: generate random color
                  |> filled (uniform tri.color)
                  |> rotate (degrees tri.degree)

renderTriangle : Model -> Html Msg
renderTriangle model =
     let
         triangles = List.map makeTriangle model
     in
         group triangles
         |> svg

view : Model -> Html Msg
view model =
    div [ onClick Matryoshka ] [ renderTriangle model ]
