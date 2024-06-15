clear; clc;

% Quanto vale l’approssimazione di
% ∫ [-2,3] e^x dx tramite la formula del punto medio
% composita con passo H = 1?

a = -2;
b = 3;
f = @(x) exp(x);
H = 1;

N = (b - a) / H;

I = pmedcomp(a, b, N, f);

disp(I); % 19.1426