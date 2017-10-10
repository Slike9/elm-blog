module Model exposing (Model, Article)


type alias Model =
    { articles : List Article }


type alias Article =
    { id : Int
    , title : String
    , body : String
    }
