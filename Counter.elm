import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


main =
  Html.beginnerProgram { model = model, view = view, update = update }

-- MODEL

-- Definining 'Model' type as same as built-in 'Int' type
type alias Model = Int

-- Annotating model function that receives 'Model'
model : Model
-- This defines 'model' function with no arg
model =
  0

-- UPDATE

-- Definining 'Msg' union type which is either 'Increment' type or 'Decrement' type
-- This is so that we can find a matched type with 'case'
type Msg = Increment | Decrement

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1

-- VIEW

view : Model -> Html Msg
view model =
  -- div, button, etc are Elm functions
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [] [ text (toString model) ]
    , button [ onClick Increment ] [ text "+" ]
    ]
