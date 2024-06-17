% Si consideri il seguente problema di diffusione avente come incognita la funzione
% u(x, t): 
% ∂u/∂t(x, t) − ∂2u/∂x2 (x, t) = 0          x ∈ (0, 1), t > 0,
% u(0, t) = 3, u(1, t) = 0                  t > 0,
% u(x, 0) = 3(1 − x)2                       x ∈ (0, 1).
% Si consideri l’approssimazione di tale problema tramite il metodo delle differenze
% finite centrate con passo di discretizzazione spaziale h = 0.5 e il metodo di Eulero
% in avanti con passo di discretizzazione temporale ∆t = 0.1. Si calcoli u1_1, ovvero
% l’approssimazione di u(0.5, 0.1).

mu = 1;
f  = @(x, t) 0;
a  = 0;
b  = 1;
us = @(t) 3;
ud = @(t) 0;
g0 = @(x) 3*(1 - x).^2;

tf    = 0.1;
h     = 0.5;
dt    = 0.1;
theta = 0;

[u] = EqCalore_DiffFin_Theta(mu, f, a, b, us, ud, g0, tf, h, dt, theta);

u1_1 = u(1+1, 1+1);

disp(u1_1); % 1.35