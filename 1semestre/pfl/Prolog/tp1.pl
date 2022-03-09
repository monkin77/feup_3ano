/** 
 * Exercício 1
*/
% a)

:-dynamic male/1, female/1, parent/2.

female('Grace').
male('Frank').
female('DeDe').
male('Jay').
female('Gloria').
male('Javier').
female('Bard').
male('Merle').
male('Phil').
female('Claire').
male('Mitchell').
male('Joe').
male('Manny').
female('Cameron').
male('Pameron').
male('Bo').
male('Dylan').
female('Haley').
male('Alex').
male('Luke').
female('Lily').
male('Rexford').
male('Calhoun').
male('George').
female('Poppy').

parent('Grace', 'Phil').
parent('Frank', 'Phil').
parent('DeDe', 'Claire').
parent('DeDe', 'Mitchell').
parent('Jay', 'Claire').
parent('Jay', 'Mitchell').
parent('Jay', 'Joe').
parent('Gloria', 'Joe').
parent('Gloria', 'Manny').
parent('Javier', 'Manny').
parent('Barb', 'Cameron').
parent('Barb', 'Pameron').
parent('Merle', 'Cameron').
parent('Merle', 'Pameron').
parent('Phil', 'Haley').
parent('Phil', 'Alex').
parent('Phil', 'Luke').
parent('Claire', 'Luke').
parent('Claire', 'Luke2').
parent('Claire', 'Luke3').
parent('Mitchell', 'Lily').
parent('Mitchell', 'Rexford').
parent('Cameron', 'Lily').
parent('Cameron', 'Rexford').
parent('Pameron', 'Calhoun').
parent('Bo', 'Calhoun').
parent('Dylan', 'George').
parent('Dylan', 'Poppy').
parent('Haley', 'George').
parent('Haley', 'Poppy').

/* b)
i) female('Haley'). -> yes
ii) male('Gil'). -> no
iii) parent('Frank', 'Phil'). -> yes
iv) parent(X, 'Claire').
v) parent('Gloria', X).
vi) parent(Jay, X), parent(X, Y).
vii) parent(X, 'Lily'), parent(Y, X).
viii) parent('Alex', X).
ix) parent('Jay', X), \+parent('Gloria', X).
Could've used '_' instead of variables such as 'X', when we don't need to store the value into the variable
*/

% c)
father(X,Y) :- parent(X, Y), male(X).
grandparent(X,Y) :- parent(X, Z), parent(Z, Y).
grandmother(X,Y) :- grandparent(X,Y), female(X).
siblings(X,Y) :- parent(Z, X), parent(Z, Y), parent(W, X), parent(W, Y), Z \= W.
halfSiblings(X,Y) :- parent(Z,X), parent(Z, Y), parent(W,X), parent(Q,Y), Z \= W, Z\=Q, W \= Q.

% Exercicio 2
leciona(algoritmos, adalberto).
leciona(bases_de_dados, bernardete).
leciona(compiladores, capitolino).
leciona(estatistica, diogenes).
leciona(redes, ermelinda).


frequenta(algoritmos, alberto).
frequenta(algoritmos, bruna).
frequenta(algoritmos, cristina).
frequenta(algoritmos, diogo).
frequenta(algoritmos, eduarda).

frequenta(bases_de_dados, antonio).
frequenta(bases_de_dados, bruno).
frequenta(bases_de_dados, cristina).
frequenta(bases_de_dados, duarte).
frequenta(bases_de_dados, eduardo).

frequenta(compiladores, alberto).
frequenta(compiladores, bernardo).
frequenta(compiladores, clara).
frequenta(compiladores, diana).
frequenta(compiladores, eurico).

frequenta(estatistica, antonio).
frequenta(estatistica, bruna).
frequenta(estatistica, claudio).
frequenta(estatistica, duarte).
frequenta(estatistica, eva).

frequenta(redes, alvaro).
frequenta(redes, beatriz).
frequenta(redes, claudio).
frequenta(redes, diana).
frequenta(redes, eduardo).


% regras

aluno(X, Y) :- frequenta(UC, X), leciona(UC, Y).

professor(X, Y) :- aluno(Y, X).

colega(X, Y) :- frequenta(UC, X), frequenta(UC, Y), (X \= Y).
colega(X, Y) :- professor(X, _), professor(Y, _), (X \= Y).


/* Exercicio 6
a)
    pairs(X,Y)
        d(X) -> X=2
        q(Y) -> Y=4 -- Resposta: X=2, y=4 ? no (Backtrack)
        q(Y) -> Y=16 -- Resposta X=2, y=16 ? no (Backtrack)
        d(X) -> X=4
        q(Y) -> Y=4 -- Resposta: X=4, y=4 ? no (Backtrack)
        q(Y) -> Y=16 -- Resposta: X=4, y=16 ? no (Backtrack)
    pairs(X, X)
        u(X) -> X=1 -- Resposta: X=1, Y=1? no (Backtrack)
    no
*/ 
pairs(X, Y):- d(X), q(Y).
pairs(X, X):- u(X).
u(1).
d(2).
d(4).
q(4).
q(16).

/* 7 */
a(a1, 1).
a(_A2, 2).
a(a3, _N).
b(1, b1).
b(2, _B2).
b(_N, b3).
c(X, Y):- a(X, Z), b(Z, Y).
d(X, Y):- a(X, Z), b(Y, Z).
d(X, Y):- a(Z, X), b(Z, Y).
