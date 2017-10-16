module View.Article.New exposing (view)

import Html exposing (Html, div, h4, text, input, form, label, textarea, button)
import Html.Attributes exposing (type_, value, class, placeholder, rows, style)
import Html.Events exposing (onInput, onClick)
import Model exposing (Model)
import Message exposing (Message(..))


viewToolbar : Html Message
viewToolbar =
    div []
        [ div [ class "btn-toolbar", style [ ( "margin-bottom", "5px" ) ] ]
            [ div [ class "btn-group" ]
                [ button [ class "btn btn-primary", onClick SaveNewArticle ] [ text "Save" ] ]
            , div [ class "btn-group" ]
                [ button [ class "btn btn-warning", onClick (NewUrl "/") ] [ text "Cancel" ] ]
            ]
        ]


view : Model -> Html Message
view { newArticle } =
    div []
        [ viewToolbar
        , form []
            [ div [ class "form-group" ]
                [ input
                    [ class "form-control"
                    , value newArticle.title
                    , placeholder "Title"
                    , onInput ChangeNewArticleTitle
                    ]
                    []
                ]
            , div [ class "form-group" ]
                [ textarea
                    [ class "form-control"
                    , rows 10
                    , placeholder "Place text here"
                    , onInput ChangeNewArticleText
                    , value newArticle.body
                    ]
                    []
                ]
            ]
        ]
