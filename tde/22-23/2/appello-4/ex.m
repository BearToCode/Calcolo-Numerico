clear; clc;

% Si consideri il seguente problema con soluzione (x1(t), x2(t))T : [0, 50] → R2:
% 3 x1''(t) + 2 x1'(t) + 12 x1(t) − 4 x2(t) = f1(t)   t ∈ (0, 50),
% x2''(t) + 3 x2'(t) − 4 x1(t) + 4 x2(t) = f2(t)      t ∈ (0, 50),
% x1'(0) = − 7/5 , x2'(0) = 27, x1(0) = 7, x2(0) = 0,
%
% dove
% f1(t) = − (6349/25 cos(4t) + 36 sin(3t) + 112/5 sin(4t)) exp(−t/5),
% f2(t) = − (28 cos(4t) − 351/5 cos(3t) + 1251/25 sin(3t)) exp(−t/5).

f1 = @(t) - (6349/25 * cos(4*t) + 36 * sin(3*t) + 112/5 * sin(4*t)) * exp(-t/5);
f2 = @(t) - (28 * cos(4*t) - 351/5 * cos(3*t) + 1251/25 * sin(3*t)) * exp(-t/5);

%% 1.
% Si riscriva il problema (1) come un sistema di Equazioni Differenziali Ordinarie del
% primo ordine nella forma
% dy/dt (t) = A y + g(t) t ∈ (0, tf),
% y(0) = y0,
% con y(t) = (w1(t), x1(t), w2(t), x2(t), )T , dove w1(t) = x1'(t) e w2(t) = x2'(t). Si
% riportino le espressioni di A ∈ R4×4, g(t) : (0, tf) → R4, y0 ∈ R4 e tf .

A = [
    -2/3 -4   0    4/3;
    1    0    0    0;
    0    4    -3   -4;
    0    0    1    0
    ];
g = @(t) [
    f1(t) / 3;
    0;
    f2(t);
    0
    ];
y0 = [-7/5; 7; 27; 0];
tf = 50;

%% 2.
% Si approssimi il problema tramite il metodo di Heun con passo h = 0.1.
%Si riportino:
% • i valori delle approssimazioni u1 e uNh rispettivamente di y(t1) e y(tf), dove
%   tn = n h per n = 0, 1, . . . , Nh, h = tf/Nh;
% • il tempo discreto tm ≥ 0 tale per cui |(un)2| < 0.5 e|(un)4| < 0.5 per ogni
%   n ≥ m, essendo (un)2 e (un)4 rispettivamente le approssimazioni di x1(tn)
%   e x2(tn).

P = @(t, y) A * y + g(t);
h = 0.1;

Nh = tf / h;

[t, u] = heun_systems(P, [0 tf], y0, Nh);

u1  = u(:, 1+1);
uNh = u(:, end);


it = length(t);
while (abs(u(2, it)) <= 0.5) && (abs(u(4, it)) <= 0.5)
    it = it - 1;
end
tm = t(it+1);

disp(u1);
disp(uNh);
disp(tm);

% u1 =
%   -11.8966
%     6.3014
%    24.7021
%     2.6460

% uNh =
%     0.0011
%     0.0002
%     0.0009
%    -0.0003

% tm =
%    14.3000

%% 3.
% Dopo aver risposto al Punto 2) e sapendo che la soluzione esatta del problema (1) `e
% (x1(t), x2(t))T = (7 cos(4t) exp(−t/5), 9 sin(3t) exp(−t/5))^T, si calcolino gli errori definiti
% come Eh = max n=0,...,Nh ∣(un)2 − x1(tn)∣, ottenuti con il metodo di Heun per il prob-
% lema (2) e corrispondenti ai passi h1 = 10^−1, h2 = 5 · 10^−2, h3 = 2.5 · 10^−2 e
% h4 = 1.25 · 10^−2. Si riportino i valori Ehi per i = 1, . . . , 4;

sol = @(t) [
    7 * cos(4*t) .* exp(-t/5);
    9 * sin(3*t) .* exp(-t/5)
    ];

h_values = [10^-1, 5*10^-2, 2.5*10^-2, 1.25*10^-2];
err_values = zeros(1, length(h_values));

for h = h_values
    Nh = tf / h;
    [t, u] = heun_systems(P, [0 tf], y0, Nh);
    y_ex   = sol(t);
    
    x1_approx = u(2, :);
    x1_ex     = y_ex(1, :);
    
    err_values(h_values == h) = max(abs(x1_approx - x1_ex));
end

disp(err_values)

% err_values =
%     0.3132    0.0778    0.0193    0.0048

%% 4.
% Si utilizzino gli errori Ehi ottenuti al Punto 3) per stimare algebricamente l’ordine
% di convergenza p del metodo di Heun. Si riportino i comandi Matlabr , si giustifichi
% la procedura usata per la stima e la si interpreti alla luce della teoria.

h1 = h_values(end-1);
h2 = h_values(end);

E1 = err_values(end-1);
E2 = err_values(end);

p = log10(E2 / E1) / log10(h2 / h1);

disp(p); % 2.0064

%% 5.
% Con riferimento al sistema di Equazioni Differenziali Ordinarie per
% g = 0, per quali valori di h > 0 il metodo di Heun risulta assolutamente stabile?
% Si riportino il procedimento e i comandi usati, oltre alla giustificazione
% teorica dettagliata del risultato fornito.

R = stability_function("heun");
hmax = linear_abs_stability(A, R);

disp(hmax); % 0.7143

%% 6.
% Si consideri ora il metodo di Runge–Kutta associato alla seguente tabella di Butcher
% 0   0   0   0
% 1   1   0   0
% 1/2 1/4 1/4 0
%     1/6 1/6 2/3
% Si tratta di un metodo esplicito o implicito? Si scriva un’opportuna funzione
% che implementi il metodo precedente per un sistema di EDO nella forma (2)
% con il generico passo h > 0.
% Si utilizzi la funzione precedentemente implementata per risolvere il sistema
% di EDO usando il passo h = 0.1. Si riportino i valori delle approssimazioni
% u1, u2 e uNh rispettivamente di y(t1), y(t2) e y(tf) così ottenute e tutti i
% comandi usati.

B = [
    0   0   0   0;
    1   1   0   0;
    1/2 1/4 1/4 0;
    0   1/6 1/6 2/3
    ];
h = 0.1;

[t, u] = rk_systems(P, B, [0 tf], y0, h);

u1  = u(:, 1+1);
u2  = u(:, 2+1);
uNh = u(:, end);

disp(u1);
disp(u2);
disp(uNh);

% u1 =
%   -11.9516
%     6.3239
%    24.7611
%     2.6054

% u2 =
%   -20.2346
%     4.6940
%    20.4317
%     4.8796

% uNh =
%     0.0011
%     0.0002
%     0.0009
%    -0.0003

%% 7.
% Si consideri la soluzione x1(t) del problema (1) riportata al Punto 3) e il corrispon-
% dente interpolante lineare a tratti ΠH1 x1(t) costruito sull’intervallo [0, tf] con passo
% H = 0.1. Senza costruire esplicitamente l’interpolante, si stimi l’errore di inter-
% polazione commesso eH1 := max t∈[0,tf] |x1(t) − ΠH1 x1(t)|. Si riportino tutti i comandi
% Matlab usati e la giustificazione teorica del risultato ottenuto.

syms x;
H      = 0.1;
nodes  = 0:H:tf;
sym_x1 = 7 * cos(4*x) * exp(-x/5);

err_approx = approx_piecewise_interp_err(sym_x1, x, nodes);

disp(err_approx); % 0.1397