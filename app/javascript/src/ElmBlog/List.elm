module ElmBlog.List exposing (chunksOfLeft)


chunksOfLeft : Int -> List a -> List (List a)
chunksOfLeft length list =
    case list of
        [] ->
            []

        _ ->
            (List.take length list) :: (List.drop length list |> chunksOfLeft length)
