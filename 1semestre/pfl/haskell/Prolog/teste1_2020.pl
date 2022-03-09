:- use_module(library(lists)).

jogo(1, sporting, porto, 1-2).
jogo(1, maritimo, benfica, 2-0).
jogo(2, sporting, benfica, 0-2).
jogo(2, porto, maritimo, 1-0).
jogo(3, maritimo, sporting, 1-1).
jogo(3, benfica, porto, 0-2).

treinadores(porto, [[1-3]-sergio_conceicao]).
treinadores(sporting, [[1-2]-silas, [3-3]-ruben_amorim]).
treinadores(benfica, [[1-3]-bruno_lage]).
treinadores(maritimo, [[1-3]-jose_gomes]).

% 1
n_treinadores(Equipa, Numero) :-
    treinadores(Equipa, List),
    length(List, Numero).

% 2
n_jornadas_treinador(Treinador, NJornadas) :-
    treinadores(_Equipa, Treinadores),
    contem_treinador(Treinador, Treinadores, [X-Y]-Treinador),
    Jornadas is Y-X + 1,
    Jornadas = NJornadas.

contem_treinador(Treinador, [[X-Y]-Treinador | _T], [X-Y]-Treinador).
contem_treinador(Treinador, [[_X-_Y]-_Nome | T], InfoTreinador) :-
    contem_treinador(Treinador, T, InfoTreinador).

% 3
ganhou(Jornada, EquipaVencedora, EquipaDerrotada) :-
    ( 
        (jogo(Jornada, EquipaVencedora, EquipaDerrotada, G1-G2), G1 > G2); 
        (jogo(Jornada, EquipaDerrotada, EquipaVencedora, G1-G2), G2 > G1)
    ).

% 4) C
% 5) E
% 6 

:- op(180, fx, o).
:- op(200, xfx, venceu).

o X venceu o Y :- ganhou(_Jornada, X, Y).

% 7
predX(N,N,_).
predX(N,A,B):-
    !,
    A \= B,
    A1 is A + sign(B - A),
    predX(N,A1,B).

% a) Se N for enviado como argumento, permite saber se N se encontra no intervalo [A, B]. Caso N seja o valor de retorno, N tem o valor de A inicialmente e permite obter todos os valores até B, incluindo este último.

% b) O cut presente é verde, uma vez que não influencia os resultados obtidos, apenas melhor a eficiência.

% 8
treinador_bom(Treinador) :-
    treinadores(Equipa, Treinadores),
    contem_treinador(Treinador, Treinadores, [X-Y]-Treinador),
    equipa_nao_derrotada(Equipa, X, Y).

nao_perdeu(Jornada, EquipaVencedora, EquipaDerrotada) :-
    ( 
        (jogo(Jornada, EquipaVencedora, EquipaDerrotada, G1-G2), G1 >= G2); 
        (jogo(Jornada, EquipaDerrotada, EquipaVencedora, G1-G2), G2 >= G1)
    ).

equipa_nao_derrotada(Equipa, Jf, Jf) :- nao_perdeu(Jf, Equipa, _Equipa2).
equipa_nao_derrotada(Equipa, Ji, Jf) :-
    nao_perdeu(Ji, Equipa, _Equipa2),
    NewJ is Ji + 1,
    equipa_nao_derrotada(Equipa, NewJ, Jf).

% 9
imprime_totobola(1, '1').
imprime_totobola(0, 'X').
imprime_totobola(-1, '2').

imprime_texto(X, 'vitoria da casa') :- X = 1.
imprime_texto(X, 'empate') :- X = 0.
imprime_texto(X, 'derrota da casa') :- X = -1.

get_code(Gcasa, Gfora, Code) :-
    Gcasa > Gfora, !, Code = 1.
get_code(Gcasa, Gfora, Code) :-
    Gfora > Gcasa, !, Code = -1.
get_code(_, _, 0).

imprime_jogos(F) :-
    jogo(N, EquipaCasa, EquipaFora, Gcasa-Gfora),
    get_code(Gcasa, Gfora, Code),
    Func =.. [F, Code, Out],
    Func,
    write('Jornada '), write(N), write(': '), write(EquipaCasa), write(' x '), write(EquipaFora), write(' - '), write(Out), nl,
    fail.
imprime_jogos(_F) :- !. % Ensure predicate succeeds

% 10) B
% 11) E

% 12
lista_treinadores(L) :-
    setof(Treinador, (Equipa, InfoTreinador, Treinadores)^(treinadores(Equipa, Treinadores), contem_treinador(Treinador, Treinadores, InfoTreinador)), L).

% 13
duracao_treinadores(L) :-
    setof(N-Treinador, (Equipa, Treinadores, N, Ti, Tf)^(treinadores(Equipa, Treinadores), contem_treinador(Treinador, Treinadores, [Ti-Tf]-Treinador), N is Tf-Ti+1), RevL),
    reverse(RevL, L).

% 14
/* COULD BE MORE EFFICIENT IF I APPEND 0 IN BOTH CORNERS AND THEN JUST SEND THE PREVIOUS LINE TO ITERATE INSTEAD OF USING NTH1 */
pascal(1, [1]) :- !.

pascal(N, L) :-
    N1 is N-1,
    pascal(N1, PrevLine),
    !, pascal(PrevLine, 1, N, L, []).

pascal(_PrevLine, Last, Last, L, Acc) :- !, append(Acc, [1], L).
pascal(PrevLine, 1, Last, L, Acc) :-
    !, append(Acc, [1], NewAcc),
    pascal(PrevLine, 2, Last, L, NewAcc).

pascal(PrevLine, Idx, Last, L, Acc) :- 
    BefIdx is Idx - 1,
    nth1(BefIdx, PrevLine, PrevLineBef),    % Elem (x-1, y-1)
    nth1(Idx, PrevLine, PrevLineAfter),     % Elem (x, y-1)
    CurrElem is PrevLineBef + PrevLineAfter,
    append(Acc, [CurrElem], NewAcc),
    NewIdx is Idx+1,
    pascal(PrevLine, NewIdx, Last, L, NewAcc).
