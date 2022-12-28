% Problem 1 (25 points) Write a DCG that accepts strings of the
% form u2v where u and v are strings over the alphabet {0,1}
% such that u is v in reverse. For example,
% ?- s([0,1,1,2|L],[]).
% L = [1,1,0] ;
% false

%Solution:
s --> [2].
s --> string1, s, string1.
s --> string2, s, string2.
string1 --> [0].
string2 --> [1].



%
%Problem 2 (25 points) Exercise 6.6 in Learn Prolog Now describes a
% street with (∗) three neighbouring houses that all have a different
%colour, namely red, blue, and green. People of different nationalities
%live in the different houses and they all have a different pet.
%
%Leaving out all the other constraints mentioned in that exercise, write a
%DCG that outputs strings
%[h(Col1,Nat1,Pet1), h(Col2,Nat2,Pet2), h(Col3,Nat3,Pet3)]
%satisyfing (∗), where the nationalities are
%
%english, spanish, japanese
%
%and the pets are
%jaguar, snail, zebra.
%
%To avoid confusion with the first problem, use different binary predicates
% for the difference lists, and, in particular, nbd/2 for the 3 houses.
%  For example,
%?- nbd([h(red,english,snail), h(blue,japanese,jaguar),
%h(green,spanish,Z)], []).
%Z = zebra ;
%false.

%Solution:
%start with listing the pets

pet('jaguar').
pet('snail').
pet('zebra').

%now, list the nationalities
nation('english').
nation('spanish').
nation('japanese').

%finally, list the colours
colour('red').
colour('blue').
colour('green').

%now, create the house rule, using 'h' to denote house, and takes the 
%3 arguments of colour, nationality and pet
house(Col, Nat, Pet) --> [h(Col,Nat,Pet)],
                            {colour(Col), nation(Nat), pet(Pet)}.

%create the nbd DCG
nbd --> house(Col1,Nat1,Pet1),house(Col2,Nat2,Pet2),house(Col3,Nat3,Pet3),
    { Col1 = Col2, Col2 = Col3, Col1 = Col3,
                  Nat1 = Nat2, Nat2 = Nat3, Nat1 = Nat3,
                      Pet1 = Pet2, Pet2 = Pet3, Pet1 = Pet3 }.