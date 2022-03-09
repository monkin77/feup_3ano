/* 
1) a c
2) a c d h
 */ 

:- consult('./tp1.pl').

 /* 1 */
 /* a */
addPerson :-
    write('Gender: '),
    read(Gender),
    nl,
    write('Name: '),
    read(Name),
    addPerson(Gender, Name).

addPerson(male, Name) :-
    !, assert(male(Name)).

addPerson(female, Name) :-
    !, assert(female(Name)).

/* c) */
remove_person :-
    write('Person name:'),
    read(Name),
    nl,
    retractall(male(Name)),
    retractall(female(Name)),
    retractall(parent(Name, _)),
    retractall(parent(_, Name)).

/* 2 */
% flight(origin, destination, company, code, hour, duration)
flight(porto, lisbon, tap, tp1949, 1615, 60).
flight(lisbon, madrid, tap, tp1018, 1805, 75).
flight(lisbon, paris, tap, tp440, 1810, 150).
flight(lisbon, london, tap, tp1366, 1955, 165).
flight(london, lisbon, tap, tp1361, 1630, 160).
flight(porto, madrid, iberia, ib3095, 1640, 80).
flight(madrid, porto, iberia, ib3094, 1545, 80).
flight(madrid, lisbon, iberia, ib3106, 1945, 80).
flight(madrid, paris, iberia, ib3444, 1640, 125).
flight(madrid, london, iberia, ib3166, 1550, 145).
flight(london, madrid, iberia, ib3163, 1030, 140).
flight(porto, frankfurt, lufthansa, lh1177, 1230, 165).

/* a */
get_all_nodes(Airports) :- setof(Airport, (Dest,A,B,C,D)^(flight(Airport, Dest,A,B,C,D); flight(Dest, Airport, A,B,C,D)), Airports).

/* c */
find_flights(Origin, Dest, Flights) :- find_flights(Origin, Dest, Flights, [Origin]).

find_flights(Dest, Dest, Acc, Acc).
find_flights(Origin, Dest, Flights, Acc) :-
    flight(Origin, Middle, _, _, _, _),
    \+(member(Middle, Acc)),  % Avoid infinite loops
    append(Acc, [Middle], NewAcc),
    find_flights(Middle, Dest, Flights, NewAcc).


/* d) */
find_flights_breadth(Origin, Dest, Flights) :-
    find_flights_breadth([Origin], Dest, Flights, []).

find_flights_breadth([Dest | _Rem], Dest, Flights, Acc) :- append(Acc, [Dest], Flights).
find_flights_breadth([Origin | Rem], Dest, Flights, Acc) :-
    Origin \== Dest,
    findall(Middle, Rem^( flight(Origin, Middle, _, _, _, _), \+(member(Middle, Acc)), \+(member(Middle, Rem)) ), NewMids),
    append(Rem, NewMids, NewPaths),
    append(Acc, [Origin], NewAcc),
    find_flights_breadth(NewPaths, Dest, Flights, NewAcc).

find_flights_breadth([Dest | Rem], Dest, Flights, Acc) :-   % if origin = dest and want more solutions (remove head)
    find_flights_breadth(Rem, Dest, Flights, Acc).

% h) 
find_circular_trip(MaxSize, Origin, Cycle) :-
    find_circular_trip(MaxSize, Origin, Cycle, [Origin]).

find_circular_trip(_Size, FirstNode, [FirstNode | Rem], [FirstNode | Rem]).
find_circular_trip(Size, Origin, Cycle, [FirstNode | Rem]) :-
    Size > 1,
    flight(Origin, Mid, _, _, _, _),
    \+(member(Mid, Rem)),
    NewSize is Size - 1,
    append([FirstNode | Rem], [Mid], NewAcc),
    find_circular_trip(NewSize, Mid, Cycle, NewAcc).