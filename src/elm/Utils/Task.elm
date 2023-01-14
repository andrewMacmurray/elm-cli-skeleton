module Utils.Task exposing
    ( andMap
    , andThenDo
    )

import Task exposing (Task)


andMap : Task x a -> Task x (a -> b) -> Task x b
andMap =
    Task.map2 (|>)


andThenDo : Task x b -> Task x a -> Task x b
andThenDo t2 t1 =
    t1 |> Task.andThen (\_ -> t2)
