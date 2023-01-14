module Utils.TaskPort exposing
    ( Call
    , CallNoArgs
    , Error
    , call
    , callNoArgs
    , errorToString
    )

import Json.Decode as Decode
import Task exposing (Task)
import TaskPort


type alias Error =
    TaskPort.Error


type alias Call a =
    { function : TaskPort.FunctionName
    , args : Decode.Value
    , valueDecoder : Decode.Decoder a
    }


type alias CallNoArgs a =
    { function : TaskPort.FunctionName
    , valueDecoder : Decode.Decoder a
    }


call : Call a -> Task Error a
call opts =
    TaskPort.call
        { function = opts.function
        , argsEncoder = always opts.args
        , valueDecoder = opts.valueDecoder
        }
        ()


callNoArgs : CallNoArgs a -> Task Error a
callNoArgs opts =
    TaskPort.callNoArgs
        { function = opts.function
        , valueDecoder = opts.valueDecoder
        }


errorToString : Error -> String
errorToString =
    TaskPort.errorToString
