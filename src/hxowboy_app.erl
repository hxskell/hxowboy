-module(hxowboy_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
	Dispatch = cowboy_router:compile([
				%% {HostMatch, list({PathMatch, Handler, Opts})}
				{'_', [ {"/", hello_handler, []}
                        , {"/static", cowboy_static, {priv_file, hxowboy, "static/index.html"}}
                      ]}
			]),

	%% Name, NbAcceptors, TransOpts, ProtoOpts
	{ok, _} = cowboy:start_http(my_http_listener, 100, [{port, 8080}],
								[{env, [{dispatch, Dispatch}]},
								 {max_keepalive, 5}]),
	hxowboy_sup:start_link().

stop(_State) ->
	ok.
