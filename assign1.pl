pterm(null).
pterm(f0(X)) :- pterm(X).
pterm(f1(X)) :- pterm(X).

reverse(f0(P1), f1(P1)).
reverse(f1(P1), f0(P1)).

% Question 1

incr(null, f1(null)).
incr(f1(null), f0(f1(null))).
incr(f0(X), f1(X)).
incr(f1(X), f0(Y)) :- incr(X, Y), X \= null. % this is not the arithmetic predicate =/=

% Question 2

legal(f0(null)).
legal(X):- legal(Y), incr(Y, X).

incrR(X, Y):- legal(X), incr(X, Y).

% Question 3

add(null, X, X).
add(f0(null), X, X).
add(X, Y, Z) :- incr(A, X), add(A, Y, B), incr(B, Z).

% Question 4

mult(null, _, f0(null)). % for X * 0 = 0 (if 0 is defined as null)
mult(f0(null), _, f0(null)). % (if 0 is defined as f0(null))
mult(f1(null), X, X).
mult(X, Y, Z) :- incr(A, X), mult(A, Y, B), add(Y, B, Z).

%Problem 5
%revers(P, RevP) -> predicate
%revers(f0(f1(null)),X). -> query
%X = f1(f0(null)); -> output
% Base case
%From lecture slides 6: accReverse([ ],L,L).
revers(null, P, P).

%lecture slides 6: accReverse([H|T],Acc,Rev):- accReverse(T,[H|Acc],Rev).
revers(f0(X), Acc, Rev) :- revers(X, f0(Acc), Rev).

revers(f1(X), Acc, Rev) :- revers(X, f1(Acc), Rev).

%lecture slides 6: reverse(L1,L2):- accReverse(L1,[ ],L2).
revers(P, RevP) :- revers(P, null, RevP).


%Problem 6
%enc(null) := 0
%enc(f0(X)) := 2 × enc(X)
%enc(f1(X)) := 2 × enc(X) + 1
%normalize(P, Pn)
%enc(null) := 0
normalize(null, f0(null)).
%enc(f0(X)) := 2 × enc(X)
normalize(f0(X),Y) :- normalize(X, Z), mult(Z, f0(f1(null)), Y).
%enc(f1(X)) := 2 × enc(X) + 1
normalize(f1(X), Y) :- normalize(X,Z), mult(Z, f0(f1(null)), A), incr(A, Y).
normalize(null, f0(null)).
%enc(f0(X)) := 2 × enc(X)
normalize(f0(X),Y) :- normalize(X, Z), mult(Z, f0(f1(null)), Y).
%enc(f1(X)) := 2 × enc(X) + 1
normalize(f1(X), Y) :- normalize(X,Z), mult(Z, f0(f1(null)), A), incr(A, Y).