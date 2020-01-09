/**
  * Transpose a 2D matrix. 
  * Usage: transpose([[a1, a2, a3, a4], [b1, b2, b3, b4]], Transpose).
*/
transpose(Matrix, Transpose):-
    initTranspose(Matrix, Transpose),
    traverse_matrix(Matrix, Transpose, Transpose).

initTranspose([Row1|L], Transpose):-
    length(Row1, LenRow),
    length(Transpose, LenRow),
    length([Row1|L], LenCol),
    initTRows(Transpose, LenCol).

initTRows([], _).
initTRows([H|L], Len):-
    length(H, Len),
    initTRows(L, Len).

traverse_matrix([[]], _, _).

traverse_matrix([[MRV|MRL]|ML], [[MRV|_TRL]|TL], Transpose):-!,
    traverse_matrix([MRL|ML], TL, Transpose).

traverse_matrix([[MRV|MRL]|ML], [[_TRV|TRL]|TL], Transpose):-
    traverse_matrix([[MRV|MRL]|ML], [TRL|TL], Transpose).

traverse_matrix([[]|ML], [], Transpose):-
    traverse_matrix(ML, Transpose, Transpose).
