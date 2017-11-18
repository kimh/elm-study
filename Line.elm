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

-- TODO: fix this compile error
type alias Tri = { base : Float }
type alias Model = List Tri

type Msg = Matryoshka

init : (Model, Cmd Msg)
init =
  ([Tri 800], Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Matryoshka ->
            let
                lastElement = head model
            in
                case lastElement of
                    Nothing ->
                        ([Tri 800], Cmd.none)
                    Just tri ->
                        (
                        ((Tri (tri.base / 2)) :: model), Cmd.none
                        )

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
                  |> filled (uniform (rgb 51 255 255))

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
