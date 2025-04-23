competitor(sumsum, appy).
competitor(appy, sumsum).
rival(A, B):-
	competitor(A, B).
smartphonetech(galatica-s3).
business(X):-
	smartphonetech(X).
developed(sumsum, galatica-s3).
stole(stevey, galatica-s3).
boss(stevey, appy).
unethical(Boss):-
	boss(Boss, Comp1),
	stole(Boss, Business),
	business(Business),
	rival(Comp1, Comp2),
	developed(Comp2, Business).