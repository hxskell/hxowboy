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

    
    SessionID = integer_to_list(random:uniform(100000)),
    Req2 = cowboy_req:set_resp_cookie(<<"sessionid">>, SessionID, [], Req),

    {ok, Req3} = cowboy_req:reply(200, A, <<"Hello Erlang">>, Req2),

    {AllCookies, Req4} = cowboy_req:cookies(Req3),
    io:format("session id ~p~n", [AllCookies]),

    {ok, Req4, State}.

terminate(_Reason, _Req, _State) ->
    ok.
