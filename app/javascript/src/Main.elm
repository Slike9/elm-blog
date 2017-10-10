module Main exposing (main)

import Html exposing (Html, div, h1, h4, text)
import Http
import Json.Decode
import Model exposing (Model, Article)
import Message exposing (Message(..))
import View exposing (view)
import Update exposing (update)


-- INIT


init : ( Model, Cmd Message )
init =
    ( { articles = [] }, loadArticles )


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
