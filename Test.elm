import Color exposing (black, yellow)
import Collage exposing (..)
import Collage.Layout exposing (..)
import Collage.Render exposing (svg)
import Time exposing (Time)
import AnimationFrame
import Html exposing (Html, button, div, audio)
import Html.Attributes exposing (src, autoplay)
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
    -- TODO: how can I play sound when I click?
    div []
        [audio [(src "audios/airliner-pass1.mp3"), (autoplay True)] []]
