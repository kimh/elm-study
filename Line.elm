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
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

type alias Tri =
    {base : Float,
     color : Color
    }

type alias Model = List Tri

type Msg =
    Matryoshka
    | RandCol (List Int)

init : (Model, Cmd Msg)
init =
  ([Tri 800 (rgb 50 255 255)], Cmd.none)

-- TODO: write recursive version of applying list of colors
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
        RandCol rand ->
            case (head model) of
                Nothing ->
                    (model, Cmd.none)
                Just tri ->
                    (((Tri (tri.base / 2) (makeColor rand)) :: model), Cmd.none)

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
