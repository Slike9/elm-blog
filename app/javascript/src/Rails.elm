module Rails exposing (csrfToken, csrfTokenHeader)

import Http
import Native.Rails


csrfToken : Result String String
csrfToken =
    Native.Rails.csrfToken


csrfTokenHeader : List Http.Header
csrfTokenHeader =
    case csrfToken of
        Ok token ->
            [ Http.header "X-CSRF-Token" token ]

        Err _ ->
            []
