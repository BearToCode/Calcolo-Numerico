% Dato il numero x ∈ R, il valore e^x pu`o essere ottenuto tramite la serie di Taylor
% e^x = lim N →+∞ N∑k=0 x^k / k!,
% per N ∈ N. Posto x = 2, per quale valore minimo di N si ottiene un errore inferiore
% a 10−3?

val = 2;
exact = exp(val);
approx = @(N, x) sum(arrayfun( ...
  @(k) x^k / factorial(k),     ...
  0:N                          ...
)); 

N = 0;
tol = 10^-3;
while abs(approx(N, val) - exact) > tol
  N = N + 1;
end

fprintf('Il valore minimo di N è: %d\n', N);