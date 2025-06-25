% Διαβάζει ολόκληρο το αρχείο εισόδου και επιστρέφει τη λίστα με τους εργαζόμενους και το M
read_input(File, M, Workers) :-
    open(File, read, Stream),
    read_line(Stream, [M, _]),         % Πρώτη γραμμή: M και K (χρειαζόμαστε μόνο το M)
    read_workers(Stream, Workers),     % Επόμενες γραμμές: λίστα εργαζομένων
    close(Stream).

% Διαβάζει μια γραμμή και την μετατρέπει σε λίστα ακεραίων
read_line(Stream, Numbers) :-
    read_line_to_string(Stream, Line),
    split_string(Line, " ", "", Parts),
    maplist(number_string, Numbers, Parts).

% Διαβάζει αναδρομικά όλους τους εργαζόμενους
read_workers(Stream, []) :-
    at_end_of_stream(Stream), !.
read_workers(Stream, [employee(A, B, Diff) | Rest]) :-
    read_line(Stream, [A, B]),
    Diff is A - B,
    read_workers(Stream, Rest).

% Υπολογίζει το άθροισμα των πεδίων A στους M πρώτους εργαζόμενους και των B στους υπόλοιπους
sum_contracts(M, Employees, Profit) :-
    length(FirstM, M),
    append(FirstM, Rest, Employees),
    sum_a(FirstM, SA),
    sum_b(Rest, SB),
    Profit is SA + SB.

% Υπολογισμός αθροίσματος των A για τους πρώτους M
sum_a([], 0).
sum_a([employee(A, _, _) | Rest], Sum) :-
    sum_a(Rest, Temp),
    Sum is A + Temp.

% Υπολογισμός αθροίσματος των B για τους υπόλοιπους
sum_b([], 0).
sum_b([employee(_, B, _) | Rest], Sum) :-
    sum_b(Rest, Temp),
    Sum is B + Temp.

% Κύριο κατηγόρημα
hire(File, Profit) :-
    read_input(File, M, Workers),
    sort(3, @>=, Workers, Sorted),  % Ταξινόμηση κατά φθίνουσα Diff (A - B)
    sum_contracts(M, Sorted, Profit).

% Πολυπλοκότητα σε O(n*logn) 