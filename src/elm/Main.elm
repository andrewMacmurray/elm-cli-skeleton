port module Main exposing (main)

import Cli.OptionsParser as OptionsParser
import Cli.Program as Program
import Command
import Command.Example as Example



-- CLI


type Options
    = Example Example.Options


config : Program.Config Options
config =
    Program.config
        |> Program.add (OptionsParser.map Example Example.parser)


type alias Output =
    Result String String



-- Model


type alias Flags =
    Program.FlagsIncludingArgv {}


type alias Model =
    {}


type Msg
    = ExampleCommandCompleted Output



-- Init


init : Flags -> Options -> ( Model, Cmd Msg )
init _ options =
    ( {}, command options )


command : Options -> Cmd Msg
command options =
    case options of
        Example options_ ->
            Command.execute ExampleCommandCompleted (Example.command options_)



-- Update


update : Options -> Msg -> Model -> ( Model, Cmd Msg )
update _ msg model =
    case msg of
        ExampleCommandCompleted output ->
            ( model, handleOutput output )


handleOutput : Result String String -> Cmd msg
handleOutput output =
    case output of
        Ok a ->
            printAndExitSuccess a

        Err e ->
            printAndExitFailure e



-- Program


main : Program.StatefulProgram Model Msg Options {}
main =
    Program.stateful
        { printAndExitFailure = printAndExitFailure
        , printAndExitSuccess = printAndExitSuccess
        , init = init
        , update = update
        , subscriptions = always Sub.none
        , config = config
        }



-- Ports


port printAndExitFailure : String -> Cmd msg


port printAndExitSuccess : String -> Cmd msg
