#!/bin/gprolog --consult-file

:- include('data.pl').
:- include('uniq.pl').

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

% sees where 2 times overlap
overlap(slot(T1, T2), slot(T3, T4), Slot) :- 
	(earlier_or_equal(T1, T3), later_or_equal(T2, T4), T3 \== T4, Slot = slot(T3, T4));
	(earlier_or_equal(T1, T3), later_or_equal(T2, T3), earlier_or_equal(T2, T4), T3 \== T2, Slot = slot(T3, T2));
	(later_or_equal(T1, T3), earlier_or_equal(T1, T4), later_or_equal(T2, T4), T1 \== T4, Slot = slot(T1, T4));
	(later_or_equal(T1, T3), earlier_or_equal(T2, T4), T1 \== T2, Slot = slot(T1, T2)).

% slot times for available times 3 people can meet
meet(Slot) :- 
	people([P1, P2, P3]),
	free(P1, Slot1),
	free(P2, Slot2),
	overlap(Slot1, Slot2, SlotA),
	free(P3, Slot3),
	overlap(SlotA, Slot3, Slot).


people([ann,bob,carla]).

main :- findall(Slot, meet(Slot), Slots),
        uniq(Slots, Uniq),
        write(Uniq), nl, halt.

:- initialization(main).
