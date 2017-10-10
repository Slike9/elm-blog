module Update exposing (update)

import Model exposing (Model)
import Message exposing (Message(..))


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        ArticlesLoaded (Ok articles) ->
            ( { model | articles = articles }, Cmd.none )

        ArticlesLoaded (Err _) ->
            ( model, Cmd.none )
