module Routing exposing (parseLocation)

import Navigation
import UrlParser exposing (oneOf, s, map, (</>), top, int)
import Model exposing (Route(..))


matchers : UrlParser.Parser (Route -> a) a
matchers =
    oneOf
        [ map ArticlesRoute top
        , map ArticlesRoute (s "articles")
        , map NewArticleRoute (s "articles" </> s "new")
        , map EditArticleRoute (s "articles" </> int </> s "edit")
        ]


parseLocation : Navigation.Location -> Route
parseLocation location =
    case (UrlParser.parsePath matchers location) of
        Just route ->
            route

        Nothing ->
            NotFound
