:- use_module(library(clpfd)).

/*The great mezzo-soprano Flora Nebbiacorno has retired fromthe inter-national opera stage, but she still teaches master classes regularly. 
 * At a recent class, her five students were one soprano, one mezzo-soprano,two tenors, and one bass. 
 * (The first two voice types are women’s, andthe last two are men’s). 
 * Their first names are in random order Chris,J.P., Lee, Pat, and Val – any of which could belong to a man or a woman. 
 * Their last names are Kingsley, Robinson, Robinson (the two are unrelated but have the same last name), Ulrich, and Walker. 
 * You also know that:
 * 1. The first and second students were, in some order, Pat and the bass.
 * 2. At least one of the second and the third students is a tenor.
 * 3. Kingsley and the fifth student (who isn’t named Robinson) were, in someorder, a mezzo-soprano and a tenor.
 * 4. Neither the third student, whose name is Robinson, nor Walker has thefirst name of Chris.
 * 5. Ulrich is not the bass or the mezzo-soprano.
 * 6. Neither Lee or Val (who wasn’t third) is a tenor.
 * 7. J.P. wasn’t third, and Chris wasn’t fifth.
 * 8. The bass isn’t named Robinson. 
 * Write a program to determine the order in which these five sangforthe class, identifying each by full name and voice type.Indicate whether you are using CLP or just normal Prolog. Also indi-cate where in your code you are dealing with each of the hints.
 * Implementation with CLP.
 * Execute using - 
 * m_students(Vs, FNs, LNs, Ins),
    labeling([], Vs),
    labeling([], FNs),
    labeling([], LNs),
    labeling([], Ins).
*/

m_students(Vs, FNs, LNs, Ins):-
    Vs = [V1, V2, V3, V4, V5],
    V3 in 1..2,
    V1 #= 1,
    V2 #= 1,
    V4 #= 2,
    V5 #= 2,
    FNs = [Chris, JP, Lee, Pat, Val],
    FNs ins 1..5,
    all_different(FNs),
    LNs = [Kingsley, Robinson1, Robinson2, Ulrich, Walker],
    LNs ins  1..5,
    all_different(LNs),
    Ins = [_, Mazzo_Soprano, Tenor1, Tenor2, Bass],
    Ins ins 1..5,
    all_different(Ins),
    Pat in 1..2,
    Bass in 1..2,
    Pat #\= Bass,
    Tenor1 in 2..3 #<==> T1,
    Tenor2 in 2..3 #<==> T2,
    T1 + T2 #>= 1,
    Robinson1 #\= 5,
    Robinson2 #\= 5,
    Kingsley #= Mazzo_Soprano #<==> K1,
    Kingsley #= Tenor1 #<==> K2,
    Kingsley #= Tenor2 #<==> K3,
    K1 + K3 + K2 #= 1,
    Robinson1 #= 3 #<==> LN3_1,
    Robinson2 #= 3 #<==> LN3_2,
    LN3_1 + LN3_2 #= 1,
    Chris #\= 3,
    Walker #\= Chris,
    Ulrich #\= Bass,
    Ulrich #\= Mazzo_Soprano,
    Lee #\= Tenor1 /\ Tenor2,
    Val #\= Tenor1 /\ Tenor2,
    Val #\= 3,
    JP #\= 3,
    Chris #\= 5,
    Bass #\= Robinson1 /\ Robinson2.


/*
 * Implementation without CLP.
 * Execute using:
 *		 music(Sd).
 */

:- use_rendering(table,
		 [header(s('FirstName', 'LastName', 'Instrument', 'Voice'))]).

music(Sd):-
    length(Sd, 5),
    Sd = [s(_, _, _, w), s(_, _, _, w), _, s(_, _, _, m), s(_, _, _, m)],
    voiceForThird(Sd),
    member(s(pat, _, _, _), Sd),
    member(s(lee, _, _, _), Sd),
    member(s(chris, _, _, _), Sd),
    member(s(val, _, _, _), Sd),
    member(s(jp, _, _, _), Sd),
    member(s(_, kingsley, _, _), Sd),
    member(s(_, robinson, _, _), Sd),
    member(s(_, walker, _, _), Sd),
    member(s(_, ulrich, _, _), Sd),
    member(s(_, _, mezzo_soprano, _), Sd),
    member(s(_, _, soprano, _), Sd),
    member(s(_, _, bass, _), Sd),
    member(s(_, _, tenor, _), Sd),
    patAndBass(Sd, s(pat, _, _, _), s(_, _, bass, _)), 
    secondAndThirdTenor(Sd, s(_, _, tenor, _), s(_, _, tenor, _)),
    fifthStudentAndKingsley(Sd),
    thirdStudentAndWalker(Sd),
    ulrich(Sd),
    leeAndVal(Sd),
    jpAndChris(Sd),
    bassAndRobinson(Sd),
    twoRobinson(Sd).
    
twoRobinson(Sd):-
    member(s(F1, robinson, _, _), Sd),
    member(s(F2, robinson, _, _), Sd),
    F1 \= F2.
    
patAndBass(Sd, A, B):-
    Sd = [A, B, _, _, _].
    
patAndBass(Sd, A, B):-
    Sd = [B, A, _, _, _].

secondAndThirdTenor(Sd, A, _):-
    Sd = [_, A, _, _, _].

secondAndThirdTenor(Sd, _, A):-
    Sd = [_, _, A, _, _].

secondAndThirdTenor(Sd, A, B):-
    Sd = [_, A, B, _, _].

secondAndThirdTenor(Sd, A, B):-
    Sd = [_, B, A, _, _].

fifthStudentAndKingsley(Sd):-
    member(s(_, kingsley, mezzo_soprano, _), Sd),
    Sd = [_, _, _, _, s(_, L, tenor, _)],
    member(L, [ulrich, walker]).

fifthStudentAndKingsley(Sd):-
    member(s(_, kingsley, tenor, _), Sd),
    Sd = [_, _, _, _, s(_, L, mezzo_soprano, _)],
    member(L, [ulrich, walker]).
    
thirdStudentAndWalker(Sd):-
    Sd = [_, _, s(F1, robinson, _, _), _, _],
    member(F1, [jp, lee, pat, val]),
    member(s(F2, walker, _, _), Sd),
    member(F2, [jp, lee, pat, val]),
    F1 \= F2.

ulrich(Sd):-
    member(s(_, ulrich, I, _), Sd),
    member(I, [tenor, soprano]).

leeAndVal(Sd):-
    member(s(lee, _, I1, _), Sd),
    member(I1, [soprano, mezzo_soprano, bass]),
    member(s(val, _, I2, _), Sd),
    member(I1, [soprano, mezzo_soprano, bass]),
    I1 \= I2.

jpAndChris(Sd):-
    Sd = [_, _, s(F1, _, _, _), _, s(F2, _, _, _)],
    member(F1, [chris, lee, pat, val]),
    member(F2, [jp, lee, pat, val]),
    F1 \= F2.

bassAndRobinson(Sd):-
    member(s(_, L, bass, _), Sd),
    member(L, [kingsley, ulrich, walker]).

voiceForThird(Sd):-
    Sd = [_, _, s(_, _, _, m), _, _].

voiceForThird(Sd):-
    Sd = [_, _, s(_, _, _, w), _, _].
