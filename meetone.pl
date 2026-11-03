#!/bin/gprolog --consult-file

:- include('data.pl').

% Converts time to total number of minutes from midnight
time_to_minutes(time(12, M, am), Total) :- !, Total is M.
time_to_minutes(time(H, M, am), Total) :- !, Total is (H * 60) + M.
time_to_minutes(time(12, M, pm), Total) :- !, Total is (12 * 60) + M.
time_to_minutes(time(H, M, pm), Total) :- Total is ((H + 12) * 60) + M.

% Earlier or equal
earlier_or_equal(T1, T2) :-
	time_to_minutes(T1, M1),
	time_to_minutes(T2, M2),
	M1 =< M2.

% Later or equal
later_or_equal(T1, T2) :-
	time_to_minutes(T1, M1),
	time_to_minutes(T2, M2),
	M1 >= M2.

meetone(Person, slot(Time1, Time2)) :- 
	free(Person, slot(TimeA, TimeB)),
	earlier_or_equal(TimeA, Time1),
	later_or_equal(TimeB, Time2).

main :- findall(Person,
		meetone(Person,slot(time(8,30,am),time(8,45,am))),
		People),
	write(People), nl, halt.

:- initialization(main).
