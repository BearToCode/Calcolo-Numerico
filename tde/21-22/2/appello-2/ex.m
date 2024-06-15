clear; clc;

% Si consideri il seguente problema con soluzione x(t) : [0, 50] → R:
% 2 x''(t) + 1/3 x'(t) + 10 x(t) = z(t) t ∈ (0, 50),
% x'(0) = − 3/4 ,
% x(0) = 9,
%
% dove z(t) : (0, 50) → R `e una funzione assegnata.

%% 1.
% Si riscriva il problema come un sistema di Equazioni Differenziali Ordinarie del
% primo ordine nella seguente forma non omogenea a coefficienti costanti
% dy/dt (t) = Ay + g(t) t ∈ (0, tf),
% y(0) = y0,
%
% con y(t) = (w(t), x(t))T , dove w(t) = x'(t) per t ∈ (0, tf ). Si riportino le espressioni
% di A ∈ R2×2, g(t) : (0, tf ) → R2, y0 e tf .

% w'(t) = -1/6 w(t) - 5 x(t) + 1/2 z(t)
% x'(t) = w(t)

A = [
    -1/6 -5;
    1    0
    ];
gz = @(z) @(t) [1/2*z(t); 0];
y0 = [ -3/4; 9 ];
tf = 50;

%% 2.
% Si approssimi il problema con z(t) = 0 tramite il metodo di Heun.
% A tal fine, si modifichi opportunamente la funzione Heun.m e la si utilizzi
% con il passo h = 10−1. Si riportino, oltre ai comandi usati:
% • i valori delle approssimazioni u1 e uNh rispettivamente di x(t1) e x(tf), dove
%   tn = n h per n = 0, 1, . . . , Nh, h = tf/Nh;
% • il tempo discreto tm ≥ 0 tale per cui |un| < 1 per ogni n ≥ m.

g = gz(@(t) 0);

P  = @(t, y) A*y + g(t);
h  = 1e-1;
Nh = tf/h;

[t, u] = heun_systems(P, [0 tf], y0, Nh);

u1  = u(2, 1+1);
uNh = u(2, end);

it = Nh + 1;
while abs(u(2, it)) < 1
    it = it - 1;
end
tm = t(it+1);

disp(u1);
disp(uNh);
disp(tm);

% u1 =
%     8.7006
% uNh =
%     0.1334
% tm =
%    26.6000

%% 3.
% Sapendo che la soluzione esatta del problema è x(t) = 9 e−t/12 cos(√719/12 t),
% si calcolino gli errori Eh = max n=0,...,Nh |un − x(tn)|
% ottenuti con il metodo di Heun e corrispondenti ai passi h1 = 10−1, h2 = 5 · 10−2,
% h3 = 2.5 · 10−2 e h4 = 1.25 · 10−2, essendo un l’approssimazione di x(tn). Si
% riportino i valori Ehi per i = 1, . . . , 4.

sol = @(t) 9 * exp(-t/12) .* cos(sqrt(719)/12 * t);

h_values = [1e-1, 5e-2, 2.5e-2, 1.25e-2];
err_values = zeros(1, length(h_values));

it = 1;
for h = h_values
    Nh = tf/h;
    [t, u] = heun_systems(P, [0 tf], y0, Nh);
    
    x_exact = sol(t);
    err_values(it) = max(abs(u(2, :) - x_exact));
    
    it = it + 1;
end

disp(err_values);

% err_values =
%     0.7461    0.1852    0.0463    0.0116

%% 4.
% Si utilizzino gli errori Ehi ottenuti al Punto 3) per stimare algebricamente l’ordine
% di convergenza p del metodo di Heun. Si riportino i comandi Matlabr , si giustifichi
% la risposta data e la si motivi dettagliatamente alla luce della teoria

h1 = h_values(end-1);
h2 = h_values(end);

E1 = err_values(end-1);
E2 = err_values(end);

p = log10(E2 / E1) / log10(h2 / h1);

disp(p);

% p =
%    2.0003

%% 5.
% Con riferimento al sistema di Equazioni Differenziali Ordinarie
% con z(t) = 0, per quali valori di h > 0 il metodo di Heun risulta assolutamente
% stabile? Si riportino: la definzione di assoluta stabilità, il procedimento seguito,
% la giustificazione teorica del risultato e i comandi usati.

R = stability_function("heun");
hmax = linear_abs_stability(A, R);

disp(hmax);

% hmax =
%    0.3201

%% 6.
% Si vuole ora applicare a un sistema di Equazioni Differenziali Ordinarie nella
% forma (2) il seguente metodo multipasso, scritto di seguito per un problema di
% Cauchy scalare con y′(t) = A y(t) + g(t), con A ∈ R, per t ∈ (t0, tf ) e condizione
% iniziale y(t0) = y0:
% u_n+1 = 4/3 u_n − 1/3 u_n−1 + 2/3 h [A u_n+1 + g(t_n+1)] per n = 1, 2, . . . , Nh − 1,
% u1 = u0 + h [A u1 + g(t1)] ,
% u0 = y0.
% Si scriva un’opportuna funzione Matlabr che implementi il metodo precedente per
% un sistema di EDO con il generico passo h > 0.
% Si utilizzi la funzione precedentemente implementata per risolvere il sistema di
% Equazioni Differenziali Ordinarie (2) di cui al Punto 1) usando il passo h = 10−1.
% Si riportino i valori delle approssimazioni u1, u2 e uNh rispettivamente di x(t1),
% x(t2) e x(tf), oltre ai comandi e alla funzione Matlabr implementata.

h = 1e-1;
Nh = tf/h;

[t, u] = multipass_systems(P, [0 tf], y0, Nh);

u1  = u(2, 1+1);
u2  = u(2, 2+1);
uNh = u(2, end);

disp(u1);
disp(u2);
disp(uNh);


%% 7.
% Si ripetano i Punti 3) e 4) per stimare l’ordine di
% convergenza p atteso dal metodo. Si riportino, oltre ai comandi Matlabr usati, gli
% errori Ehi e l’ordine p stimato.

h_values = [1e-1, 5e-2, 2.5e-2, 1.25e-2];
err_values = zeros(1, length(h_values));

it = 1;
for h = h_values
    Nh = tf/h;
    [t, u] = multipass_systems(P, [0 tf], y0, Nh);
    
    x_exact = sol(t);
    err_values(it) = max(abs(u(2, :) - x_exact));
    
    it = it + 1;
end

E1 = err_values(end-1);
E2 = err_values(end);
h1 = h_values(end-1);
h2 = h_values(end);

p = log10(E2 / E1) / log10(h2 / h1);

disp(p);

% p = 1.9969

% Funzioni

function [t_h, u_h] = multipass_systems(f, tv, y0, Nh)
t0 = tv(1);
tf = tv(2);

nmax = 1000;
toll = 1e-10;

t_h   = linspace(t0, tf, Nh+1);
N_len = length(t_h);
u_h   = zeros(length(y0), N_len);

h = (tf - t0) / Nh;

u_h(:, 1) = y0;

% Risolvo il sistema non lineare
phi = @(u) u_h(:, 1) + h * f(t_h(1), u);
[succ, ~] = fixedpt_systems(y0, phi, nmax, toll);
u_h(:, 2) = succ(:, end);

for i=2:N_len-1
    % Risolvo il sistema non lineare
    phi = @(u) 4/3 * u_h(:, i) - 1/3 * u_h(:, i - 1) + 2/3 * h * (f(t_h(i + 1), u));
    x0   = u_h(:, i);
    
    [succ, ~] = fixedpt_systems(x0, phi, nmax, toll);
    u_h(:, i + 1) = succ(:, end);
end
end
