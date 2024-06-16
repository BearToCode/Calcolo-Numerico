clear; clc;

% Si consideri il seguente problema con soluzione x(t) : [0, 10] → R:
% x''(t) + 2 x'(t) + 10 x^2(t) = z(t) t ∈ (0, 10),
% x'(0) = 2,
% x(0) = 0,
%
% dove z(t) = exp(−t/2) (2 cos(t) − 7/2 sin(t)) + 40 e−t sin2(t).

%% 1.
% Si riscriva il problema come un sistema di Equazioni Differenziali Ordinarie del
% primo ordine nella forma
% dy/dt(t) = f (y) + g(t) t ∈ (0, tf),
% y(0) = y0,
% con y(t) = (w(t), x(t))T , dove w(t) = x'(t) per t ∈ (0, tf). Si riportino le espressioni
% di f (y) ∈ R2, g(t) : (0, tf ) → R2, y0 e tf

% w'(t) = -2w(t) - 10x^2(t) + z(t)
% x'(t) = w(t)

z = @(t) exp(-t/2) .* (2*cos(t) - 7/2*sin(t)) + 40*exp(-t).*sin(t).^2;

f  = @(y) [-2*y(1) - 10*y(2)^2; y(1)];
g  = @(t) [z(t); 0];
y0 = [2; 0];
tf = 10;

%% 2.
% Si approssimi il problema tramite il metodo di Eulero in avanti con passo
% h = 10−2. Si riportino, oltre ai comandi Matlabr usati:
% • i valori delle approssimazioni u1 e uNh rispettivamente di x(t1) e x(tf), dove
% tn = n h per n = 0, 1, . . . , Nh, h = tf/Nh;
% • il tempo discreto tm ≥ 0 tale per cui |un| < 0.1 per ogni n ≥ m

P  = @(t, y) f(y) + g(t);
h  = 1e-2;
Nh = tf/h;

[t, u] = eulerfwd_systems(P, [0, tf], y0, Nh);

u1 = u(2, 1+1);
uN = u(2, end);

m = Nh + 1;
while abs(u(2, m)) < 0.1
    m = m - 1;
end
tm = t(m+1);

disp(u1); % 0.0200
disp(uN); % -0.0688
disp(tm); % 5.6800

%% 3.
% Dopo aver risposto al Punto 2) e sapendo che la soluzione esatta del problema (1) è
% x(t) = 2 e−t/2 sin(t), si calcolino gli errori Eh = max n=0,...,Nh |un − x(tn)| ottenuti con
% il metodo di Eulero in avanti e corrispondenti ai passi h1 = 10−3, h2 = 5 · 10−4,
% h3 = 2.5 · 10−4 e h4 = 1.25 · 10−4, essendo un l’approssimazione di x(tn). Si
% riportino i valori Ehi per i = 1, . . . , 4.

sol = @(t) 2*exp(-t/2).*sin(t);
h_values = [1e-3, 5e-4, 2.5e-4, 1.25e-4];
err_values = zeros(1, length(h_values));

it = 1;
for h = h_values
    Nh = tf/h;
    [t, u] = eulerfwd_systems(P, [0, tf], y0, Nh);
    err_values(it) = max(abs(u(2, :) - sol(t)));
    
    it = it + 1;
end

disp(err_values);
% 0.0046    0.0023    0.0011    0.0006

%% 4.
% Si utilizzino gli errori Ehi ottenuti per stimare algebricamente l’ordine
% di convergenza p del metodo di Eulero in avanti. Si giustifichi la risposta
% data e la si motivi alla luce della teoria.

h1 = h_values(end-1);
h2 = h_values(end);

E1 = err_values(end-1);
E2 = err_values(end);

p = log10(E2 / E1) / log10(h2 / h1);

disp(p); % 1.0034

% L'ordine di convergenza del metodo di Eulero in avanti è circa 1.
% Questo è coerente con la teoria, in quanto il metodo di Eulero in avanti
% è un metodo di ordine 1.

%% 5.
% Con riferimento al sistema di Equazioni Differenziali Ordinarie del Punto, per quali valori di
% h > 0 il metodo di Eulero in avanti risulta assolutamente stabile?

R = stability_function("eulerfwd");
% Determino df/dy => Jacobiano di f
t = sym('t');
y = sym('y', [1, 2]);
f_sym(t, y) = [-2*y(1) - 10*y(2)^2; y(1)];
J_sym(t, y) = jacobian(f_sym, y);

x_ex_sym(t) = 2*exp(-t/2)*sin(t);
w_ex_sym(t) = diff(x_ex_sym, t);

% Sostiuisco y con la soluzione esatta
J_ex_sym = subs(J_sym, y, [w_ex_sym x_ex_sym]);
J_ex = matlabFunction(J_ex_sym);

hmax = abs_stability(R, [0 tf], J_ex, sol);

disp(hmax);

%% 6.
% Si vuole ora applicare a un sistema di Equazioni Differenziali Ordinarie nella
% forma (2) il seguente metodo multipasso, scritto di seguito per un problema di
% Cauchy scalare con y′(t) = f (t, y(t)) per t ∈ (t0, tf ) e condizione iniziale y(t0) = y0:
% u_n+1 = u_n + 3/2 h f(t_n, u_n) − 1/2 h f (t_n−1, u_n−1) per n = 1, 2, . . . , Nh − 1,
% u1 = u0 + h f (t0, u0),
% u0 = y0.
% Si utilizzi la funzione precedentemente implementata per risolvere il sistema di
% Equazioni Differenziali Ordinarie (2) di cui al Punto 1) usando il passo h = 10−2.
% Si riportino i valori delle approssimazioni u1, u2 e uNh rispettivamente di x(t1),
% x(t2) e x(tf ), oltre ai comandi e alla funzione implementata.

h = 1e-2;
Nh = tf/h;

[t, u] = multipass_systems(P, [0, tf], y0, Nh);

u1 = u(2, 1+1);
u2 = u(2, 2+1);
uN = u(2, end);

disp(u1); % 0.0200
disp(u2); % 0.0397
disp(uN); % -0.073

%% 7.
% Si ripetano i Punti 3) e 4) per stimare l’ordine di
% convergenza p atteso dal metodo. Si riportino, oltre ai comandi Matlabr usati, gli
% errori Ehi e l’ordine p stimato.

err_values = zeros(1, length(h_values));

it = 1;
for h = h_values
    Nh = tf/h;
    [t, u] = multipass_systems(P, [0, tf], y0, Nh);
    err_values(it) = max(abs(u(2, :) - sol(t)));
    
    it = it + 1;
end

E1 = err_values(end-1);
E2 = err_values(end);
h1 = h_values(end-1);
h2 = h_values(end);

p = log10(E2 / E1) / log10(h2 / h1);

disp(p); % 1.9999


% Funzioni:

function [t_h, u_h] = multipass_systems(f, tv, y0, Nh)
t0 = tv(1);
tf = tv(2);

t_h   = linspace(t0, tf, Nh+1);
N_len = length(t_h);
u_h   = zeros(length(y0), N_len);

h = (tf - t0) / Nh;

u_h(:, 1) = y0;
u_h(:, 2) = u_h(:, 1) + h * f(t_h(1), u_h(:, 1));

for i=2:N_len-1
    u_h(:, i + 1) = u_h(:, i) + 3/2 * h * f(t_h(i), u_h(:, i)) - 1/2 * h * f(t_h(i-1), u_h(:, i-1));
end

end