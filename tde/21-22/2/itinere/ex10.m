clear; clc;

% Si consideri il seguente problema di diffusione:
% ∂u/∂t (x, t) − 3 ∂2u/∂x2 (x, t) = 0                   x ∈ (0, 1), t > 0,
% u(0, t) = u(1, t) = 0                                 t > 0,
% u(x, 0) = 6 sin(π x)                                  x ∈ (0, 1).
% Si consideri l’approssimazione di tale problema tramite il metodo delle differenze
% finite centrate con passo di discretizzazione spaziale h = 0.2 e il metodo di Eulero
% in avanti con passo di discretizzazione temporale ∆t > 0. Per quali valori di ∆t `e
% garantita l’assoluta stabilit`a?

% Per Eulero in avanti:
% ∆t < h^2/2μ .

h  = 0.2;
mu = 3;
dt = h^2/(2*mu);

disp(dt) % dt < 0.0067