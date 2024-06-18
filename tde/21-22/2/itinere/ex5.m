clear; clc;

% Si consideri l’approssimazione dell’integrale I(f) = ∫ [-1,2] f (x) dx, con f (x) = √(2 + |x|),
% tramite la formula dei trapezi composita per sottointervalli equispaziati di ampiezza
% H = 1. Si riporti il valore approssimato dalla formula IH t (f) così ottenuto.

f = @(x) sqrt(2 + abs(x));
a = -1;
b = 2;
H = 1;
Nh = (b - a) / H;

I = trapcomp(a, b, Nh, f);

disp(I); % 5.0123