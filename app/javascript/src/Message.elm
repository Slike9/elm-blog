module Message exposing (Message(..))

import Http
import Model exposing (Article)


type Message
    = ArticlesLoaded (Result Http.Error (List Article))
