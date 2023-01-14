module Command.Example exposing
    ( Options
    , command
    , parser
    )

import Cli.Option as Option
import Cli.OptionsParser as OptionsParser exposing (OptionsParser)
import Cli.OptionsParser.BuilderState exposing (AnyOptions)
import Command exposing (Command)
import Env
import Error exposing (Error)
import Node.Logger as Logger
import Task exposing (Task)
import Utils.Task as Task



-- Example Command


type alias Options =
    { arg1 : Maybe String
    , arg2 : Maybe Int
    }



-- Parser


parser : OptionsParser Options AnyOptions
parser =
    OptionsParser.buildSubCommand "example" Options
        |> OptionsParser.with (Option.optionalKeywordArg "arg1")
        |> OptionsParser.with (Option.optionalKeywordArg "arg2" |> Option.validateMapIfPresent toInt)


toInt : String -> Result String Int
toInt =
    String.toInt >> Result.fromMaybe "Please enter a valid int"



-- Command


type alias Output =
    Int


command : Options -> Command Output
command options =
    Command.create
        { task = task options
        , print = print options
        }


task : Options -> Env.Config -> Task Error Output
task _ _ =
    Logger.info "Starting Example command"
        |> Task.andThenDo (Task.succeed 42)
        |> Task.andThen (Logger.withInfo "Example command task complete")


print : Options -> Output -> String
print options output =
    String.join "\n"
        [ "Example Command Output"
        , "Meaning of Life: " ++ String.fromInt output
        , "Arg1: " ++ Maybe.withDefault "None" options.arg1
        , "Arg2: " ++ Maybe.withDefault "None" (Maybe.map String.fromInt options.arg2)
        ]
