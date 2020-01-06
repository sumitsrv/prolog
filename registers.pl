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


%Perform swap of two values in a list.
perform_swap(List, X, Y, Res):-
    ps(List, X, Y, 1, 1, _, _, Res).

ps([], _, _, _, _, _, _, []).

%Neither source, nor destination
ps([H|T], X, Y, A, B, E1, E2, [H|Res]):-
    X\=A,
    Y\=B,
    AN is A +1,
    BN is B+1,
    ps(T, X, Y, AN, BN, E1, E2, Res).

%Source
ps([H|T], X, Y, X, B, H, E2, [E2|Res]):-
    Y\=B,
    AN is X+1,
    BN is B+1,
    ps(T, X, Y, AN, BN, H, E2, Res).

%Destination
ps([H|T], X, Y, A, Y, E1, H, [E1|Res]):-
    A\=X,
    AN is A+1,
    BN is Y+1,
    ps(T, X, Y, AN, BN, E1, H, Res).




