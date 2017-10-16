module Model exposing (Model, Route(..), Article, init)


type alias Model =
    { articles : List Article
    , route : Route
    , newArticle : Article
    }


type Route
    = ArticlesRoute
    | NewArticleRoute
    | NotFound


type alias Article =
    { id : Int
    , title : String
    , body : String
    }


init : Route -> Model
init route =
    { articles = []
    , route = route
    , newArticle = Article 0 "" ""
    }
