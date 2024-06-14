clear; clc;

% Si consideri il seguente problema:
% ∂u/∂t − ∂2u/∂x2 = 5 x ∈ (0, 1),
% u(0, t) = u(1, t) = 0 t > 0,
% u(x, 0) = 1 − cos(πx) x ∈ [0, 1].
% Si supponga di approssimare tale problema utilizzando il metodo delle differenze
% finite centrate in spazio e il θ–metodo in tempo con θ = 0.5, ottenendo cos`ı la
% soluzione numerica {uk_j} nei nodi {x_j}N+1 j=0 e agli istanti {t_k}M k=0. Assumendo che
% l’errore per passi di discretizzazione spaziale h = 0.01 e temporale ∆t = 0.01 sia
% E = max k=0,...,M max j=0,...,N +1 |u(xj , tk ) − uk_j | = 6 · 10−2, si stimi
% l’errore che si otterrebbe dimezzando sia il passo di discretizzazione spaziale che quello temporale.

h1  = 0.01;
dt1 = 0.01;
E1  = 6e-2;

% Dalle note (Proposizione 8.4.1)
% e <= C * (h^2 + dt^N)
%
% con N = 2 se theta = 1/2, N = 1 altrimenti
%
% => e <= C * (h + dt)^2
% => p = 2

h2 = h1 / 2;
dt2 = dt1 / 2;

factor = 2;
E2 = E1 / factor^2;

disp(E2); % 1.5e-2