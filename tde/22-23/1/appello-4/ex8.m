% Si considerino la funzione f (x) = (x−4) log (x − 3) sin(πx) dotata dello zero α = 4
% e la sua approssimazione tramite il metodo delle corde a partire dall’intervallo
% I = [3.5, 4.5]. Si riportino le iterate x(2) e x(3) ottenute applicando il metodo con
% x(0) = 3.5.

f = @(x) (x - 4) .* log(x - 3) .* sin(pi * x);
a = 3.5;
b = 4.5;
x0 = 3.5;

[xvect] = corde(a, b, x0, 3, 0, f);
disp(xvect);