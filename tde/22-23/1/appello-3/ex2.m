% Si consideri l'approssimazione di cos(x) mediante serie di Taylor
% cos(x) ≈ ∑ (−1)^n / (2n)! * x^2n,
% per N ≥ 0. Posto x = π/7, qual `e il minimo valore di N tale per cui l'errore
% relativo dell'approssimazione di cos(π/7) risulta inferiore a 10−5?

cos_approx = @(x, N) sum(arrayfun(@(n) (-1)^n / factorial(2*n) * x^(2*n), 0:N));
x = pi/7;
tol = 1e-5;
err = tol + 1;
N = 0;

while err > tol
    N = N + 1;
    err = abs(cos(x) - cos_approx(x, N)) / cos(x);
end

disp(N)