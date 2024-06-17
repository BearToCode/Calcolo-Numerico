clear; clc;

% Quanto vale l’approssimazione dell’integrale
% ∫[0,2] sin(x) cos(x)dx ottenuta con la
% formula di quadratura di Gauss-Legendre di ordine 3? Qual è il grado di esattezza
% di tale formula?

f = @(x) sin(x) .* cos(x);
a = 0;
b = 2;
N = 1;
n = 3;

I = glquad(a, b, N, n, f);

disp(I); % 0.4134

% grado di esattezza: r = 2n + 1 = 7