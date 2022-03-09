male(phil).
female(calire).
male(luke).
parent(phil, luke).
parent(claire, luke).
% father(x,y) :- parent(x,y), male(x)

/* 
    Input to terminal:
    male(phil). -> yes
    male(x).
    male(_x). -> yes
*/

between(Z, X, Y) :- % does not generate results
    X =< Z,
    Y >= Z.

customSum(X, Y, Z) :-   % Can't do customSum(1, X, 3). Need to test for instantiation
    Z is X + Y.