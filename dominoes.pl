/* Consider a set of dominoes. Each domino is a rectangle consisting oftwo parts and each part has a number of spots on it. 
 * The number of spots can go from 0 to 6. There are 28 different dominoes. 
 * Using four dominoes we can make a configuration as in Figure 1. 
 * Note that we used 4 different dominoes and that for each row and column the sum of the spots on the relevant parts of the dominoes is exactly 3, 
 * except for the center row and column.
 * (a) Define a data structure that represents a domino and a datastruc-ture that represents such a configuration of 4 dominoes.
 * (b) Write a predicate that checks whether a given configuration is agood one.
 * (c) Write a predicate that succeeds when two given configurationsare variants. 
 * Note that if we turn the configuration of Figure1over for example 180 degrees we get its variant in Figure 2. These 3 kinds of variants should be recognised. Note that you can alsoturn over 90 and 270 degrees.
 * (d) Write a predicate that searches all possible good configurations of 4 dominoes, that eliminates the variants and that prints theconfigurations out in the form 0 2 1 1 1 0 2 1 (i.e.  giving the number of spots on the parts of the dominoesstarting in the up ward left corner and going clockwise).
*/

val(0).
val(1).
val(2).
val(3).

domino(A, B):-
    val(A), 
    val(B),
    A + B < 4.

dominoes([A, A, _, _]):-!,
    fail.
dominoes([A, _, A, _]):-!,
    fail.
dominoes([A, _, _, A]):-!,
    fail.
dominoes([_, A, A, _]):-!,
    fail.
dominoes([_, A, _, A]):-!,
    fail.
dominoes([_, _, A, A]):-!,
    fail.

dominoes([(L1, R1), (L2, R2), (L3, R3), (L4, R4)]):-
    S11 is L1 + R1,
    S12 is L2 + S11,
    S12 = 3,
    S21 is L2 + R2,
    S22 is L3 + S21,
    S22 = 3,
    S31 is L3 + R3,
    S32 is L4 + S31,
    S32 = 3,
    S41 is L4 + R4,
    S42 is L1 + S41,
    S42 = 3,
    R2 + R4 < 4.
    
variants([A, B, C, D], [A, B, C, D]).
variants([A, B, C, D], [B, C, D, A]).
variants([A, B, C, D], [C, D, A, B]).
variants([A, B, C, D], [D, A, B, C]).

get_all_dominoes(DM):-
    findall((A, B), domino(A, B), List),
    member(M1, List),
    member(M2, List),
    member(M3, List),
    member(M4, List),
    DM = [M1, M2, M3, M4],
    dominoes(DM).
    
get_unique_dominoes(Res):-
    findall(DM, get_all_dominoes(DM), L),
    unique(L, [], Res). 

unique([], Acc, Acc):-!.

unique([H|T], Acc, Res):-    
    is_new(H, Acc), !,
    unique(T, [H|Acc], Res).

unique([H|T], Acc, Res):-    
    \+is_new(H, Acc),
    unique(T, Acc, Res).

is_new(_, []).

is_new(A, [B|_]):-
    variants(A, B), !,
    fail.

is_new(A, [B|T]):-
    \+variants(A, B),
    is_new(A, T).
