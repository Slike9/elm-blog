module Update exposing (update)

import Navigation
import Http
import Json.Encode as Encode
import Json.Decode as Decode
import Model exposing (Model, Article, Route(EditArticleRoute, NotFound))
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


updateArticleRequest : Article -> Http.Request Article
updateArticleRequest article =
    Http.request
        { method = "PATCH"
        , headers = Rails.csrfTokenHeader
        , url = "/api/v1/articles/" ++ (toString article.id)
        , body = articleEncoder article |> Http.jsonBody
        , expect = Http.expectJson articleDecoder
        , timeout = Nothing
        , withCredentials = True
        }


createArticle : Article -> Cmd Message
createArticle article =
    Http.send ArticleCreated (createArticleRequest article)


updateArticle : Article -> Cmd Message
updateArticle article =
    Http.send ArticleUpdated (updateArticleRequest article)


handleLocation : Navigation.Location -> Model -> ( Model, Cmd Message )
handleLocation location model =
    let
        route =
            Routing.parseLocation location
    in
        case route of
            EditArticleRoute id ->
                case Model.findArticleById id model.articles of
                    Just article ->
                        ( { model | route = route, editArticle = Just article }, Cmd.none )

                    Nothing ->
                        ( { model | route = NotFound }, Cmd.none )

            _ ->
                ( { model | route = route }, Cmd.none )


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        ArticlesLoaded (Ok articles) ->
            handleLocation model.location { model | articles = articles }

        ArticlesLoaded (Err _) ->
            ( model, Cmd.none )

        UrlChange location ->
            handleLocation location { model | location = location }

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

        ChangeEditArticle article ->
            ( { model | editArticle = Just article }, Cmd.none )

        SaveEditArticle ->
            case model.editArticle of
                Just article ->
                    ( model, updateArticle article )

                Nothing ->
                    ( model, Cmd.none )

        ArticleUpdated (Ok article) ->
            ( { model
                | articles = Model.updateArticle article model.articles
                , editArticle = Nothing
              }
            , Navigation.newUrl "/"
            )

        ArticleUpdated (Err _) ->
            ( model, Cmd.none )
