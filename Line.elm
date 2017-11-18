import Collage exposing (..)
import Collage.Layout exposing (..)
import Collage.Render exposing (svg)
import Color exposing (..)
import Html exposing (Html, button, div)
import Html.Events exposing (onClick)

main =
    Html.beginnerProgram { model = model, view = view, update = update }

-- TODO: fix this compile error
type alias Model = Float
type Msg = Matryoshka

model : Model
model = 800


update : Msg -> Model -> Float
update msg model =
    case msg of
        Matryoshka ->
            model / 2

renderTriangle : Model -> Html Msg
renderTriangle base =
     let
         gap = spacer 50 50
         outerTri = triangle base
                  |> filled (uniform Color.red)
     in
         group [outerTri]
         |> svg

view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Matryoshka ] [ renderTriangle model ] ]
