% Si vuole approssimare lo zero α = 2 della funzione f (x) = log(−x^2 +4x−3) sin(πx).
% Scelto x(0) “sufficientemente” vicino ad α, per quale molteplicit`a m il metodo di
% Newton modificato converge quadraticamente ad α = 2?

syms x;
f = log(-x^2 + 4*x - 3) * sin(pi*x);

m = mzero(f, 2);