% TO-DO: 1.c, 1.d, 3, 4, 5.d, 5.e, 6.b, 6.c, 7, 8.b, 8.c, 8.d, 9, 11

% 1.a
% 1st Argument is input and 2nd works as output
fact(0,1).
fact(1,1).
fact(N, F) :- N > 0,
    N1 is N-1,
    fact(N1, FN1),
    F is N*FN1.

% Tail implementation (Better efficiency)
fact2(N, F) :- fact2(N, F, 1).
fact2(0, F, F).
fact2(N, F, Acc) :- N > 0,
    N1 is N-1,
    NewAcc is Acc*N,
    fact2(N1, F, NewAcc).


% 1.c
fibonnaci(0,0).
fibonnaci(1,1).
fibonnaci(N, F) :- N > 0,
    N1 is N-1,
    N2 is N-2,
    fibonnaci(N1, Fib1),
    fibonnaci(N2, Fib2),
    F is Fib1+Fib2.

% 1.d
isPrime(X) :- X > 0, isPrime(X,2).
isPrime(X, X).
isPrime(X, Y) :- 
    Y < X,
    Y1 is Y+1,
    Res is X mod Y,
    Res =\= 0,
    isPrime(X, Y1).

% 3
cargo(tecnico, eleuterio).
cargo(tecnico, juvenaldo).
cargo(analista, leonilde).
cargo(analista, marciliano).
cargo(engenheiro, osvaldo).
cargo(engenheiro, porfirio).
cargo(engenheiro, reginaldo).
cargo(supervisor, sisnando).
cargo(supervisor_chefe, gertrudes).
cargo(secretaria_exec, felismina).
cargo(diretor, asdrubal).
chefiado_por(tecnico, engenheiro).
chefiado_por(engenheiro, supervisor).
chefiado_por(analista, supervisor).
chefiado_por(supervisor, supervisor_chefe).
chefiado_por(supervisor_chefe, diretor).
chefiado_por(secretaria_exec, diretor).

superior(X, Y) :-
    cargo(C1, X),
    cargo(C2, Y),
    chefiado_por(C2, C1).

superior(X, Y) :- cargo(C2, Y),
    chefiado_por(C2, C3),
    cargo(C3, P3),
    superior(X, P3).

/* 4 
a) yes
b) no
c) yes
d) yes
e) yes
f) yes
g) no
h) yes
i) yes
j) yes
k) yes
l) yes -> One = leic && Rest = [Two | Tail]
 */

% 5.d
inner_product(List1, List2, Result) :- inner_product(List1, List2, Result, 0).

inner_product([], [], Result, Result).

inner_product([H1 | T1], [H2 | T2], Result, Acc) :- 
    CurrProd is H1*H2 + Acc,
    inner_product(T1, T2, Result, CurrProd).

% 5.e
count(Elem, List, N) :- count(Elem, List, N, 0).
count(_, [], N, N).  % This says the Result (N) should be equal to the Accumulator
count(Elem, [Elem | T], N, Acc) :- NewAcc is Acc+1,
    count(Elem, T, N, NewAcc).
count(Elem, [_ | T], N, Acc) :- count(Elem, T, N, Acc).

% 6.b
del_one(Elem, List1, List2) :- del_one(Elem, List1, List2, []).

del_one(Elem, [Elem | T], List2, History) :-
    append(History, T, List2).

del_one(Elem, [H | T], List2, History) :- 
    append(History, [H], NewHistory),
    del_one(Elem, T, List2, NewHistory).


% 7
% a)
list_append([], L2, L2).

list_append([H1 | T1], L2, [H1 | T3]) :-
    list_append(T1, L2, T3).

% b)
list_member(Elem, List) :- list_append(_Part1, [Elem | _Part2], List).

% c)
list_last(List, Last) :- list_append(_ExceptLast, [Last | []], List).

% d)
list_nth(N, List, Elem) :- length(L1, N),
    list_append(L1, [Elem | _Tail], List).

% e)
list_append([L1 | []], L1). 

list_append([L1 | TailL], List) :-
    list_append(L1, LRem, List),
    list_append(TailL, LRem).

% f)
list_del(List, Elem, Res) :-
    list_append(L1, [Elem | L2], List),
    list_append(L1, L2, Res).

% g)
list_before(First, Second, List) :-
    list_append(_L1, [First | L2], List),
    list_append(_L21, [Second | _L22], L2).

% h)
list_replace_one(X, Y, List1, List2) :-
    list_append(L1, [X | L2], List1),
    list_append(L1, [Y | L2], List2).

% i)
list_repeated(X, List) :-
    list_append(_L1, [X | Rem], List),
    list_append(_L2, [X | _Rem2], Rem).

% j)
list_slice(List1, Index, Size, List2) :-
    length(Prefix, Index),
    list_append(Prefix, Rem, List1),
    length(List2, Size),
    list_append(List2, _Rem2, Rem).

% k)
list_shift_rotate(List1, N, List2) :-
    length(Sufix, N),
    list_append(Sufix, Rem, List1),
    list_append(Rem, Sufix, List2).

/* 8 */
list_to(0, _List) :- !.
list_to(N, List) :-
    N > 0,
    NewN is N-1,
    list_to(NewN, Front),
    append(Front, [N], List).

list_to2(N, List) :- list_to2(N, List, []).

list_to2(0, List, List) :- !.
list_to2(N, List, Acc) :-
    NewN is N-1, 
    append([N], Acc, NewAcc),
    list_to2(NewN, List, NewAcc).
    
