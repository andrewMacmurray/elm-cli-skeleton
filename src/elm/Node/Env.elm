module Node.Env exposing
    ( Error
    , optional
    , printError
    , required
    )

import Json.Decode as Decode
import Json.Encode as Encode
import Task exposing (Task)
import Utils.TaskPort as TaskPort



-- Node Env


type Error
    = Error String TaskPort.Error



-- Get Env


optional : Decode.Decoder a -> String -> Task Error (Maybe a)
optional decoder name =
    required (Decode.maybe decoder) name


required : Decode.Decoder value -> String -> Task Error value
required decode name =
    TaskPort.call
        { function = "getEnv"
        , valueDecoder = decode
        , args = Encode.string name
        }
        |> Task.mapError (Error ("Problem With Env Var - " ++ name))


printError : Error -> String
printError (Error reason e) =
    reason ++ " - " ++ TaskPort.errorToString e
