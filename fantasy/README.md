# Fantasy

An Erlang fantasy football team management system.

## Modules

- `fantasy` - Main team management process
- `players` - Player data and fetching service

## Usage

```erlang
% Start the system
Pid = fantasy:start(#{}).

% Add a player to team
Pid ! {add, mesut}.

% Remove a player
Pid ! {remove, mesut}.

% Get current team
Pid ! {team, self()}.
```

## Compilation

```bash
erl -compile fantasy.erl
erl -compile players.erl
```