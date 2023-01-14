module Error exposing
    ( Error
    , env
    , interop
    , print
    , todo
    )

import Node.Env as Env
import Task exposing (Task)
import TaskPort



-- Application Error


type Error
    = InteropError TaskPort.FunctionName TaskPort.Error
    | EnvError Env.Error
    | UnknownError String



-- Create


interop : TaskPort.FunctionName -> TaskPort.Error -> Error
interop =
    InteropError


env : Env.Error -> Error
env =
    EnvError


unknown : String -> Error
unknown =
    UnknownError


todo : String -> Task Error a
todo reason =
    Task.fail (unknown ("TODO: " ++ reason))



-- Print


print : Error -> String
print err =
    case err of
        InteropError name e ->
            format
                { error = "Interop Error For: " ++ name
                , details = TaskPort.errorToString e
                }

        UnknownError e ->
            format
                { error = "Unknown Error"
                , details = e
                }

        EnvError e ->
            format
                { error = "Env Error"
                , details = Env.printError e
                }


format : { error : String, details : String } -> String
format options =
    options.error ++ ": " ++ options.details
