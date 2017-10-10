module Message exposing (Message(..))

import Http
import Navigation
import Model exposing (Article)


type Message
    = ArticlesLoaded (Result Http.Error (List Article))
    | UrlChange Navigation.Location
    | NewUrl String
