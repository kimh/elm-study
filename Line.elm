import Collage exposing (..)
import Collage.Layout exposing (..)
import Collage.Render exposing (svg)
import Color exposing (..)
import Html exposing (Html)

main : Html msg
main =
    let
        gap = spacer 50 50
        myline = line 100
                 |> traced (solid thick (uniform red))
    in
        group [gap, myline]
        |> svg
