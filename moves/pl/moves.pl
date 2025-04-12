% NOTIFICATION!!!
% we used stack-overflow and chat-gpt
% to guide us on our journey with prolog

% possible directions and their names
direction((-1, 0), 'n').
direction((-1, 1), 'ne').
direction((0, 1), 'e').
direction((1, 1), 'se').
direction((1, 0), 's').
direction((1, -1), 'sw').
direction((0, -1), 'w').
direction((-1, -1), 'nw').

% Check if the coordinates are within the bounds of the grid
is_valid(X, Y, N) :-
    X >= 0,
    X < N,
    Y >= 0,
    Y < N.

% BFS algorithm
bfs(Grid, N, Path) :-
    bfs([(0, 0, [])], Grid, N, [], Path).

% Base case: If the queue is empty, return "IMPOSSIBLE"
bfs([], _, _, _, 'IMPOSSIBLE').

% If the target (N-1, N-1) is reached, return the path
bfs([(X, Y, Path)|_], _, N, _, Path) :-
    X is N - 1,
    Y is N - 1.

% Continue BFS with the rest of the queue
bfs([(X, Y, Path)|Queue], Grid, N, Visited, Result) :-
    findall(
        (NX, NY, NewPath),
        (
            direction((DX, DY), DName),
            NX is X + DX,
            NY is Y + DY,
            is_valid(NX, NY, N),
            \+ member((NX, NY), Visited),
            nth0(X, Grid, Row),
            nth0(Y, Row, Value),
            nth0(NX, Grid, NewRow),
            nth0(NY, NewRow, NewValue),
            NewValue < Value,
            NewPath = [DName|Path]
        ),
        NextNodes
    ),
    append(Queue, NextNodes, NewQueue),
    bfs(NewQueue, Grid, N, [(X, Y)|Visited], Result).

% Read input and parse the grid
read_input(File, N, Grid) :-
    open(File, read, Stream),
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atom_number(Atom, N),
    read_grid(Stream, N, Grid),
    close(Stream).

read_grid(Stream, N, Grid) :-
    read_grid(Stream, N, 0, [], Grid).

read_grid(_, N, N, Grid, Grid).

read_grid(Stream, N, RowNum, Acc, Grid) :-
    RowNum < N,
    read_line_to_codes(Stream, Line),
    atom_codes(Atom, Line),
    atomic_list_concat(Atoms, ' ', Atom),
    maplist(atom_number, Atoms, Row),
    append(Acc, [Row], NewAcc),
    NewRowNum is RowNum + 1,
    read_grid(Stream, N, NewRowNum, NewAcc, Grid).

% Define the moves/2 predicate
moves(File, Moves) :-
    read_input(File, N, Grid),
    (   bfs(Grid, N, RevPath)
    ->  (   RevPath = 'IMPOSSIBLE'
        ->  Moves = 'IMPOSSIBLE'
        ;   reverse(RevPath, Moves)
        )
    ;   Moves = 'IMPOSSIBLE'
    ),
    !.