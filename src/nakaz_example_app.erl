-module(nakaz_example_app).
-behaviour(application).
-compile({parse_transform, nakaz_pt}).

-include_lib("nakaz/include/nakaz.hrl").
-include("nakaz_example.hrl").

%% API
-export([start/0, stop/0]).

%% Application callbacks

-export([start/2, stop/1]).

%% API

start() ->
    ok = application:start(nakaz),
    ok = application:start(nakaz_example).

stop() ->
    ok = application:stop(nakaz_example),
    ok = application:stop(nakaz).

%% Application callbacks

start(_StartType, _StartArgs) ->
    ok = ?NAKAZ_ENSURE([#srv_conf{}, #log_conf{}],
                       [{nakaz_loader, nakaz_example_confloader}]),
    example_sup:start_link().

stop(_State) ->
    ok.
