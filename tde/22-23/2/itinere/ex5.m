clear; clc;

% Si consideri l’approssimazione dell’integrale I(f) =∫[-1,2] f(x) dx, con f (x) = √2 + |x|,
% tramite la formula dei trapezi composita per sottointervalli equispaziati di ampiezza
% H = 1. Si riporti il valore approssimato dalla formula I^H_t (f) così ottenuto.

f = @(x) sqrt(2 + abs(x));
a = -1;
b = 2;

N = 3;
h = (b - a) / N;

I = trapcomp(a, b, N, f);

disp(I);