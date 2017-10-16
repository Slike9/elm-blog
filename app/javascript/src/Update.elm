module Update exposing (update)

import Navigation
import Http
import Json.Encode as Encode
import Json.Decode as Decode
import Model exposing (Model, Article)
import Message exposing (Message(..))
import Routing
import Rails


articleDecoder : Decode.Decoder Article
articleDecoder =
    Decode.map3 Article
        (Decode.field "id" Decode.int)
        (Decode.field "title" Decode.string)
        (Decode.field "body" Decode.string)


articleEncoder : Article -> Encode.Value
articleEncoder article =
    Encode.object
        [ ( "title", Encode.string article.title )
        , ( "body", Encode.string article.body )
        ]


createArticleRequest : Article -> Http.Request Article
createArticleRequest article =
    Http.request
        { method = "POST"
        , headers = Rails.csrfTokenHeader
        , url = "/api/v1/articles"
        , body = articleEncoder article |> Http.jsonBody
        , expect = Http.expectJson articleDecoder
        , timeout = Nothing
        , withCredentials = True
        }


createArticle : Article -> Cmd Message
createArticle article =
    Http.send ArticleCreated (createArticleRequest article)


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        ArticlesLoaded (Ok articles) ->
            ( { model | articles = articles }, Cmd.none )

        ArticlesLoaded (Err _) ->
            ( model, Cmd.none )

        UrlChange location ->
            ( { model | route = Routing.parseLocation location }, Cmd.none )

        NewUrl url ->
            ( model, Navigation.newUrl url )

        ChangeNewArticleTitle title ->
            let
                { newArticle } =
                    model
            in
                ( { model | newArticle = { newArticle | title = title } }, Cmd.none )

        ChangeNewArticleText text ->
            let
                { newArticle } =
                    model
            in
                ( { model | newArticle = { newArticle | body = text } }, Cmd.none )

        SaveNewArticle ->
            let
                newArticle =
                    model.newArticle
            in
                ( model, createArticle newArticle )

        ArticleCreated (Ok article) ->
            let
                articles =
                    model.articles
            in
                ( { model
                    | articles = article :: articles
                    , newArticle = { id = 0, title = "", body = "" }
                  }
                , Navigation.newUrl "/"
                )

        ArticleCreated (Err _) ->
            ( model, Cmd.none )
