-module(fantasy).
-export([start/1, loop/2]).

start(State) ->
    FetchPid = players:start(),
    Pid = spawn(?MODULE, loop, [State, FetchPid]),
    Pid.

loop(State, FetcherPid) ->
    receive
        {add, Name} ->
            FetcherPid ! {self(), Name},

            receive
                Player ->
                    NewState = maps:put(Name, Player, State),            
                    loop(NewState, FetcherPid)
            end;
        {remove, Name} ->
            NewState = maps:remove(Name, State),
            loop(NewState, FetcherPid);

        {team, Pid} ->
            Pid ! State,
            loop(State, FetcherPid);

        _ ->
            loop(State, FetcherPid)
    end.
