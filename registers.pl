%Copy from N to 1.
perform_copy(List, X, Res):-
    length(List, L),
    L = X,
    pc(List, X, 1, 1, Res, _).

%Copy from I to I +1.
perform_copy(List, X, Res):-
    length(List, L),
    L \= X,
    Y is X +1,
    pc(List, X, Y, 1, Res, _).

pc([], _, _, _, [], _).

%Neither source, nor destination
pc([H|T], X, Y, CL, [H|Res], SV):-
    CL \= X,
    CL \= Y,
    NL is CL + 1,
    pc(T, X, Y, NL, Res, SV).

%Source location
pc([H|T], X, Y, X, [H|Res], H):-
    Y \= X,
    NL is X + 1,
    pc(T, X, Y, NL, Res, H).

%Destination location
pc([_|T], X, Y, Y, [SV|Res], SV):-
    Y \= X,
    NL is Y + 1,
    pc(T, X, Y, NL, Res, SV).

