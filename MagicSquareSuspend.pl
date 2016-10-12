 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% magicSquare(SquareStruct, Number) :- The 2-dimensional array SquareStruct 
%     is a solution to the Number-magic square problem.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
:- lib(suspend).

magicSquare(SquareStruct, Number) :-
    dim(SquareStruct,[Number, Number]),
    constraints(SquareStruct, Number),
    search(SquareStruct, Number).
	
constraints(SquareStruct, Number) :-
	N_Square is Number*Number,
	mToA(SquareStruct, Array, N_Square),
	List is Array[1..N_Square],
	allDifferent(List),
	(for(I, 1, Number), param(SquareStruct) do
		sumOfRow(SquareStruct, I),
		sumOfCol(SquareStruct, I)
	),
	sumOfDiagnol1(SquareStruct),
	sumOfDiagnol2(SquareStruct).
	
	
	
search(SquareStruct, Number) :-
	N_Square is Number * Number,
    ( foreachelem(Qij,SquareStruct), 
      param(N_Square, SquareStruct)
    do 
      select_val(1, N_Square, Qij)
    ).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%	
% select_val(Min, Max, Val) :- 
%     Min, Max are gaes and Val is an integer 
%     between Min and Max inclusive.
%(I =:= 1, J > 1 ->
%		(	writeln(SquareStruct),
%			mToA(SquareStruct, Array, Acc),
%		List is Array[1..Acc],
%			checkAllDifferent(List)
%		);
%		true
%	),
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

select_val(Min, Max, Val) :- Min =< Max, Val is Min. 
select_val(Min, Max, Val) :- 
    Min < Max, Min1 is Min+1, 
    select_val(Min1, Max, Val).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% checkAllDifferent(List):- True if all in the list are different
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
allDifferent(List):-
	(fromto(List, [Head|Tail], Tail, []) do
	Element = Head,
	(foreach(OtherElements, Tail), param(Element) do
		Element $\= OtherElements
	)
	).
		
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% checkSumRowI(SquareStruct, I):- check to make sure each row sums up to N*(N*N+1)/2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sumOfRow(SquareStruct, I):-
	dim(SquareStruct, [N,N]),		
	RowI is SquareStruct[I, 1..N],
	sumOfList(RowI, X),
	X $= N*(N*N+1)/2.
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	
% checkSumColJ(SquareStruct, I):- check to make sure each col sums up to N*(N*N+1)/2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sumOfCol(SquareStruct, J):-
	dim(SquareStruct, [N,N]),		
	ColJ is SquareStruct[1..N, J],
	sumOfList(ColJ, X),
	X $= N*(N*N+1)/2.
	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% checkDiagonalSums(SquareStruct):-
% check to make sure each diagonal sums up to N*(N*N+1)/2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sumOfDiagnol1(SquareStruct):-
	dim(SquareStruct, [N,N]),
	Z is SquareStruct[1, 1],
	(for(I, 2, N), fromto(Z, Curr, Next, Sum), param(SquareStruct) do
		Z is SquareStruct[I, I],
		Next = Curr + Z
	),
	Sum $= N*(N*N+1)/2.
	
sumOfDiagnol2(SquareStruct):-
	dim(SquareStruct, [N,N]),
	Z is SquareStruct[1, N],
	(for(I, 2, N), fromto(Z, Curr, Next, Sum), param(SquareStruct, N) do
		J is (N-I)+1,
		Z is SquareStruct[I, J],
		Next = Curr + Z
	),
	Sum $= N*(N*N+1)/2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define a sumOfList / 2 predicate such that given a list of numbers, sumOfList 
% (List, Total) will bind Total to the sum of all the numbers in Xs wout iterators
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sumOfList(List, Sum):-
	(foreach(El, List),
		fromto(0, Curr, Next, Sum) do
		Next = Curr + El
		).

mToA(Matrix, List, ArrayDim):-
dim(List, [ArrayDim]),
(foreachelem(Element, Matrix), fromto(1, Curr, Next, X), param(List) do
	subscript(List, [Curr], Element) -> Next is Curr +1
).	
		
		
		
		