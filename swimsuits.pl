:- use_module(library(clpfd)).

swim(FNs, LNs, SS, CLs):-
    FNs = [Sarah, Rachel, Melony, Amelia, Julia],
    FNs ins 1..5,
    all_different(FNs),
    LNs = [Sanford, Travers, James, West, Couch],
    LNs ins 1..5,
    all_different(LNs),
    SS = [S1, S2, S3, S4, S5],
    SS ins 1..2,
    CLs = [Red, White, Blue, Yellow, Black],
    CLs ins 1..5,
    all_different(CLs),
    Rachel #= Travers,
    Rachel #\= Red,
    Rachel #= White - 1,
    setSwimPiece(SS, White, 1),
    Melony #\= James,
    Melony #= 1,
    setSwimPiece(SS, 2, 1),
    setSwimPiece(SS, Yellow, 1),
    Amelia #\= West,
    setSwimPiece(SS, Amelia, 1),
    Rachel #= Couch - 1,
    Rachel #= Blue + 2,
    Julia #\= Couch,
    setSwimPiece(SS, James, 2),
    James #\= 5,
    James #\= Julia,
    James #\= Black,
    James #\= West,
    Julia #\= 5,
    Julia #\= Black,
    Julia #\= West,
    Black #= S21,
    Black #\= 5,
    Black #\= West,
    West #\= 5.
    
setSwimPiece([Val|_], 1, Val).

setSwimPiece(SS, Count, Val):-
    var(Count),
    member(Count, [1,2,3,4,5]),
    setSwimPiece(SS, Count, Val).

setSwimPiece([_|L], Count, Val):-
    nonvar(Count),
    Count > 1,
    Count1 is Count - 1,
    setSwimPiece(L, Count1, Val).


