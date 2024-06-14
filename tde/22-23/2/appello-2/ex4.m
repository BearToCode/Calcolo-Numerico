clear; clc;

% Quanto vale l’approssimazione di
% ∫[0,4] |cos(x)|dx tramite la formula del trapezio
% composita con passo H = 0.25?

f = @(x) abs(cos(x));

H = 0.25;
a = 0;
b = 4;

N = (b - a) / H;

I = trapcomp(a, b, N, f);

disp(I); % 2.7551