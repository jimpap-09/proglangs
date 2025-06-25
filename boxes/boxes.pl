% === Κύρια predicate που λύνει το πρόβλημα από λίστα Sizes και στόχο M ===
boxes(Sizes, M, Result) :-
    M > 0,
    setof(Combination, combination_sum(Sizes, M, Combination), Combinations),
    sort_combinations(Combinations, SortedCombinations),
    sort(SortedCombinations, Result).

% === Βρίσκει έναν συνδυασμό που αθροίζει σε M ===
combination_sum(_, 0, []).
combination_sum(Sizes, M, [X|Xs]) :-
    member(X, Sizes),
    M1 is M - X,
    M1 >= 0,
    combination_sum(Sizes, M1, Xs).

% === Ταξινομεί εσωτερικά κάθε συνδυασμό για αφαίρεση διπλοτύπων ===
sort_combinations([], []).
sort_combinations([L|Ls], [Sorted|SortedLs]) :-
    msort(L, Sorted),
    sort_combinations(Ls, SortedLs).

% === boxes(File, Solution): διαβάζει από αρχείο και επιστρέφει λύση ===
boxes(File, Solution) :-
    read_boxes_data(File, Sizes, M),
    boxes(Sizes, M, AllSolutions),
    member(Solution, AllSolutions).

% === Διαβάζει δεδομένα από αρχείο ===
read_boxes_data(File, Sizes, M) :-
    open(File, read, Stream),
    read_line_to_codes(Stream, Line1),
    read_line_to_codes(Stream, Line2),
    close(Stream),
    line_to_numbers(Line1, [_, M]),       % αγνοούμε το N
    line_to_numbers(Line2, Sizes).

% === Μετατρέπει γραμμή σε λίστα αριθμών ===
line_to_numbers(Codes, Numbers) :-
    string_codes(Str, Codes),
    split_string(Str, " ", "", StrList),
    maplist(number_string, Numbers, StrList).

% === Για βοηθεια στον κωδικα αυτο εγινε χρηση του chatGPT και stackoverflow ===  