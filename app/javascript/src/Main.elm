module Main exposing (..)

import Html exposing (Html, div, h1, text)
import Html.Attributes exposing (style)
import Http
import Json.Decode


-- MODEL


type alias Article =
    { id : Int
    , title : String
    , body : String
    }


type alias Model =
    { articles : List Article }



-- INIT


init : ( Model, Cmd Message )
init =
    ( { articles = [] }, loadArticles )



-- VIEW


view : Model -> Html Message
view { articles } =
    -- The inline style is being used for example purposes in order to keep this example simple and
    -- avoid loading additional resources. Use a proper stylesheet when building your own app.
    div []
        [ h1 [ style [ ( "display", "flex" ), ( "justify-content", "center" ) ] ]
            [ text "Elm Blog" ]
        , div [] [ text ("ArticlesLoaded count: " ++ (toString (List.length articles))) ]
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
