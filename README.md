# s-CASP-SIG-Automated-Conflict-Detection

## Inspiration
An SIG (Softgoal Interdependency Graph) is a graphical modelling language for representing nonfunctional requirements and their interdependencies in software engineering. A common use of SIG is goal-oriented tradeoff analysis. I wanna use logic programming to automate the process of detecting these tradeoffs (inconsistencies) in SIG.
## What it does
The program contains semantic definition of the SIG, as well as rules for detecting inconsistencies given the facts from the SIG. An inconsistency can be a side effect(have a positive contribution to one goal and and negative on the other) or a conflict(has both positive and negative contributions from other goals).
## How we built it
I use s(CASP) and Prolog to write the facts and rules and test it on Ciao playground for s(CASP).
## Challenges we ran into
The hardest part is how to represent the SIG as facts in Prolog because I have limited experience. It was hard to know how to represents the correct form of SIG. There are other concepts that did not get implemented  out of time constraints.
## Accomplishments that we're proud of
The program achieved the requirement that I set out, which is correctly detecting the inconsistencies in the SIG.
## What we learned
The power of logic programming in modelling common sense knowledge and reasoning. 
## What's next for SIG-AID
There are many ways to improve on SIG-AID. One way is to incorporate LLMs in deriving facts from natural language text or SIG images. Another is to implement the rest of the SIG semantics and methods . I expect to try both ways to improve this project.
