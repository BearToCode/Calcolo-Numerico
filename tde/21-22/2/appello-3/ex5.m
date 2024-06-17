clear; clc;

% Quanto vale l’approssimazione di ∫ [-3,1] exp(x) dx tramite la formula dei trapezi com-
% posita con passo H = 1?

f = @(x) exp(x);
a = -3;
b = 1;
H = 1;

Nh = (b - a) / H;

I = trapcomp(a, b, Nh, f);

disp(I); % 2.8872
