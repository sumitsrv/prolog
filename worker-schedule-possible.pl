worker(danny, 3, 7).
worker(jef, 2, 2).
worker(ann, 2, 4).

possible(Workers, TotalShifts, Shifts):-
    generateShifts(Workers, TotalShifts, Shifts),
    validateShiftsForCount(Shifts, []),
    validateShiftsForOrder(Shifts).

generateShifts(Workers, NumOfShifts, Shifts):-
    length(Shifts, NumOfShifts),
    generateShifts_(Shifts, Workers).

generateShifts_([], _).

generateShifts_([H|L], Workers):-
    member(H, Workers),
    worker(H, _, _),
    generateShifts_(L, Workers).

validateShiftsForCount([], _).

validateShiftsForCount([H|L], Validated):-
    member(H, Validated),
    validateShiftsForCount(L, Validated).

validateShiftsForCount([H|L], Validated):-
    \+member(H, Validated),
    worker(H, Mi, Ma),
    checkCount(1, Mi, Ma, H, L),
    append([H], Validated, V1),
    validateShiftsForCount(L, V1).

checkCount(Count, Mi, Ma, _, []):-
    Count >= Mi,
    Count =< Ma.

checkCount(Count, Mi, Ma, X, [X|L]):-!,
    Count =< Ma,
    Count1 is Count + 1,
    checkCount(Count1, Mi, Ma, X, L).

checkCount(Count, Mi, Ma, X, [_|L]):-
    checkCount(Count, Mi, Ma, X, L).

validateShiftsForOrder([_H]).
validateShiftsForOrder([]).

validateShiftsForOrder([H1,H2|T]):-
    H1 \= H2,
    validateShiftsForOrder([H2|T]).
