clear; clc;

% Si consideri il seguente problema con soluzione (x1(t), x2(t))T : [0, 20] → R2:
% 3 x1''(t) + 2 x1'(t) + 9 x1(t) − 4 x2(t) = f1(t) t ∈ (0, 20),
% 2 x2''(t) + 3 x2'(t) − 4 x1(t) + 4 x2(t) = f2(t) t ∈ (0, 20),
% x1'(0) = −3/5, x2'(0) = −4/5,
% x1(0) = 3, x2(0) = 4,
%
% dove
% f1(t) = − (246/25 cos(2t) + 16 cos(3t) + 24/5 sin(2t)) exp(−t/5),
% f2(t) = − (12 cos(2t) + 1452/25 cos(3t) + 132/5 sin(3t)) exp(−t/5).

f1 = @(t) -(246/25*cos(2*t) + 16*cos(3*t) + 24/5*sin(2*t)).*exp(-t/5);
f2 = @(t) -(12*cos(2*t) + 1452/25*cos(3*t) + 132/5*sin(3*t)).*exp(-t/5);

%% 1.
% Si riscriva il problema (1) come un sistema di Equazioni Differenziali Ordinarie del
% primo ordine nella forma
% dy/dt (t) = A y + g(t) t ∈ (0, tf),
% y(0) = y0,
% con y(t) = (w1(t), x1(t), w2(t), x2(t), )T , dove w1(t) = x1'(t) e w2(t) = x2'(t). Si
% riportino le espressioni di A ∈ R4×4, g(t) : (0, tf) → R4, y0 ∈ R4 e tf .

A = [
    -2/3 -3   0    4/3;
    1    0    0    0;
    0    2    -3/2 -2;
    0    0    1    0;
    ];
g = @(t) [
    f1(t)/3;
    0;
    f2(t)/2;
    0;
    ];
y0 = [-3/5; 3; -4/5; 4];
tf = 20;

%% 2.
% Si approssimi il problema tramme il metodo di Eulero in avanti
% con passo h = 0.1. Si riportino:
% • i valori delle approssimazioni u1 e uNh rispettivamente di y(t1) e y(tf), dove
%   tn = n h per n = 0, 1, . . . , Nh, h = tf/Nh;
% • il tempo discreto tm ≥ 0 tale per cui |(un)2| < 0.5 e |(un)4| < 0.5 per ogni
%   n ≥ m, essendo (un)2 e (un)4 rispettivamente le approssimazioni di x1(tn)
%   e x2(tn).

P  = @(t, y) A * y + g(t);
h  = 0.1;
Nh = (tf - 0) / h;

[t, u] = eulerfwd_systems(P, [0 tf], y0, Nh);

u1  = u(:, 1 + 1);
uNh = u(:, end);

m = length(t);
while (abs(u(2, m)) < 0.5) && (abs(u(4, m)) < 0.5)
    m = m - 1;
end
tm = t(m+1);

disp(u1);
disp(uNh);
disp(tm);

% u1 =
%    -1.7880
%     2.9400
%    -4.3840
%     3.9200
% uNh =
%    -0.1927
%    -0.0983
%     0.0701
%    -0.0103
% tm =
%    12.9000

%% 3.
% Sapendo che la soluzione esatta del problema è
% (x1(t), x2(t))T =
% (3 cos(2t) exp(−t/5), 4 cos(3t) exp(−t/5))T, si calcolino gli errori sulla
% seconda componente, definiti come Eh = max n=0,...,Nh |(un)4 − x2(tn)|, ottenuti con
% il metodo di Eulero in avanti e corrispondenti ai passi h1 = 10−2, h2 = 5 · 10−3,
% h3 = 2.5 · 10−3 e h4 = 1.25 · 10−3. Si riportino i valori Ehi per i = 1, . . . , 4 e i
% comandi Matlabr usati.

x1_sol = @(t) 3*cos(2*t).*exp(-t/5);
x2_sol = @(t) 4*cos(3*t).*exp(-t/5);

h_values = [1e-2, 5e-3, 2.5e-3, 1.25e-3];
err_values = zeros(1, length(h_values));

for h = h_values
    Nh = (tf - 0) / h;
    [t, u] = eulerfwd_systems(P, [0 tf], y0, Nh);
    x2_approx = u(4, :);
    x2_exact  = x2_sol(t);
    
    err_values(h == h_values) = max(abs(x2_approx - x2_exact));
end

disp(err_values);

% err_values =
%     0.1720    0.0858    0.0428    0.0214

%% 4.
% Si utilizzino gli errori Ehi ottenuti per stimare algebricamente l’ordine
% di convergenza p del metodo di Eulero in avanti. Si riportino i comandi,
% si giustifichi la procedura usata per la stima e la si interpreti alla luce della teoria.

h1 = h_values(end-1);
h2 = h_values(end);

E1 = err_values(end-1);
E2 = err_values(end);

p = log10(E2 / E1) / log10(h2 / h1);

disp(p);

% p =
%     1.0010

%% 5.
% Con riferimento al sistema di Equazioni Differenziali Ordinarie del Punto 1)
% per g = 0, per quali valori di h > 0 il metodo di Eulero in avanti risulta assoluta-
% mente stabile? Si riportino il procedimento e i comandi Matlabr usati, oltre alla
% giustificazione teorica del risultato.

R = stability_function("eulerfwd");
hmax = linear_abs_stability(A, R);

disp(hmax);

% 0.2246

%% 6.
% Si vuole ora approssimare il sistema di Equazioni Differenziali Ordinarie (2) con
% i dati precedenti tramite il metodo di Eulero all’indietro con passo h = 0.1. Si
% utilizzi un’implementazione computazionalmente efficiente del metodo, fornendone
% giustificazione. Si riportino i valori delle approssimazioni (u1)4 di x2(t1) e (u2)4
% di x2(t2) così ottenute.

h = 0.1;
Nh = tf / h;

[~, u] = eulerbkw_systems(P, [0 tf], y0, Nh);

u1_4 = u(4, 1 + 1);
u2_4 = u(4, 2 + 1);

disp(u1_4);
disp(u2_4);

% u1_4 =
%   3.5973
% u2_4 =
%   2.9319

%% 7.
% Si vuole ora applicare a un sistema di Equazioni Differenziali Ordinarie nella
% forma (2) il seguente metodo multipasso, scritto di seguito per un problema di
% Cauchy scalare con y′(t) = f (t, y(t)) per t ∈ (t0, tf) e condizione iniziale
% y(t0) = y0:
% 3/2 u_n+1 = 2 u_n − 1/2 u_n−1 + h f(t_n+1, u_n+1) per n = 1, 2, . . . , Nh − 1,
% u1 = u0 + h/2 f (t0, u0) + h/2 f (t1, u1),
% u0 = y0.
% Si scriva un’opportuna funzione che implementi il metodo precedente per
% un sistema di EDO con il generico passo h > 0.
% Si utilizzi la funzione precedentemente implementata per risolvere il sistema di
% Equazioni Differenziali Ordinarie (2) di cui al Punto 1) usando il passo h = 0.1.
% Si riportino i valori delle approssimazioni (u1)4, (u2)4 e (uNh)4 rispettivamente di
% x2(t1), x2(t2) e x2(tf), oltre ai comandi e alla funzione implementata.

h  = 0.1;
Nh = tf / h;

[t, u] = multipass_systems(P, [0 tf], y0, Nh);

u1_4  = u(4, 1 + 1);
u2_4  = u(4, 2 + 1);
uNh_4 = u(4, end);

disp(u1_4);
disp(u2_4);
disp(uNh_4);

% u1_4 =
%   3.7499
% u2_4 =
%   3.3467
% uNh_4 =
%   -0.0374

function [t_h, u_h] = multipass_systems(f, tv, y0, Nh)
nmax = 1000;
toll = 1e-6;

t0 = tv(1);
tf = tv(2);

t_h   = linspace(t0, tf, Nh+1);
N_len = length(t_h);
u_h   = zeros(length(y0), N_len);

h = (tf - t0) / Nh;

u_h(:, 1) = y0;
% Trovo u1
phi = @(u) y0 + h/2 * f(t0, y0) + h/2 * f(t_h(1+1), u);
[succ] = fixedpt_systems(y0, phi, nmax, toll);
sol    = succ(:, end);
u_h(:, 2) = sol;

for i=2:N_len-1
    % u(n+1) = u(n) + h * f(t(n+1), u(n+1))
    phi = @(u) 2/3 * ( 2 * u_h(:, i) - 1/2 * u_h(:, i) ) + 2/3 * h * f(t_h(i + 1), u);
    x0  = u_h(:, i);
    
    [succ] = fixedpt_systems(x0, phi, nmax, toll);
    sol    = succ(:, end);
    
    u_h(:, i+1) = sol;
end
end