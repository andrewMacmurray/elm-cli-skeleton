module Node.Logger exposing
    ( debug
    , error
    , info
    , warn
    , withError
    , withInfo
    , withWarn
    )

import Json.Decode as Decode
import Json.Encode as Encode
import Task exposing (Task)
import Utils.TaskPort as TaskPort


debug : String -> Task x ()
debug =
    consoleLog "DEBUG"


info : String -> Task x ()
info =
    consoleLog "INFO"


withInfo : String -> a -> Task x a
withInfo message a =
    info message |> Task.map (always a)


warn : String -> Task x ()
warn =
    consoleLog "WARN"


withWarn : String -> a -> Task x a
withWarn message a =
    warn message |> Task.map (always a)


error : String -> Task x ()
error =
    consoleLog "ERROR"


withError : String -> a -> Task x a
withError message a =
    error message |> Task.map (always a)


consoleLog : String -> String -> Task x ()
consoleLog level message =
    TaskPort.call
        { function = "consoleLog"
        , valueDecoder = Decode.succeed ()
        , args =
            Encode.object
                [ ( "level", Encode.string level )
                , ( "message", Encode.string message )
                ]
        }
        |> Task.onError (always (Task.succeed ()))
