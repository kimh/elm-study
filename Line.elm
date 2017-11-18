import Collage exposing (..)
import Collage.Layout exposing (..)
import Collage.Render exposing (svg)
import Color exposing (..)
import Html exposing (Html, button, div)
import Html.Events exposing (onClick)
import List exposing (..)
import Debug exposing (..)

main =
    Html.beginnerProgram { model = model, view = view, update = update }

-- TODO: fix this compile error
type alias Model = List Float
type Msg = Matryoshka

model : Model
model = [800]

update : Msg -> Model -> List Float
update msg model =
    case msg of
        Matryoshka ->
            let
                lastElement = head model
            in
                case lastElement of
                    Nothing ->
                        [800]
                    Just val ->
                        val / 2 :: model

makeTriangle : Float -> Collage Msg
makeTriangle base =
     let
         gap = spacer 50 50
     in
         triangle base
                  -- todo: generate random color
                  |> filled (uniform (rgb 51 255 255))

renderTriangle : Model -> Html Msg
renderTriangle coll =
     let
         triangles = map makeTriangle coll
     in
         log (toString coll)
         group triangles
         |> svg

view : Model -> Html Msg
view model =
    div [ onClick Matryoshka ] [ renderTriangle model ]
