clear; clc;

% Si consideri il sistema di Equazioni Differenziali Ordinarie del primo ordine:
% dy/dt (t) = A (y(t)) y(t) + g(t) t ∈ (0, tf ),
% y(0) = y0,
% dove y(t) = (y1(t), y2(t))T , y0 = (−3/4 , 3)T
% A(y) =
% −1    −(147/16 + K y2)
%  1     0
% per un parametro K ∈ R, g = (−9 e−t/2 (sin2(3 t) − 1) − 9/2 e−t/4 sin(3 t), 0)T
% e tf = 5.

y0 = [-3/4; 3];
AK = @(K) @(y) [
    -1, -(147/16 + K * y(2));
    1, 0
    ];
g = @(t) [-9 * exp(-t/2) * (sin(3*t)^2 - 1) - 9/2 * exp(-t/4) * sin(3*t); 0];
tf = 5;

%% 1.
% Con riferimento a un generico sistema di Equazioni Differenziali Ordinarie nella
% forma (1), si riporti la definizione di zero-stabilit`a in relazione al metodo di Eulero
% in avanti. Si definisca tutta la notazione utilizzata.

% Considerando il metodo di Eulero in Avanti, con u_n soluzione approssimata all'istante n; passo h;
% Nn numero di sotto-intervalli in cui viene diviso l'intervallo [0, tf]:
% u_n+1 = u_n + h * f(t_n, u_n)
% u_0   = y_0
% E una perturbazione:
% z_n+1 = z_n + h * (f(t_n, z_n) + rho_n)     per ogni n = 0, 1, ..., Nn-1
% z_0   = y_0 + rho_0
% Il metodo è zero stabile se esistono h_0 > 0 e eps_0 > 0
% t.c. per ogni h < h_0 e per ogni eps < eps_0:
%
% |rho_n| <= eps       per ogni n = 0, 1, ..., Nn
% implica che
% |z_n - u_n| <= C * eps   per ogni n = 0, 1, ..., Nn
%
% dove C è una costante indipendente da h.

%% 2.
% Dopo aver posto K = 1, si approssimi il problema (1) tramite il metodo di Eulero
% in avanti con passo h = 10−2. Si riportino, oltre ai comandi :
% • i valori delle approssimazioni u1 e uNh rispettivamente di y(t1) e y(tf ), dove
%   tn = n h per n = 0, 1, . . . , Nh, h = tf/Nh;
% • il valore minimo u2,min = min n=0,...,Nh (un)_2 e il tempo discreto tmin a cui si
%   ottiene tale valore u2,min.

K = 1;
A = AK(K);
P = @(t, y) A(y) * y + g(t);

h  = 1e-2;
Nh = tf / h;

[t, u] = eulerfwd_systems(P, [0 tf], y0, Nh);

u1  = u(:, 1+1);
uNh = u(:, end);

u2 = u(2, :);
[u2min, idx] = min(u2);
tmin = t(idx);

disp('u1:'); disp(u1);
disp('uNh:'); disp(uNh);
disp('u2min:'); disp(u2min);
disp('tmin:'); disp(tmin);

% u1:
%    -1.0181
%     2.9925
% uNh:
%    -1.6865
%    -0.7539
% u2min:
%    -2.4321
% tmin:
%     1.0300

%% 3.
% Dopo aver risposto al Punto 2) e sapendo che la soluzione esatta del problema (1)
% è y(t) = 3 exp(−t/4) ( −1/4 cos(3t) − 3 sin(3t), cos(3t) )T
% si calcolino gli errori Eh = ‖uNh −y(tf )‖ ottenuti con il metodo di Eulero in avanti
% e corrispondenti ai passi h1 = 10−3, h2 = 5·10−4, h3 = 2.5·10−4 e h4 = 1.25·10−4.
% Si riportino i valori Ehi per i = 1, . . . , 4 e i comandi Matlabr usati.

sol = @(t) 3 * exp(-t/4) * [-1/4 * cos(3*t) - 3 * sin(3*t); cos(3*t)];

h_values   = [1e-3, 5e-4, 2.5e-4, 1.25e-4];
err_values = zeros(1, length(h_values));

for h = h_values
    Nh = tf / h;
    [~, u] = eulerfwd_systems(P, [0 tf], y0, Nh);
    err_values(h == h_values) = norm(u(:, end) - sol(tf));
end

disp('err_values:'); disp(err_values);

% err_values:
%     0.0182    0.0090    0.0045    0.0023

%% 4.
% Si utilizzino gli errori Ehi ottenuti al Punto 3) per stimare algebricamente l’ordine
% di convergenza p del metodo di Eulero in avanti. Si giustifichi la risposta data e la
% si motivi alla luce della teoria

h1 = h_values(end-1);
h2 = h_values(end);

E1 = err_values(end-1);
E2 = err_values(end);

p = log10(E2 / E1) / log10(h2 / h1);

disp(p); % 1.0018

% Come atteso, il metodo di eulero in avanti ha ordine di convergenza pari a 1.
% Infatti, si ha
%
% e_n ≤ ( M/2 * (exp(L*(tn−t0)) − 1)/L) * h

%% 5.
% Si vuole ora applicare a un sistema di Equazioni Differenziali Ordinarie nella
% forma (1) il metodo di Runge-Kutta associato alla seguente tabella di Butcher
% 0   0   0
% 2/3 2/3 0
% 0   1/4 3/4
% Si scriva un’opportuna funzione Matlabr che implementi il metodo precedente per
% un sistema di EDO con il generico passo h > 0.
% Si utilizzi la funzione precedentemente implementata per risolvere il sistema di
% Equazioni Differenziali Ordinarie (1) con K = 1 e usando il passo h = 10−2. Si
% riportino i valori delle approssimazioni u1 e uNh rispettivamente di y(t1) e y(tf ).
% Si riportino i comandi Matlabr considerati.

B = [
    0,   0,   0;
    2/3, 2/3, 0;
    0,   1/4, 3/4
    ];

h = 1e-2;

[~, u] = rk_systems(P, B, [0 tf], y0, h);

u1  = u(:, 1+1);
uNh = u(:, end);

disp('u1:'); disp(u1);
disp('uNh:'); disp(uNh);

% u1:
%    -1.0171
%     2.9912
% uNh:
%    -1.5104
%    -0.6534

%% 6.
% Con riferimento al sistema di Equazioni Differenziali Ordinarie (1), ma col parametro
% K = 0 e g = 0, per quali valori di h > 0 il metodo di Heun risulta assolutamente
% stabile? Si giustifichi dettagliatamente la risposta data riportando gli eventuali
% comandi Matlabr usati.

R = stability_function("heun");
K = 0;

A = AK(K);
A = A(y0);

hmax = linear_abs_stability(A, R);

disp('hmax:'); disp(hmax);

% hmax:
%     0.4247

% Come atteso, esiste un valore massimo di h per cui il metodo è assolutamente stabile.
% Infatti, il metodo di heun non è incondizionatamente assolutamente stabile, e ad una regione
% di stabilità nel piano complesso Re < 0 finita corrisponde un valore massimo di h.

%% 7.
% Si consideri il sistema di Equazioni Differenziali Ordinarie (1) col parametro K = 0
% e g = 0. Si approssimi tale problema con il metodo di Crank-Nicolson e passo
% h = 10−2, scegliendo una strategia computazionalmente efficiente. Si riportino i
% valori delle approssimazioni u1 e uNh rispettivamente di y(t1) e y(tf).

P  = @(t, y) A * y;
h  = 1e-2;
Nh = tf / h;

theta = 1/2; % Crank-Nicolson

[t, u] = theta_systems(P, [0 tf], y0, Nh, theta);

u1  = u(:, 1+1);
uNh = u(:, end);

disp('u1:'); disp(u1);
disp('uNh:'); disp(uNh);

% u1:
%    -1.0164
%     2.9912
% uNh:
%    -0.4706
%    -0.1642