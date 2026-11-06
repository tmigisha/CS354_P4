#!/bin/gprolog --consult-file

:- include('meet.pl').

% tests time_to_minutes predicate
test_time_to_min(Time, Total, TestName) :-
    time_to_minutes(Time, Total),
    format('~w PASSED: ~w is equivalent to ~w minutes after midnight~n', [TestName, Time, Total]);
	format('~w PASSED: ~w is not equivalent to ~w minutes after midnight~n', [TestName, Time, Total]).

% tests earlier_or_equal predicate
test_earlier_or_equal(T1, T2, TestName) :-
	earlier_or_equal(T1, T2),
	format('~w PASSED: ~w is earlier or equal to ~w~n', [TestName, T1, T2]);
	format('~w PASSED: ~w is not earlier or equal to ~w~n', [TestName, T1, T2]).

% tests later_or_equal predicate
test_later_or_equal(T1, T2, TestName) :-
	later_or_equal(T1, T2),
	format('~w PASSED: ~w is later or equal to ~w~n', [TestName, T1, T2]);
	format('~w PASSED: ~w is not later or equal to ~w~n', [TestName, T1, T2]).

% tests overlap predicate
test_overlap(Slot1, Slot2, Slot, TestName) :-
	overlap(Slot1, Slot2, Slot),
	format('~w PASSED: ~w is an overlap of ~w and ~w~n', [TestName, Slot, Slot1, Slot2]);
	format('~w PASSED: there is no overlap of ~w and ~w~n', [TestName, Slot1, Slot2]).

% tests meetone predicate
test_meetone(Slot, TestName) :-
	findall(Person,
 		meetone(Person,Slot),
 		People),
	format('~w PASSED: ~w is/are available during ~w~n', [TestName, People, Slot]).

test_meet(P1, P2, P3, TestName) :-
	people([P1, P2, P3]),
	findall(Slot, meet(Slot), Slots),
        uniq(Slots, Uniq),
	format('~w PASSED: the 3 people can meet during these time slots: ~w~n', [TestName, Uniq]).


main :- (
	test_time_to_min(time(12, 30, am), 30, test_time_to_min),
	test_time_to_min(time(12, 30, am), 60, test_time_to_min),
	test_earlier_or_equal(time(8, 30, am), time(8, 31, am), test_earlier_or_equal),
	test_earlier_or_equal(time(10, 0, am), time(8, 30, am), test_earlier_or_equal),
	test_earlier_or_equal(time(12, 0, pm), time(1, 0, pm), test_earlier_or_equal),
	test_later_or_equal(time(10, 0, am), time(8, 0, am), test_later_or_equal),
	test_later_or_equal(time(3, 0, pm), time(5, 30, pm), test_later_or_equal),
	test_overlap(slot(time(8, 0, am), time(9, 0, am)), slot(time(7, 0, am), time(8, 30, am)), SlotA, test_overlap),
	test_overlap(slot(time(12, 0, pm), time(12, 30, pm)), slot(time(11, 0, am), time(1, 0, pm)), SlotB, test_overlap),
	test_overlap(slot(time(10, 0, am), time(11, 30, am)), slot(time(10, 30, am), time(12, 0, pm)), SlotC, test_overlap),
	test_overlap(slot(time(9, 0, am), time(10, 0, am)), slot(time(2, 0, pm), time(3, 0, pm)), SlotD, test_overlap),
	test_meetone(slot(time(8, 30, am), time(8, 45, am)), test_meetone),
	test_meetone(slot(time(11, 0, am), time(12, 0, pm)), test_meetone),
	test_meetone(slot(time(9, 0, pm), time(10, 0, pm)), test_meetone),
	test_meet(ann, bob, carla, test_meet)
	),
	nl, halt.

:- initialization(main).
