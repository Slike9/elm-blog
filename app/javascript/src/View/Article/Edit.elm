module View.Article.Edit exposing (view)

import Html exposing (Html, div, h4, text, input, form, label, textarea, button)
import Html.Attributes exposing (type_, value, class, placeholder, rows, style)
import Html.Events exposing (onInput, onClick)
import Model exposing (Model, Article)
import Message exposing (Message(..))


viewToolbar : Article -> Html Message
viewToolbar article =
    div []
        [ div [ class "btn-toolbar", style [ ( "margin-bottom", "5px" ) ] ]
            [ div [ class "btn-group" ]
                [ button [ class "btn btn-primary", onClick SaveEditArticle ] [ text "Save" ] ]
            , div [ class "btn-group" ]
                [ button [ class "btn btn-warning", onClick (NewUrl "/") ] [ text "Cancel" ] ]
            ]
        ]


view : Article -> Html Message
view article =
    div []
        [ viewToolbar article
        , form []
            [ div [ class "form-group" ]
                [ input
                    [ class "form-control"
                    , value article.title
                    , placeholder "Title"
                    , onInput <| \title -> ChangeEditArticle { article | title = title }
                    ]
                    []
                ]
            , div [ class "form-group" ]
                [ textarea
                    [ class "form-control"
                    , rows 10
                    , placeholder "Place text here"
                    , onInput <| \body -> ChangeEditArticle { article | body = body }
                    , value article.body
                    ]
                    []
                ]
            ]
        ]
