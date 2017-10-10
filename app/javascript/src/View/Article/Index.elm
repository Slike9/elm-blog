module View.Article.Index exposing (view)

import Html exposing (Html, div, h1, h4, text)
import Html.Attributes exposing (class)
import Model exposing (Model, Article)
import Message exposing (Message)
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


view : Model -> Html Message
view model =
    Lib.List.chunksOfLeft 2 model.articles
        |> List.map viewArticlesRow
        |> div []
