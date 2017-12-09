port module Test exposing (..)
import Html exposing (Html, button, div, audio)
import Html.Events exposing (onClick)
import Html.Attributes exposing (src, autoplay)
import Debug exposing (log)

main =
  Html.program { init = init, view = view, update = update, subscriptions = subscriptions }

port play : Float -> Cmd msg

type alias Model = Int
type Msg =
    Play

init : (Model, Cmd Msg)
init =
   (0, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Play ->
            (model, play 1)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch []

view : Model -> Html Msg
view model =
    div []
        [button [ onClick Play] []]
