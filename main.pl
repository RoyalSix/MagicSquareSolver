:- lib(ic).
:- lib(branch_and_bound).

a1(Letters):-
Domain = ['S', 'H', 'I','N','E','T','A','K'],
constraints_a1(Letters),
search(Letters,0,first_fail,indomain,complete,[]),
writeln(Domain), writeln(Letters).

constraints_a1(Letters):-
	Letters = [S, H, I, N, E, T, A, K],
	Letters :: [0..9],
	S $\= 0,
	SumOfShine $= (10000 * S) + (1000 * H) + (100 * I) + (10 * N) + E,
	SumOfThan $= (1000 * T) + (100 * H) + (10 * A) + N,
	Difference $= (1000 * K) + (100 * N) + (10 * I) + T,
	Difference $= SumOfShine - SumOfThan,
	alldifferent(Letters).
	
a2(Letters):-
Domain = ['T', 'H', 'I', 'N', 'K', 'E'],
constraints_a2(Letters),
search(Letters,0,first_fail,indomain,complete,[]),
writeln(Domain), writeln(Letters).

constraints_a2(Letters):-
	Letters = [T, H, I, N, K, E],
	Letters :: [0..9],
	T $\= 0,
	SumOfShine $= (10000 * T) + (1000 * H) + (100 * I) + (10 * N) + K,
	SumOfThan $= (1000 * T) + (100 * H) + (10 * E) + N,
	Difference $= (1000 * K) + (100 * N) + (10 * I) + T,
	Difference $= SumOfShine - SumOfThan,
	alldifferent(Letters).
	
a3(Letters):-
Domain = ['T', 'H', 'A', 'N', 'K', 'E', 'G', 'R'],
constraints_a3(Letters),
search(Letters,0,first_fail,indomain,complete,[]),
writeln(Domain), writeln(Letters).

constraints_a3(Letters):-
	Letters = [T, H, A, N, K, E,  G, R],
	Letters :: [0..9],
	T $\= 0,
	SumOfShine $= (10000 * T) + (1000 * H) + (100 * A) + (10 * N) + K,
	SumOfThan $= (1000 * T) + (100 * H) + (10 * E) + N,
	Difference $= (1000 * G) + (100 * N) + (10 * A) + R,
	Difference $= SumOfShine - SumOfThan,
	alldifferent(Letters).
	
b1(Coins, Amount):-
constraints_b1(Coins, Amount),
AmountOfCoins = ['Ones', 'Fives', 'Tens', 'TwentyFives'],
writeln(Coins), writeln(AmountOfCoins).

constraints_b1(Coins, Sum):-
	Coins = [Ones, Fives, Tens, TwentyFives],
	Coins :: [0..Sum],
	Sum $= Ones * 1 + Fives * 5 + Tens *10 + TwentyFives * 25,
	Cost $= sum(Coins),
	minimize(labeling(Coins), Cost).
	
b2(Coins, Amount):-
constraints_b2(Coins, Amount),
AmountOfCoins = ['Ones', 'Twos', 'Threes', 'Twelves', 'TwentyFives'],
writeln(Coins), writeln(AmountOfCoins).

constraints_b2(Coins, Sum):-
	Coins = [Ones, Twos, Threes, Sixes, Twelves, TwentyFives],
	Coins :: [0..Sum],
	Sum $= Ones * 1 + Twos * 2 + Threes * 3 + Sixes * 6 + Twelves *12 + TwentyFives * 25,
	Cost $= sum(Coins),
	minimize(labeling(Coins), Cost).
	
b3(Coins, Coins_Nums, Amount):-
constraints_b3(Coins, Coins_Nums, Amount).

constraints_b3(Coins, Coins_Nums, Sum):-
	Coins = [A, B, C, D, E, F, G, Fives],
	Coins_Nums = [A_Num, B_Num, C_Num, D_Num, E_Num, F_Num, G_Num, 5],
	Coins :: 0..Sum,
	Sum $= (A * A_Num  + B * B_Num + C * C_Num + D * D_Num + E * E_Num + F * F_Num + G * G_Num + Fives * 5),
	Cost $= sum(Coins_Nums),
	SumOfCoins $= sum(Coins),
	alldifferent(Coins_Nums),
	minimize(labeling(Coins_Nums), Cost),
	minimize(labeling(Coins), SumOfCoins).