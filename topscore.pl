/** After the exams of January, Eveline has the scores of the students forthe courses. 
  * For example, student Danny obtained a 20 on FAI and a15 on PLPM, Jonas obtained a 18 on PLPM, a 14 on FAI, and a 4 on UAI.
  * (a) Represent this information in two different ways: by Prolog factsand by Prolog terms. 
  * Use your 2 representations to representtheabove example.
  * (b) Define for both representations the predicate top score that determines for a given course the student with the top score.
  * You may assume that for each course there is exactly 1 student witha top score.
  * In the above example, Danny is the student with the top scorefor FAI, whereas for UAI it is Jonas.
  */

student(fai, sumit, 13).
student(fai, danny, 18).
student(fai, gerda, 17).
student(fai, tinne, 15).

student(plpm, sumit, 13).
student(plpm, danny, 17).
student(plpm, gerda, 19).
student(plpm, tinne, 15).

topscore(Course, Student):-
    findall((Name, Score), student(Course, Name, Score), List),
    mysort(List, SortedList),
    getmax(SortedList, Student).

mysort([A], [A]):-!.

mysort(List,SortedList):-
    split(List, L, R),
    mysort(L, SL),
    mysort(R, SR),
    merge(SL, SR, SortedList).

split([A, B], [A], [B]):-!.

split(List, L, R):-
    length(List, Len),
    LenH is Len/2,
    getList(List, L, R, LenH, 0).

getList([H|T], [H|L], R, LenH, CLen):-
    CLen < LenH, !,
    CLen2 is CLen + 1,
    getList(T, L, R, LenH, CLen2).

getList([H|T], L, [H|R], LenH, CLen):-
    getList(T, L, R, LenH, CLen).

getList([], [], [], _, _).

merge([], [A], [A]):-!.
merge([A], [], [A]):-!.
merge([], [], []):-!.

merge([(A, Score1)|T1], [(B, Score2)|T2], [(A, Score1)|T]):-
    Score1 >= Score2, !,
    merge(T1, [(B, Score2)|T2], T).

merge([(A, Score1)|T1], [(B, Score2)|T2], [(B, Score2)|T]):-
    Score1 < Score2, !,
    merge([(A, Score1)|T1], T2, T).

getmax([(Student, _)|_], Student).

