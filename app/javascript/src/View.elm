module View exposing (view)

import Html exposing (Html, h1, div, text)
import Html.Attributes exposing (class)
import Model exposing (Model, Route(..))
import Message exposing (Message)
import View.Article.Index
import View.Article.New
import View.Article.Edit
import View.NotFound


view : Model -> Html Message
view model =
    div [ class "container" ]
        [ h1 [ class "blog-title" ] [ text "Elm Blog" ]
        , case model.route of
            ArticlesRoute ->
                View.Article.Index.view model

            NewArticleRoute ->
                View.Article.New.view model

            EditArticleRoute _ ->
                case model.editArticle of
                    Just article ->
                        View.Article.Edit.view article

                    Nothing ->
                        div [] [ text "Loading..." ]

            NotFound ->
                View.NotFound.view model
        ]
