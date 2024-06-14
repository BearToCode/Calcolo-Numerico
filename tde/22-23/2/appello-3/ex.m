clear; clc;

% Si consideri il seguente problema con soluzione x(t) : [0, 100] → R:
% 5 x''(t) + 1/3 x'(t) + 20 x(t) = z(t) t ∈ (0, 100],
% x'(0) = − 1/3 ,
% x(0) = 10,
% dove z(t) : (0, 100] → R `e una generica funzione assegnata.

%% 1.
% Si riscriva il problema (1) come un sistema di Equazioni Differenziali Ordinarie
% del primo ordine nella seguente forma non omogenea a coefficienti costanti
% dy/dt (t) = Ay + g(t) t ∈ (0, tf ],
% y(0) = y0,
% con y(t) = (w(t), x(t))T , dove w(t) = x'(t) per t ∈ (0, tf ]. Si riportino le espressioni
% di A ∈ R2×2, g(t) : (0, tf ] → R2, y0 ∈ R2 e tf

% w'(t) = 1/5 * (-1/3 * w(t) - 20 * x(t) + z(t))
% x'(t) = w(t)

A = [
    -1/15 -4;
    1     0
    ];

gz = @(z) @(t) [
    z(t)/5;
    0;
    ];

y0 = [ -1/3; 10 ];

%% 2.
% Si approssimi il problema con z(t) = 0 tramite il metodo di Eulero
% in avanti con passo h = 10^-2. Si riportino:
% • i valori delle approssimazioni u1, u2 e uNh rispettivamente di x(t1), x(t2) e
%   x(tf ), dove tn = n h per n = 0, 1, . . . , Nh, h = tf/Nh;
% • il tempo discreto tm ≥ 0 tale per cui |un| < x(0)/2 per ogni n ≥ m;
% • il tempo discreto tk ≥ 0 tale per cui si ottiene il valore massimo di |vn| per
%   n = 0, 1, . . . , Nh, essendo vn l’approssimazione di x'(tn).

h = 10^-2;
g = gz(@(t) 0);
tf = 100;
Nh = (tf - 0) / h;

P = @(t, y) A * y + g(t);

[t, u] = eulerfwd_systems(P, [0 tf], y0, Nh);

u1  = u(2, 1 + 1);
u2  = u(2, 2 + 1);
uNh = u(2, end);

target = 10/2;
it = length(t);
while abs(u(2, it)) <= target
    it = it - 1;
end
tm = t(it+1);

[~, idx] = max(abs(u(1, :)));
tk = t(idx);

disp(u1);
disp(u2);
disp(uNh);
disp(tm);
disp(tk);

% u1  = 9.9967
% u2  = 9.9893
% uNh = 1.3120
% tm  = 51.8700
% tk  = 0.7700

%% 3.
% Sapendo che la soluzione esatta del problema (1) è x(t) = 10 e−t/30 cos (√(3599/900) t)
% si calcolino gli errori Eh = max n=0,...,Nh |un − x(tn)|
% ottenuti con il metodo di Eulero in avanti e corrispondenti ai passi h1 = 10−3,
% h2 = 5 · 10−4, h3 = 2.5 · 10−4 e h4 = 1.25 · 10−4, essendo un l’approssimazione di
% x(tn). Si riportino i valori Ehi per i = 1, . . . , 4.

sol = @(t) 10 * exp(-t/30) .* cos(sqrt(3599/900) * t);

h_values   = [10^-3, 5*10^-4, 2.5*10^-4, 1.25*10^-4];
err_values = zeros(1, length(h_values));

it = 1;
for h = h_values
    Nh = (tf - 0) / h;
    [t, u] = eulerfwd_systems(P, [0 tf], y0, Nh);
    
    x_approx = u(2, :);
    x_ex     = sol(t);
    
    err_values(it) = max(abs(x_approx - x_ex));
    
    it = it + 1;
end

disp(err_values);

% err_values =     0.2276    0.1120    0.0556    0.0277

%% 4.
% Si utilizzino gli errori per stimare algebricamente l’ordine
% di convergenza p del metodo di Eulero in avanti. Si riportino tutti i comandi
% Matlabr usati, si giustifichi la risposta data e la si motivi dettagliatamente alla
% luce della teoria.

h1 = h_values(end-1);
h2 = h_values(end);

E1 = err_values(end-1);
E2 = err_values(end);

p = log10(E2 / E1) / log10(h2 / h1);

disp(p);

% p = 1.0054

%% 5.
% Con riferimento al sistema di EDO con z(t) = 0, per quali valori
% di h > 0 i metodi di Heun e Crank–Nicolson risultano assolutamente stabili? Si
% riportino: la definzione di assoluta stabilità, il procedimento seguito, la giustifi-
% cazione teorica del risultato e tutti i comandi Matlabr usati.

R_cn = stability_function('cn');
R_heun = stability_function('heun');

hmax_cn = linear_abs_stability(A, R_cn);
hmax_heun = linear_abs_stability(A, R_heun);

disp(hmax_cn);
disp(hmax_heun);

% hmax_cn = Inf
% hmax_heun = 0.2663

%% 6.
% Si vuole ora approssimare il sistema di EDO con tutti i dati del
% e z(t) = 0 tramite il metodo di Crank–Nicolson con passo h = 0.1. Si utilizzi
% un’implementazione computazionalmente efficiente del metodo, fornendone gius-
% tificazione. Si riportino i valori delle approssimazioni u1, u2 e uNh rispettivamente
% di x(t1), x(t2) e x(tf) così ottenute.

h     = 0.1;
theta = 0.5;
Nh    = (tf - 0) / h;

[~, u] = theta_systems(P, [0 tf], y0, Nh, theta);

u1 = u(2, 1 + 1);
u2 = u(2, 2 + 1);
uNh = u(2, end);

disp(u1);
disp(u2);
disp(uNh);

% u1  =  9.7697
% u2  =  9.1553
% uNh = -0.0663

%% 7.
% Si consideri ora il metodo di Runge–Kutta associato alla seguente tabella di Butcher
% 3/8 3/8 0
% 5/8 1/4 3/8
% 0   1/2 1/2
% Si tratta di un metodo esplicito o implicito? Si scriva un’opportuna funzione
% che implementi il metodo precedente per un sistema di EDO con il generico passo h > 0.
% Si utilizzi la funzione precedentemente implementata per risolvere il sistema
% di EDO con i dati di cui al Punto 1) e z(t) = 0 usando il passo h = 0.1. Si
% riportino i valori delle approssimazioni u1, u2 e uNh rispettivamente di x(t1), x(t2)
% e x(tf ) cos`ı ottenute e tutti i comandi Matlabr usati.

B = [
    3/8 3/8 0;
    5/8 1/4 3/8;
    0   1/2 1/2
    ];
h = 0.1;

[~, u] = rk_implicit(P, B, [0 tf], y0, h);

u1 = u(2, 1 + 1);
u2 = u(2, 2 + 1);
uNh = u(2, end);

disp(u1);
disp(u2);
disp(uNh);

% u1  = 9.7694
% u2  = 9.1542
% unh = -0.0210