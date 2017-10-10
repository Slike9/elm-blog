module View.NotFound exposing (view)

import Html exposing (Html, h4, div, text)
import Model exposing (Model)
import Message exposing (Message)


view : Model -> Html Message
view model =
    div [] [ h4 [] [ text "Not Found" ] ]
