% NOTIFICATION!!!
% we used stack-overflow and chat-gpt
% to guide us on our journey with prolog

:- use_module(library(readutil)).

% find_digits_in_base(+N, +B, -Digits)
find_digits_in_base(0, _, []) :- !.
find_digits_in_base(N, B, Digits) :-
    N > 0,
    Digit is N mod B,
    NextN is N div B,
    find_digits_in_base(NextN, B, NextDigits),
    append(NextDigits, [Digit], Digits).

% all_digits_same(+List)
all_digits_same([]).
all_digits_same([_]).
all_digits_same([X, X | T]) :-
    all_digits_same([X | T]).

% find_smallest_base(+N, -Base)
find_smallest_base(N, Base) :-
    find_base(N, 2, Base).

% find_base(+N, +CurrentBase, -Base)
find_base(N, CurrentBase, Base) :-
    find_digits_in_base(N, CurrentBase, Digits),
    ( all_digits_same(Digits) ->
        Base = CurrentBase
    ;   NextBase is CurrentBase + 1,
        find_base(N, NextBase, Base)
    ).

% minbases(+Numbers, -Bases)
minbases([], []).
minbases([N | Ns], [B | Bs]) :-
    find_smallest_base(N, B),
    minbases(Ns, Bs).

% read_numbers_from_file(+Filename, -Numbers)
read_numbers_from_file(Filename, Numbers) :-
    open(Filename, read, Stream),
    read_line_to_codes(Stream, _), % Read and ignore the first line
    read_rest_of_file(Stream, Numbers),
    close(Stream).

% read_rest_of_file(+Stream, -Numbers)
read_rest_of_file(Stream, []) :-
    at_end_of_stream(Stream), !.
read_rest_of_file(Stream, [N | Ns]) :-
    \+ at_end_of_stream(Stream),
    read_line_to_codes(Stream, Line),
    number_codes(N, Line),
    read_rest_of_file(Stream, Ns).