# Project 4: Prolog

* Author: Trust Migisha
* Class: CS354 Section 002
* Semester: Fall 2026

## Overview
This project is written in Prolog where one program finds the people who are available to meet during a specific 
time based off the data that represents people and their available times to meet. The other program finds one or 
more time slots of the people given for when they can meet by finding where their available times overlap.

## Reflection
Some things that went well was creating the predicates that compare time to confirm one is earlier than the 
other or later than the other. After understanding the birthday.pl example from class, I felt like I was able 
to grasp that fairly quickly until I reached the issue that my comparison logic doesn't work for 12 and 1 am/pm, 
since 12 comes before 1 in regards to time but 1 is less than 12 as a number. That's when I got the idea of converting 
the times to the total number of minutes from midnight and comparing those minutes instead which helped bypass that 
problem.

I spent a long time trying to figure out how to get when the time slots overlap for meet.pl. I mean now that I 
am done with it, it doesn't seem like it was that difficult, but I spent hours thinking of how to format my overlap 
predicate. Drawing a graph of how to time slots overlap definitely helped and I was able to find the different ways 
they can overlap which I was eventually able to program. Also figuring out how the unit testing works in prolog 
took a little bit to understand, but after realizing that we're using the predicate and then having "format" print 
a successful test message (similar to printf in C), it was fairly smooth creating the rest of the tests.

## Compiling and Using
* In order to run meet.pl or meetone.pl, the user needs to run the command, "gprolog --consult-file {file name}" in the terminal.
* In order to run test.pl:
  * First, the user needs to comment out all the lines connected to the "main" fact/predicate as well as the "initialization(main)" line in both meet.pl and meetone.pl.
  * Then, the user can run the command, "gprolog --consult-file test.pl" in the terminal.

## Results
All unit tests in test.pl passed.

## Sources used
* https://learnxinyminutes.com/prolog/
