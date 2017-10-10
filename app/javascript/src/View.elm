module View exposing (view)

import Html exposing (Html, h1, div, text)
import Html.Attributes exposing (class)
import Model exposing (Model)
import Message exposing (Message)
import View.Article.Index


view : Model -> Html Message
view model =
    div [ class "container" ]
        [ h1 [ class "blog-title" ] [ text "Elm Blog" ]
        , View.Article.Index.view model
        ]
