module Main exposing (main)

import Html exposing (Html, div, h1, h4, text)
import Html.Attributes exposing (class)
import Http
import Json.Decode
import ElmBlog.Model exposing (Model, Article)
import ElmBlog.List


-- INIT


init : ( Model, Cmd Message )
init =
    ( { articles = [] }, loadArticles )



-- VIEW


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


viewArticles : List Article -> Html Message
viewArticles articles =
    ElmBlog.List.chunksOfLeft 2 articles
        |> List.map viewArticlesRow
        |> div []


view : Model -> Html Message
view model =
    div [ class "container" ]
        [ h1 [ class "blog-title" ] [ text "Elm Blog" ]
        , viewArticles model.articles
        ]



-- MESSAGE


type Message
    = ArticlesLoaded (Result Http.Error (List Article))


loadArticles : Cmd Message
loadArticles =
    let
        request =
            Http.get "/api/v1/articles" decodeArticles
    in
        Http.send ArticlesLoaded request


decodeArticle : Json.Decode.Decoder Article
decodeArticle =
    Json.Decode.map3 Article
        (Json.Decode.at [ "id" ] Json.Decode.int)
        (Json.Decode.at [ "title" ] Json.Decode.string)
        (Json.Decode.at [ "body" ] Json.Decode.string)


decodeArticles : Json.Decode.Decoder (List Article)
decodeArticles =
    Json.Decode.list decodeArticle



-- UPDATE


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        ArticlesLoaded (Ok articles) ->
            ( { model | articles = articles }, Cmd.none )

        ArticlesLoaded (Err _) ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Message
subscriptions model =
    Sub.none



-- MAIN


main : Program Never Model Message
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
