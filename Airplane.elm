module Main exposing (..)

{- This example shows a looping animation using only the undo method, not retarget. The step function is a little more
   repetitive than I'd like, suggesting a loop function. Without a major overhaul, the best implementation would be

       loop : Time -> Animation -> Animation
       loop t a = if isDone t a then undo t a else a

   This requires the client to call the function on each invocation of update, which I consider unacceptable. Better to
   have this be handled under the covers, but that means expanding the Animation union type. The best way to do that is
   probably define a StandardAnimation type and have all tags convert to it. Alternatively, come up with a sufficiently
   general representation and hope it isn't too crazy to work with.

   Or stick it in a separate module - how often can you see multiple animations into the future? The trend seems to be the
   reverse direction, with physics simulations seeing only the next frame, handling interactions as they come rather than
   interrupting a plan. In the mean time, animations are certainly composable if the client does some of the work
   themselves.

   End brain dump.
-}

import Color exposing (yellow)
import Collage exposing (..)
import Collage.Layout exposing (..)
import Collage.Render exposing (svg)
import Time exposing (Time)
import AnimationFrame
import Html exposing (Html, button, div, img)
import Html.Events exposing (onClick)
import Html.Attributes exposing (src)
import Animation exposing (..)
import Debug exposing (log)

type alias Model =
    { x : Animation, y : Animation, clock : Time }

model0 =
    Model
        (animation 0 |> from 500 |> to 0 |> duration Time.second)
        (animation 0 |> from 0 |> to -500 |> duration Time.second)
        0

type Msg
    = Tick Time

update : Msg -> Model -> Model
update msg model =
    case msg of
        Tick dt ->
            let
                clock = model.clock + dt
            in
                { model | clock = clock }

view : Model -> Html Msg
view { x, y, clock } =

    let
        pos =
            ( animate clock x, animate clock y )

        plane = image (300, 300) "images/airplane.jpg"
        circle =
            --Collage.circle 100 |> Collage.filled (uniform yellow) |> Collage.shift pos -- TODO: why new pos is not rendered??
            plane |> Collage.shift pos
    in
        group [
             spacer 300 300,
             circle
             ]
            |> Collage.Layout.debug
            |> svg

subs : Sub Msg
subs =
    Sub.batch
        [
        AnimationFrame.diffs Tick
        ]

main =
    Html.program
        { init = ( model0, Cmd.none )
        , update = (\msg model -> ( update msg model, Cmd.none ))
        , subscriptions = always subs
        , view = view
        }
