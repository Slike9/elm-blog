module Model exposing (Model, Article, Route(..), init, findArticleById, updateArticle)

import Lib.List
import Navigation


type alias Model =
    { articles : List Article
    , route : Route
    , location : Navigation.Location
    , newArticle : Article
    , editArticle : Maybe Article
    }


type Route
    = ArticlesRoute
    | NewArticleRoute
    | EditArticleRoute Int
    | NotFound


type alias Article =
    { id : Int
    , title : String
    , body : String
    }


init : Route -> Navigation.Location -> Model
init route location =
    { articles = []
    , route = route
    , location = location
    , newArticle = Article 0 "" ""
    , editArticle = Nothing
    }


findArticleById : Int -> List Article -> Maybe Article
findArticleById id articles =
    Lib.List.find (\x -> x.id == id) articles


updateArticle : Article -> List Article -> List Article
updateArticle article articles =
    case articles of
        [] ->
            []

        x :: xs ->
            if x.id == article.id then
                article :: xs
            else
                x :: (updateArticle article xs)
