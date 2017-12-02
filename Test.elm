import Color exposing (black, yellow)
import Collage exposing (..)
import Collage.Layout exposing (..)
import Collage.Render exposing (svg)
import Time exposing (Time)
import AnimationFrame
import Html exposing (Html, button, div)
import Html.Events exposing (onClick)
import Animation exposing (..)
import Debug exposing (log)

main =
  Html.program { init = init, view = view, update = update, subscriptions = subscriptions }

type alias Model = Int
type Msg = NoOp

init : (Model, Cmd Msg)
init =
   (0, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

view : Model -> Html Msg
view model =
    --Collage.Layout.debug (Collage.circle  300 |> Collage.filled (uniform yellow) |> shift (100,-100)) |> svg
    group [
    spacer 0 0,
    Collage.triangle 10 |> filled (uniform black) |> shift (450, -450)
    --Collage.triangle 10 |> filled (uniform yellow),
    --Collage.triangle 10 |> filled (uniform black) |> shift (450, 0)
        ]
        |> Collage.Layout.debug
        |> svg
