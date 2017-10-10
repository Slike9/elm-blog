module View.Article.Index exposing (view)

import Html exposing (Html, div, h1, h4, text, button)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)
import Model exposing (Model, Article)
import Message exposing (Message(NewUrl))
import Lib.List


viewArticle : Article -> Html Message
viewArticle article =
    div [ class "card" ]
        [ div [ class "card-body" ]
            [ h4 [ class "card-title" ] [ text article.title ]
            , div [] [ text article.body ]
            ]
        ]


viewArticlesRow : List Article -> Html Message
viewArticlesRow articles =
    div [ class "row articles-row" ]
        (List.map (\x -> div [ class "col-6" ] [ viewArticle x ]) articles)


viewToolbar : Html Message
viewToolbar =
    div [ class "btn-toolbar" ]
        [ div [ class "btn-group" ]
            [ button [ class "btn btn-link", onClick (NewUrl "/articles/new") ] [ text "New Article" ] ]
        ]


view : Model -> Html Message
view model =
    div []
        [ viewToolbar
        , Lib.List.chunksOfLeft 2 model.articles
            |> List.map viewArticlesRow
            |> div []
        ]
