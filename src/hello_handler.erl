-module(hello_handler).
-behaviour(cowboy_http_handler).

-export([init/3]).
-export([handle/2]).
-export([terminate/3]).

-record(state, {
}).

init(_, Req, _Opts) ->
	{ok, Req, #state{}}.

handle(Req, State=#state{}) ->
	A = [{<<"content-type">>, <<"text/plain">>}],
	_B = [{<<"connection">>, <<"close">>}],

	{Method, _} = cowboy_req:method(Req),
	{Host, _} = cowboy_req:host(Req),
	{Port, _} = cowboy_req:port(Req),
	{Path, _} = cowboy_req:path(Req),
	io:format("~p~n", [[Method, Host, Port, Path]]),

	{ok, Req2} = cowboy_req:reply(200, 
								  A,
								  <<"Hello Erlang">>,
								  Req),
	{ok, Req2, State}.

terminate(_Reason, _Req, _State) ->
	ok.
