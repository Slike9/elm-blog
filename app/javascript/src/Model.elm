module Model exposing (Model, Route(..), Article)


type alias Model =
    { articles : List Article, route : Route }


type Route
    = ArticlesRoute
    | NewArticleRoute
    | NotFound


type alias Article =
    { id : Int
    , title : String
    , body : String
    }
