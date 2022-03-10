:- use_module(library(lists)).

airport('Aeroport Francisco Sá Carneiro', 'LPPR', 'Portugal').
airport('Aeroporto Humberto Delgado', 'LPPT', 'Portugal').
airport('Aeropuerto Adolfo Suárez Madrid-Barajas', 'LEMD', 'Spain').
airport('Aéroport de Paris-CHarles-de-Gaulle Roissy Airport', 'LFPG', 'France').
airport('Aeroporto Internazionale di Roma-Flumicino - Leonardo da Vinci', 'LIRF', 'Italy').

company('TAP', 'TAP Air Portugal', 1945, 'Portugal').
company('RYR', 'Ryanair', 1984, 'Ireland').
company('AFR', 'Societé Air France', 1933, 'France').
company('BAW', 'British Airways', 1974, 'United Kingdom').

% flight(Designation, Origin, Dest, Departure_time, Duration, Company)
flight('TP1923', 'LPPR', 'LPPT', 1115, 55, 'TAP').
flight('TP1968', 'LPPT', 'LPPR', 2235, 55, 'TAP').
flight('TP842', 'LPPT', 'LIRF', 1450, 195, 'TAP').
flight('TP843', 'LIRF', 'LPPT', 1935, 195, 'TAP').
flight('FR5483', 'LPPR', 'LEMD', 630, 105, 'RYR').
flight('FR5484', 'LEMD', 'LPPR', 1935, 105, 'RYR').
flight('AF1024', 'LFPG', 'LPPT', 940, 155, 'AFR').
flight('AF1025', 'LPPT', 'LFPG', 1310, 155, 'AFR').

% 1
short(Flight) :-
    flight(Flight, _O, _D, _DepartureTime, Duration, _Company),
    Duration < 90.

% 2
shorter(Flight1, Flight2, ShorterFlight) :-
    flight(Flight1, _O, _D, _DepartureTime, Duration1, _Company),
    flight(Flight2, _O2, _D2, _DepartureTime2, Duration2, _Company2),
    Duration1 < Duration2,
    ShorterFlight = Flight1.

shorter(Flight1, Flight2, ShorterFlight) :-
    flight(Flight1, _O, _D, _DepartureTime, Duration1, _Company),
    flight(Flight2, _O2, _D2, _DepartureTime2, Duration2, _Company2),
    Duration2 < Duration1,
    ShorterFlight = Flight2.

% 3
% 1450 195
increment_time(Acc, Duration, NewTime) :-
    Minutes is Acc rem 100,
    NewMin is Minutes + Duration,
    NewMin >= 60, !,
    NewAcc is Acc + 100,
    NewDur is Duration - 60,
    increment_time(NewAcc, NewDur, NewTime).
increment_time(Acc, Duration, NewTime) :-
    NewTime is Acc + Duration.


arrivalTime(Flight, ArrivalTime) :-
    flight(Flight, _O, _D, DepartureTime, Duration, _Company),
    increment_time(DepartureTime, Duration, ArrivalTime).

% 4
findCountries(AllCountries, Acc) :-
    airport(_, _, Country),
    \+(member(Country, Acc)), !,
    append(Acc, [Country], NewAcc),
    findCountries(AllCountries, NewAcc).

findCountries(Acc, Acc).

companyInCountry(Company, Country) :- 
    flight(_, A1, A2, _, _, Company),
    (airport(_, A1, Country); airport(_, A2, Country)).

countries(Company, ListOfCountries) :-
    findCountries(AllCountries, []),
    countries(Company, AllCountries, ListOfCountries, []).

countries(_Company, [], Acc, Acc).
countries(Company, [Country | Rem], ListOfCountries, Acc) :-
    companyInCountry(Company, Country), !,
    append(Acc, [Country], NewAcc),
    countries(Company, Rem, ListOfCountries, NewAcc).
countries(Company, [_Country | Rem], ListOfCountries, Acc) :- countries(Company, Rem, ListOfCountries, Acc).

% 5
pairableFlights :-
    flight(C1, _, Airport, _, _, _),
    flight(C2, Airport, _, Departure2, _, _),
    arrivalTime(C1, ArrivalTime),
    DiffTime is Departure2 - ArrivalTime,
    DiffTime >= 30, DiffTime =< 130,     % DiffTime is between 30 and 90 min
    format('~s - ~s \\ ~s\n', [Airport, C1, C2]),
    fail.

pairableFlights.

% 6
timeWaiting(Departure, Time, CambioTime, WaitingTime) :-
    TimeDiff is Departure - Time,
    TimeDiff >= CambioTime, !, % Apanha voo hoje
    WaitingTime = TimeDiff.
timeWaiting(Departure, Time, _CambioTime, WaitingTime) :-
    TimeDiff is Departure - Time,
    NewTimeDiff is TimeDiff + 2400, % Apanha amanhã
    WaitingTime = NewTimeDiff.



tripDays([Start, Next | Countries], Time, FlightTimes, Days) :-
    airport(_, A1, Start), airport(_, A2, Next),
    flight(Code, A1, A2, Departure, _Duration, _Company),
    timeWaiting(Departure, Time, 0, WaitingTime), % We choose the first flight that connects the 2 countries
    arrivalTime(Code, ArrivalTime),
    tripDays([Next | Countries], ArrivalTime, WaitingTime, Days, FlightTimes, [Departure]).

tripDays([_Dest], _NextArrival, CurrDuration, Days, FlightAcc, FlightAcc) :-
    Days is CurrDuration // 2400 + 1.

tripDays([Origin, Dest | Countries], NextArrival, CurrDuration, Days, FlightTimes, FlightAcc) :-
    airport(_, A1, Origin), airport(_, A2, Dest),
    flight(Code, A1, A2, Departure, _Duration, _Company),

    timeWaiting(Departure, NextArrival, 30, WaitingTime), % We choose the first flight that connects the 2 countries
    NextCurrDuration is CurrDuration + WaitingTime,

    arrivalTime(Code, ArrivalTime),
    append(FlightAcc, [Departure], NewFlightAcc),

    tripDays([Dest | Countries], ArrivalTime, NextCurrDuration, Days, FlightTimes, NewFlightAcc).

% 7
avgFlightLengthFromAirport(Airport, AvgLength) :-
    findall(Duration, flight(_, Airport, _, _, Duration, _) , Durations),
    sumlist(Durations, Sum),
    length(Durations, Length),
    AvgLength is Sum / Length.

% 8


% 9
/* make_pairs(L, P, Sol) :-
    \+(ordered(L)),
    sort(L, SortedList),
    make_pairs(SortedList, P, Sol).
make_pairs(L, P, [X-Y|Zs]) :-
    select(X, L, L2),
    select(Y, L2, L3),
    G =.. [P, X, Y], G,
    !,
    make_pairs(L3, P, Zs).

make_pairs([], _, []).

dif_max_2(X, Y) :- X < Y, X >= Y-2. */

% 10
make_pairs(L, P, Sols) :- make_pairs(L, P, [], [[]]).

make_pairs(L, P, Acc1, Acc2) :-
    select(X, L, L2),
    select(Y, L2, L3),
    G =.. [P, X, Y], G,
    append(Acc1, [X-Y], NewAcc1),
    make_pairs(L3, P, NewAcc1, Acc2).
make_pairs([X, Y | Rem], P, Zs, Acc) :-
    make_pairs(Rem, P, Zs, Acc).
make_pairs([X | Rem], P, Zs, Acc) :-
    make_pairs(Rem, P, Zs, Acc).

make_pairs([], _, Acc1, Acc2) :-
    append(Acc2, [Acc1], NewAcc),
    make_pairs()

dif_max_2(X, Y) :- X < Y, X >= Y-2.

% 11

