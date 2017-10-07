module ElmBlog.ListTest exposing (suite)

import ElmBlog.List
import Expect exposing (Expectation)


-- import Fuzz exposing (Fuzzer, int, list, string)

import Test exposing (Test, describe, test)


suite : Test
suite =
    describe "ElmBlog.List"
        [ describe "ElmBlog.List.splitChunksOfLeft"
            [ test "empty list" <|
                \_ ->
                    ElmBlog.List.chunksOfLeft 3 []
                        |> Expect.equal []
            , test "one chunk" <|
                \_ ->
                    ElmBlog.List.chunksOfLeft 3 [ 1 ]
                        |> Expect.equal [ [ 1 ] ]
            , test "several chunks" <|
                \_ ->
                    ElmBlog.List.chunksOfLeft 3 [ 1, 2, 3, 4, 5 ]
                        |> Expect.equal [ [ 1, 2, 3 ], [ 4, 5 ] ]
            ]
        ]
