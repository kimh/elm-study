import Collage exposing (..)
import Collage.Layout exposing (..)
import Collage.Render exposing (svg)
import Color exposing (..)
import Html exposing (Html)

main : Html msg
main =
    Html.Matryoshka { model = model, view = view, update = update }

-- TODO: fix this compile error
type alias Model = Html msg

model : Model
model =
    let
        gap = spacer 50 50
        innerTri = triangle 500
                 |> filled (uniform Color.red)
    in
        group [outerTri]
        |> svg

type Msg = Matryoshka

update : Msg -> Model
update msg model =
    case msg of
        Matryoshka ->
            model

view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Matryoshka ] [ text "-" ] ]
