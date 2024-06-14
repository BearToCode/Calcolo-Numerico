clear; clc;

% Quanto vale l’approssimazione di
% ∫ [0,10] |cos(π x)| dx tramite la formula di Simpson
% composita con passo H = 1?

f = @(x) abs(cos(pi*x));
a = 0;
b = 10;
H = 1;
N = (b - a) / H;

I = simpcomp(a, b, N, f);

disp(I); % 3.3333