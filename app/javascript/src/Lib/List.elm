module Lib.List exposing (chunksOfLeft, find)


chunksOfLeft : Int -> List a -> List (List a)
chunksOfLeft length list =
    case list of
        [] ->
            []

        _ ->
            (List.take length list) :: (List.drop length list |> chunksOfLeft length)


find : (a -> Bool) -> List a -> Maybe a
find pred list =
    case list of
        x :: xs ->
            if pred x then
                Just x
            else
                find pred xs

        _ ->
            Nothing
