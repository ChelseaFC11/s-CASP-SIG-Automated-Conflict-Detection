%SIG Automated Inconsistencies Detection (AID) Project
%UTD HackReason2025
%Bao Pham

%Facts
topic(accounts).

nfr(security).
nfr(performance).
nfr(user_friendliness).
nfr(confidentiality).
nfr(integrity).
nfr(availability).
nfr(completeness).
nfr(accuracy).
nfr(space).
nfr(response_time).


and_decomp(security,[confidentiality,integrity,availability]).
and_decomp(integrity,[completeness,accuracy]).
and_decomp(performance,[space,response_time]).


op(uncompressed_format).
op(use_indexing).
op(authorize_access).
op(identify_user).
op(use_pin).
op(compare_signature).
op(require_add_id).
op(authenticate_user).
op(validate_access).

and_decomp(authorize_access, [validate_access,identify_user,authenticate_user]).
or_decomp(authenticate_user, [use_pin, compare_signature, require_add_id]).

help(uncompressed_format,response_time).
hurt(uncompressed_format,space).
help(use_indexing,response_time).
help(validate_access,accuracy).
hurt(validate_access, response_time).
make(authorize_access, confidentiality).
break(require_add_id, user_friendliness).


%SIG syntax
goal(X) :- nfr(X).
goal(X) :- op(X).
goal(X) :- arg(X).

false :- and_decomp(G0,[]).
and_decomp(G0,G1) :- and_decomp(G0,Gn).

false :- or_decomp(G0,[]).
or_decomp(G0,G1) :- or_decomp(G0,Gn).


contribution(X,Y) :- help(X,Y).
contribution(X,Y) :- hurt(X,Y).
contribution(X,Y) :- make(X,Y).
contribution(X,Y) :- break(X,Y).
contribution(X,Y) :- unknown(X,Y).



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
%false :- nfr(X), op(X).
% A goal that has a positive contribution to a goal, 
% and has a negative contribution to another goal.
side_effect(X) :- pos_contribution(X,_), neg_contribution(X,_).

% A goal that has both positive and negative contributions from other goals.
conflict(X) :- pos_contribution(_,X), neg_contribution(_,X).
