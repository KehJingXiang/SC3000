monarch(elizabeth).

male(charles).
male(andrew).
male(edward).
female(ann).

offspring(elizabeth,charles).
offspring(elizabeth,ann).
offspring(elizabeth,andrew).
offspring(elizabeth,edward).

older(charles, ann).
older(ann, andrew).
older(andrew, edward).
older(Older, Younger):-
	\+ Older = Younger,
	older(Older, Middle),
	older(Middle, Younger).

prince(Prince, Monarch):-
	offspring(Monarch ,Prince),
	monarch(Monarch),
	male(Prince).

princess(Princess, Monarch):-
	offspring(Monarch, Princess),
	monarch(Monarch),
	female(Princess).

all_princes(Monarch, List):-
	findall(Prince, prince(Prince, Monarch), List).

all_princesses(Monarch, List):-
	findall(Princess, princess(Princess, Monarch), List).


% Usage: remove_person(Person, [....], Final_List)
% Base case: When List is empty, returns empty List
remove_person(_, [], []).
% Match found: remove person from list, calls recursively
remove_person(Person, [Person|Others], Result):-
	remove_person(Person, Others, Result).
% No match: add first person into list, calls recursively on the 2nd
% part of the list
remove_person(Person, [Others1|Others2], [Others1|Result]):-
	Person \= Others1,
	remove_person(Person, Others2, Result).


% Usage: oldest_in_list([....], Oldest)
% Base case: when list only has 1 person, returns that person
oldest_in_list([P], P).
% When 1st is older than 2nd, remove second person and calls recursively
oldest_in_list([H1, H2 | T], Oldest):-
	older(H1, H2),
	oldest_in_list([H1 | T], Oldest).
% When 2nd is older than 1st, remove first person and calls recursively
oldest_in_list([H1, H2 | T], Oldest):-
	older(H2, H1),
	oldest_in_list([H2 | T], Oldest).


% Usage: succession_order(Descendants_List, Ordered_List)
% Base case: when list is empty, returns empty list
succession_order([], []).
% Find oldest person in Descendants, append that into Result list,
% returns Result list
succession_order(Descendants, [Oldest| Result]):-
	oldest_in_list(Descendants, Oldest),
	remove_person(Oldest, Descendants, Remaining),
	succession_order(Remaining, Result).

successor(Monarch, Succession_order):-
	all_princes(Monarch, Princes),
	all_princesses(Monarch, Princesses),
	succession_order(Princes, Ordered_princes),
	succession_order(Princesses, Ordered_princesses),
	append(Ordered_princes, Ordered_princesses, Succession_order).




