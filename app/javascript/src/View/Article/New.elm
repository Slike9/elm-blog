module View.Article.New exposing (view)

import Html exposing (Html, div, h4, text)
import Model exposing (Model)
import Message exposing (Message)


view : Model -> Html Message
view model =
    div [] [ h4 [] [ text "New article" ] ]
