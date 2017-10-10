module Update exposing (update)

import Navigation
import Model exposing (Model)
import Message exposing (Message(..))
import Routing


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
