clear; clc;

% Si consideri l’approssimazione dell’integrale I(f) = ∫[-2,2] f(x) dx con f (x) = √(|x| + 0.5)
% tramite la formula di Simpson composita per sottointervalli equispaizati di ampiezza
% H = 1. Si riporti il valore approssimato dalla formula IHs (f) così ottenuto.

f = @(x) sqrt(abs(x) + 0.5);
a = -2;
b = 2;
H = 1;
N = (b - a) / H;

I = simpcomp(a, b, N, f);

disp(I); % 4.7982