%SIG Automated Conflict Detection Project
%Bao Pham

%Facts
topic(accounts).
nfr(security).
nfr(performance).
nfr(user_friendliness).
op(security).


and_decomp(security,[confidentiality,integrity,availability]).
and_decomp(integrity,[completeness,accuracy]).
and_decomp(performance,[space,response_time]).

op(uncompressed_format).
op(use_indexing).
op(validate_access).

help(uncompressed_format,response_time).
hurt(uncompressed_format,space).

%SIG syntax
goal(type) :- nfr(type).
nfr(type) :- goal(type).
goal(type) :- op(type).
goal(claim) :- arg(claim).

and_decomp(g0,[g1|gn]) :- goal(g0), and_subgoals([g1|gn]).
or_decomp(g0,[g1|gn]) :- goal(g0), or_subgoals([g1|gn]).


contribution(X,Y) :- help(X,Y).
contribution(X,Y) :- hurt(X,Y).
contribution(X,Y) :- make(X,Y).
contribution(X,Y) :- break(X,Y).



%contribution(arg(X),contribution(X,Y)) :- help(arg(X),contribution(X,Y).
%contribution(arg(X),contribution(X,Y) :- hurt(arg(X,Y),contribution(X,Y).
%contribution(arg(X),contribution(X,Y) :- make(arg(X,Y),contribution(X,Y).
%contribution(arg(X),contribution(X,Y) :- break(arg(X,Y),contribution(X,Y).


pos_contribution(X,Y) :- help(X,Y).
pos_contribution(X,Y) :- make(X,Y).
neg_contribution(X,Y) :- hurt(X,Y).
neg_contribution(X,Y) :- break(X,Y).

%Rules for syntax error and conflict detection.

% A goal cannot be an NFR softgoal, an operationalization softgoal or a claim softgoal at the same time.
false :- nfr(X), op(X).

% A goal that has a positive contribution to a goal, 
% and has a negative contribution to another goal.
side_effect(X) :- pos_contribution(X,_), neg_contribution(X,_).

% A goal that has both positive and negative contributions from other goals.
conflict(X) :- pos_contribution(_,X), neg_contribution(_,X).