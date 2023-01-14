module Command exposing
    ( Command
    , Output
    , create
    , execute
    )

import Env
import Error exposing (Error)
import Task exposing (Task)



-- Command


type Command a
    = Command (Command_ a)


type alias Command_ a =
    { task : Env.Config -> Task Error a
    , print : a -> String
    }


type alias Output a =
    Result Error a



-- Create


create : Command_ a -> Command a
create =
    Command



-- Execute


execute : (Result String String -> msg) -> Command a -> Cmd msg
execute msg (Command cmd) =
    Env.load
        |> Task.andThen cmd.task
        |> Task.map cmd.print
        |> Task.mapError Error.print
        |> Task.attempt msg
