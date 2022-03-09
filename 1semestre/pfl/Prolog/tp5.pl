:- use_module(library(lists)).
:- use_module(library(between)).

/* 1 */

double(X, Y):- Y is X*2.

/* a) */
map(Pred, L1, L2) :-
    map(Pred, L1, L2, []).

map(_, [], L2, L2).

map(Pred, [H|T], L2, Acc) :-
    G =.. [Pred, H, NewElem],
    G,
    append(Acc, [NewElem], NewAcc),
    map(Pred, T, L2, NewAcc).

/* b) */
sum(A, B, S):- S is A+B.

fold(_, Final, [], Final).

fold(Pred, Start, [H|T], Final) :-
    G =.. [Pred, Start, H, NewStart],
    G,
    fold(Pred, NewStart, T, Final).

/* c) */
even(X):- 0 =:= X mod 2.

separate(List, Pred, Yes, No) :- separate(List, Pred, Yes, No, [], []).

separate([], _, Yes, No, Yes, No).

separate([H | T], Pred, Yes, No, YesAcc, NoAcc) :-
    G =.. [Pred, H],
    G, !,
    append(YesAcc, [H], NewAcc),
    separate(T, Pred, Yes, No, NewAcc, NoAcc).

separate([H | T], Pred, Yes, No, YesAcc, NoAcc) :-
    append(NoAcc, [H], NewAcc),
    separate(T, Pred, Yes, No, YesAcc, NewAcc).

/* d) */
ask_execute :-
    read(X), X.

/* 2 */
my_arg(Idx, Term, Arg) :-
    Term =.. [_ | Args],
    nth1(Idx, Args, Arg).

my_functor(Term, Name, Arity) :-
    Term =.. [Name | Args],
    length(Args, Arity).

/* b) */
univ(Term, [Name | Args]) :-
    length(Args, ArgsLength),
    functor(Term, Name, ArgsLength),
    findall(Arg, ( between(1, ArgsLength, CurrIdx), arg(CurrIdx, Term, Arg) ), Args).
    


/* 3 
a) o ra em cima
b) não dá porque o la nao pode ter filhos à direitia
c) la em cima e na à esquerda
d) não dá porque o ra nao pode ter filhos à esquerda
e) nao dá porque nao é associativo de lado nenhum
f) 2º lá em cima
g) 1º ra em cima
*/

/* 4
a) 

*/

/* 5 */
% a
/* flight(T).
from(X, Y).
to(X, Y).
at(X, Y).

:- op(500, fy, flight).
:- op(500, xfy, from).
:- op(500, xfy, to).
:- op(500, xfy, at).

% b)
if(Cond).
then(Cond).
else(Cond).

:- op(500, xf, if).
:- op(500, yfx, then).
:- op(500, yfx, else). */

map2(_Pred, [], []) :- !.
map2(Pred, [H | T], [H2 | T2]) :-
    G =.. [Pred, H, H2], G,
    map(Pred, T, T2).

% 5
:- op(400, fx, flight).
:- op(401, xfx, from).
:- op(402, xfx, to).
:- op(403, xfx, at).

flight X from Y to Z at K :-
    format('flight ~s will go from ~s to ~s at the time: ~d', [X, Y, Z, K]).

:- op(400, fx, if).
:- op(401, xfx, then).
:- op(402, xfx, else).

if X then Y else Z:- X, Y.
if X then Y else Z:- \+X, Z.


even(X) :- X < 20,
    Mod is X rem 2,
    Mod =:= 0.

test(Res) :- findall(Num, (between(1,20, Num), even(Num)), Res).