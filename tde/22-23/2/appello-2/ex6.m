clear; clc;

% Si consideri il seguente problema di Cauchy:
% y′(t) = −t * y(t)^2 − 3t, t ∈ (0, 1)
% y(0) = 1
% e lo si approssimi mediante il metodo di Eulero in avanti con passo h = 0.05.
% Quanto vale u2, ovvero l’approssimazione di y(t2), essendo tn = n h per n = 0, 1,
% 2, . . .?

f    = @(t, y) -t * y^2 - 3*t;
y0   = 1;
h    = 0.05;
tmax = 1;

[t, u] = eulerfwd(f, tmax, y0, h);

u2 = u(1+2);

disp(u2); % 0.9900