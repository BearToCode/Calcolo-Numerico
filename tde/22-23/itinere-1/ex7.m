clc; clear;

% Si consideri la funzione Φ(x) = x^4/4 + x^2/2 − 3x + 5. Si applichi il metodo di Newton
% all’approssimazione del punto di minimo α di Φ partendo dall’iterata iniziale x(0) =
% 0. Si riportino i valori delle iterate x(1), x(2) e x(5) cos`ı ottenute con almeno quattro
% cifre decimali.

syms x;

phi_sym = x^4/4 + x^2/2 - 3*x + 5;
dphi_sym = diff(phi_sym);
d2phi_sym = diff(dphi_sym);

phi = matlabFunction(phi_sym);
dphi = matlabFunction(dphi_sym);
d2phi = matlabFunction(d2phi_sym);

x0 = 0;

tol = 1e-5;
nmax = 5;

[xvect, it] = newton(x0, nmax, tol, dphi, d2phi);
disp(xvect)

% 3.0000    2.0357    1.2144