:- consult('./tp1.pl').

/* 
4a,b,d,e,i
5a, d, e, h
6a, b, e, g
*/

/*
1. 
a) X=1? X=2? No.    Since there is a cut(!) after S(2) that doesn't allow to backtrack
b) X=1 e Y=1. X=1 e Y=2. X=2, Y=1. X=2, Y=2. No.
c) X=1 e Y=1. X=1 e Y=2. No
*/

/* 
2.
Fail é utilizado para fazer sempre backtrack e obter todas as soluçoes
a) X=1. X=2. X=3. X=5. No
b) X=1. 
c) X=1. X=2. X=3.
*/

/*
3.
1º Vermelho -> Provoca alterações no código. Caso não tivesse o cut ia ter um resultado diferente.
2º verde
*/

/* 4. */
/* print_n(S, 0).
print_n(S, N) :
    char_code(S, AsciiS),
    put_code(AsciiS),
    NEW_N is N-1,
    print_n(S, NEW_N).
 */
/* b) */
print_text([]).
print_text([C | Tail]) :- put_code(C), 
    print_text(Tail).

print_text(Text, S, Padding) :-
    NumSpaces is Padding-1,
    print_n(S, 1), 
    print_n(' ', NumSpaces),
    print_text(Text),
    print_n(' ', NumSpaces),
    print_n(S, 1), 
    nl.

/* c) */
/* 
print_banner(Text, Symbol, 0) :- print_text(Text, Symbol, Padding).
print_banner(Text, Symbol, Padding) :- 
    MidY is Padding div 2,
    length(Text, TextLen),
    RowLen is TextLen + Padding*2,
    print_banner(Text, Symbol, Padding, RowLen, Padding, MidY).

print_banner(_, _, _, _, 0, _).

print_banner(Text, Symbol, Padding, RowLen, MidY, MidY) :-
    NewY is CurrY - 1,
    print_text(Text, Symbol, Padding),
    print_banner(Text, Symbol, Padding, RowLen, NewY, MidY).

print_banner(Text, Symbol, Padding, RowLen, CurrY, MidY) :-
    AuxPadding is RowLen div 2,
    print_text('', Symbol, AuxPadding),
    NewY is CurrY - 1,
    print_banner(Text, Symbol, Padding, RowLen, NewY, MidY). */

/* d) */
/* skip_line clears the buffer */

/* This function Reads the result to X */
read_number(X) :- read_number(X, 0).

read_number(X, X) :- peek_code(10), !, skip_line.

read_number(X, Acc) :-
    get_code(D),
    char_code('0', Z),
    Num is D - Z,
    Num >= 0, Num =< 9, !,  /* Validates the input only contains digits  */
    Next is Acc*10 + Num,
    read_number(X, Next).

/* e) */
/* 2 Ways to call itself until it succeeds (1) and (2) */

read_until_between(Min, Max, X) :-
    repeat/*(1)*/, read_number(X), between(Min, Max, X), !.

/* read_until_between(Min, Max, X) :- read_until_between(Min, Max, X). /* Call itself until it succeeds */ /*(2)*/

/* 5 */
/* a) */
children(Person, Children) :- findall(Child, parent(Person, Child), Children).

/* d) */
couple(X-Y) :-
    parent(X, Child),
    parent(Y, Child),
    X \= Y.


/* */
/* e) */
couples(Couple) :- setof(CoupleA-CoupleB, Child^(parent(CoupleA, Child), parent(CoupleB, Child), CoupleA @< CoupleB), Couple).

/* h) */
parents_of_two(Parents) :- setof(Parent, (Child1, Child2)^(parent(Parent, Child1), parent(Parent, Child2), Child1 @< Child2), Parents). 

/* 6 */
% a)
teachers(T) :- findall(Teacher, professor(Teacher, _Aluno), T).

% b) Utilizando findall, iria demonstrar repetidos. Podemos evitar repetidos com o setof
teachers2(T) :- setof(Teacher, Aluno^professor(Teacher, Aluno), T).

% c) 
students_of(T, S) :- bagof(Student, aluno(Student, T), S).

% d)
teachers_of(S, T) :- bagof(Teacher, professor(Teacher, S), T).

% e)
common_courses(S1, S2, C) :-
    setof(UC, ( frequenta(UC, S1), frequenta(UC, S2), S1 \== S2 ), C).
common_courses(_S1, _S2, []).

% f)
find_ucs(S, UCs) :- setof(C, frequenta(C, S), UCs).

more_than_one_course(L) :-
    setof(Student, ( C^(find_ucs(Student, C), length(C, Length), Length >= 2) ), L).

% g)
disjoint_lists([], _L2).
disjoint_lists([H | T], L2) :- 
    \+(member(H, L2)),
    disjoint_lists(T, L2).

strangers(L) :-
    setof(S1-S2, (C1, C2)^( find_ucs(S1, C1), find_ucs(S2, C2), S1 @< S2,  disjoint_lists(C1, C2) ), L).

% h)
good_groups(L) :-
    setof(S1-S2, (C, Length)^(common_courses(S1, S2, C), S1 @< S2 ,length(C, Length), Length >= 2) , L).