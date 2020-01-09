magic_series(N, Series):-
    length(Series, N), %establish the lenght of the series
    generate_series(N, Series), %generate a series
    validate_series(Series). %validate the generated series

generate_series(N, Series):-
    Max is N-1,
    findall(X, generate_pos_num(X, 0, Max), List),
    generate_members(List, Series).

%Arbitrarily select a number from the provided list to be the member of the 'Magic Series'. There is no validation done on this set of generated numbers.
generate_members(_, []).
generate_members(List, [H| L]):-
    member(H, List),
    generate_members(List, L).

%Generates positive numbers in the range of 'Min' and 'Max'.    
generate_pos_num(Min, Min, _).
generate_pos_num(N, Min, Max):-
    Min1 is Min + 1,
    Min1 =< Max,
    generate_pos_num(N, Min1, Max).

validate_series(Series):-
    validate_(Series, Series, 0).

%Validate for each position 'Pos' with count 'Val' in the given 'Series' list.    
validate_(_, [], _).
validate_(Series, [Val|L], Pos):-
    n_occurences(Pos, Val, Series),
    Pos1 is Pos + 1,
    validate_(Series, L, Pos1).

%validate the number of occurences of position 'N'. 'X' is the count found in list.    
n_occurences(_, 0, []).
n_occurences(N, X, [N|L]):-
    X1 is X-1,
    n_occurences(N, X1, L).

n_occurences(N, X, [H|L]):-
    H =\= N,
    n_occurences(N, X, L).
