clc; clear; close all;

syms x;
symf = atan(7 * (x - pi/2)) + sin((x - pi/2)^3);
symdf = diff(symf);

f = matlabFunction(symf);
df = matlabFunction(symdf);

%% 1. Si disegni il grafico della funzione f nell’intervallo [−1, 6]

x = linspace(-1, 6, 500);
y = arrayfun(f, x);

figure(1);
plot(x, y);
grid on;
title('f(x) = atan(7 * (x - pi/2)) + sin((x - pi/2)^3)');

%% 2. Si verifichi che l’unico zero α della funzione f `e semplice e si utilizzi la funzione
% newton.m implementata nel laboratorio precedente per calcolarlo. Si assuma una
% tolleranza pari a 10−10 e guess iniziale x0 = 1.5. Successivamente si ripeta tale cal-
% colo partendo da x0 = 4. Sapendo che α = π/2, si calcolino gli errori assoluti nei due
% casi e si motivino i risultati ottenuti.

tol = 1e-10;
x0 = 1.5;
nmax = 100;
[xvect1, it1] = newton(x0, nmax, tol, f, df);
alpha1 = xvect1(end);

x0 = 4;
[xvect2, it2] = newton(x0, nmax, tol, f, df);
alpha2 = xvect2(end);

err1 = abs(alpha1 - pi/2);
err2 = abs(alpha2 - pi/2);

fprintf('2.1 alpha1 = %.15f, it1 = %d, err1 = %.15f\n', alpha1, it1, err1);
fprintf('2.2 alpha2 = %.15f, it2 = %d, err2 = %.15f\n', alpha2, it2, err2);

%% 3. Verificate la possibilità di utilizzare il metodo di bisezione; si utilizzi la funzione bisez.m
% implementata nel laboratorio precedente sull’intervallo [a, b] = [−1, 6] con tolleranza
% toll = (b − a)/2^31. Si riporti l’errore ottenuto.

a = -1;
b = 6;

tol = (b - a) / 2^31;
[xvect, it] = bisez(a, b, tol, f);
alpha = xvect(end);

err = abs(alpha - pi/2);

fprintf('3. alpha = %.15f, it = %d, err = %.15f\n', alpha, it, err);

%% 5. Si calcoli utilizzando la funzione biseznewton lo zero α di f , impiegando 5 iterazioni
% del metodo di bisezione. Si mantengano i valori precedentemente utilizzati per tutti gli
% altri parametri di input.

[xvect, it] = biseznewton(a, b, 5, nmax, tol, f, df);
alpha = xvect(end);

err = abs(alpha - pi/2);

fprintf('5. alpha = %.15f, it = %d, err = %.15f\n', alpha, it, err);