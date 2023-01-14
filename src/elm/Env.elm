module Env exposing
    ( Config
    , load
    )

import Error exposing (Error)
import Json.Decode as Decode
import Node.Env as Env
import Task exposing (Task)
import Utils.Task as Task



-- Environment


type alias Config =
    { optionalVar : Maybe String
    , requiredVar : String
    }



-- Load


load : Task Error Config
load =
    Task.succeed Config
        |> Task.andMap (optionalEnv Decode.string "OPTIONAL_VAR")
        |> Task.andMap (requiredEnv Decode.string "REQUIRED_VAR")


optionalEnv : Decode.Decoder a -> String -> Task Error (Maybe a)
optionalEnv decode =
    Env.optional decode >> Task.mapError Error.env


requiredEnv : Decode.Decoder a -> String -> Task Error a
requiredEnv decode =
    Env.required decode >> Task.mapError Error.env
