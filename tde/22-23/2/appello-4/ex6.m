clear; clc;

% Si consideri il seguente problema di Cauchy:
% y′(t) = −t y2(t) − 9t    t ∈ (0, 1),
% y(0) = 1
% e lo si approssimi mediante il metodo di Eulero in avanti con passo h = 0.1. Quanto
% vale u2, ovvero l’approssimazione di y(t2), essendo tn = nh per n = 0, 1, . . . ?

f  = @(t, y) -t * y^2 - 9 * t;
y0 = 1;

tmax = 1;
h    = 0.1;

[t, u] = eulerfwd(f, tmax, y0, h);

disp(u(1 + 2)); % 0.9000