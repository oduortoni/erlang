-module(players).

-export([fetch/1, start/0]).

-record(player, {
    name :: atom(),
    club :: atom(),
    position :: atom()
}).

start() ->
    Players = #{
        mesut => #player{name = mesut, club = arsenal, position = midfielder},
        kroos => #player{name = kroos, club = realmadrid, position = midfielder},
        zidane => #player{name = zidane, club = realmadrid, position = striker},
        okocha => #player{name = okocha, club = bolton, position = midfielder}
    },
    spawn(?MODULE, fetch, [Players]).

fetch(Players) ->
    receive
        {Pid, Name} ->
            Player = maps:get(Name, Players, error),
            Pid ! Player,
            fetch(Players);
        _ ->
            fetch(Players)
    end.
