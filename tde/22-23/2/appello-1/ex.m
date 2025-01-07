clear; clc;

%% 1.
% Si riscriva il problema come un sistema di Equazioni Differenziali Ordinarie del
% primo ordine nella forma
% dy/dt(t) = Ay + g(t) t ∈ (0, tf),
% y(0) = y0
% con y(t) = (x1(t), w2(t), x2(t))T, dove w2(t) = x2'(t). Si riportino le espressioni
% di A ∈ R3×3, g(t) : (0, tf) → R3, y0 ∈ R3 e tf .

f1 = @(t) 6/25 * (-5 * sin(2*t) - 100 * cos(t) + 348 * cos(t).^2 - 174) .* exp(-t/5);
f2 = @(t) 3/5  * (19 * cos(t) - 5 * sin(t) - 40 * cos(t).^2 + 20) .* exp(-t/5);

A = [
    -1/3 -26/3 8/3;
    1     0    0;
    0     4    -4;
    ];

g = @(t) [
    f1(t)/3;
    0;
    f2(t);
    ];

y0 = [-3/5; 3; 3];
tf = 10;


%% 2.
% Si approssimi il problema tramite il metodo di Heun modificando
% opportunamente la funzione Heun.m con passo h = 0.1.
% Si riportino i valori delle approssimazioni u1 e uNh rispettivamente di y(t1) e y(tf), dove
% tn = n h per n = 0, 1, . . . , Nh, h = tf/Nh

h = 0.1;
Nh = tf/h;

P = @(t, y) A*y + g(t);
[~, u] = heun_systems(P, [0, tf], y0, Nh);

u1 = u(:, 1+1);
uNh = u(:, end);

disp(u1);
disp(uNh);

% u1 =
%     3.0040
%   -10.2254
%     3.4013
% uNh =
%     0.0085
%     0.0623
%     0.0250

%% 3.
% Sapendo che la soluzione esatta del problema è (x1(t), x2(t))T =
% (3 cos(t) e−t/4, 4 cos(5t) e−t/4)T, si calcolino gli errori sulla
% seconda componente, definiti come Eh = max n=0,...,Nh |(u_n)3 − x2(t_n)|, ottenuti con il
% metodo di Heun e corrispondenti ai passi h1 = 10−1, h2 = 5 · 10−2, h3 = 2.5 · 10−2
% e h4 = 1.25 · 10−2. Si riportino i valori Ehi per i = 1, . . . , 4

sol_exact = @(t) [
    3 * cos(2*t) .* exp(-t/5);
    3 * cos(t) .* exp(-t/5);
    ];

h_values   = [1e-1, 5e-2, 2.5e-2, 1.25e-2];
err_values = zeros(1, length(h_values));

it = 1;
for h = h_values
    Nh = tf/h;
    [t, u] = heun_systems(P, [0, tf], y0, Nh);
    
    u_x2 = u(2, :);
    
    exact = sol_exact(t);
    ex_x2 = exact(1, :);
    
    err_values(it) = max(abs(u_x2 - ex_x2));
    
    it = it + 1;
end

disp(err_values);

% err_values =
% 0.3198    0.0790    0.0195    0.0049

%% 4.
% Si utilizzino gli errori Ehi ottenuti al Punto 3) per stimare algebricamente l’ordine
% di convergenza p del metodo di Heun. Si giustifichi
% la procedura usata per la stima e la si interpreti alla luce della teoria.

h1 = h_values(end-1);
h2 = h_values(end);

E1 = err_values(end-1);
E2 = err_values(end);

p = log10(E2 / E1) / log10(h2 / h1);

disp(p);

% p =
% 2.0080

%% 5.
% Con riferimento al sistema di Equazioni Differenziali Ordinarie per
% g = 0, per quali valori di h > 0 il metodo di Heun risulta assolutamente stabile?
% Si riportino il procedimento, oltre alla giustificazione
% teorica del risultato.

R = stability_function("heun");
hmax = linear_abs_stability(A, R);

disp(hmax);

% hmax =
% 0.5030

%% 6.
% Si vuole ora approssimare il sistema di Equazioni Differenziali Ordinarie con
% tutti i dati del Punto tramite il metodo di Crank–Nicolson con passo h = 0.1. Si
% utilizzi un’implementazione computazionalmente efficiente del metodo, fornendone
% giustificazione. Si riportino i valori delle approssimazioni (u1)3 di x2(t1) e (u2)3
% di x2(t2) così ottenute e i comandi Matlabr usati.

h = 0.1;
theta = 0.5; % Crank-Nicolson
Nh = tf/h;

[~, u] = theta_systems(P, [0, tf], y0, Nh, theta);

u1_x2 = u(3, 1+1);
u2_x2 = u(3, 2+1);

disp(u1_x2);
disp(u2_x2);

% u1_x2 =
%     3.4480
% u2_x2 =
%     2.1313

%% 7.
% Si consideri ora il metodo di Runge–Kutta associato alla seguente tabella di Butcher
% 0   0   0   0
% 1   1   0   0
% 1/2 1/4 1/4 0
% 0   1/6 1/6 2/3
% Si tratta di un metodo esplicito o implicito? Si scriva un’opportuna funzione
% che implementi il metodo precedente per un sistema di EDO nella forma con il generico passo h > 0.
% Si utilizzi la funzione precedentemente implementata per risolvere il sistema
% di Equazioni Differenziali Ordinarie (2) con i dati di cui al Punto 1) e usando il
% passo h = 0.1. Si riportino i valori delle approssimazioni (u1)3, (u2)3 e (uNh )3
% rispettivamente di x2(t1), x2(t2) e x2(tf ), oltre ai comandi e alla funzione Matlabr
% implementata.

h = 0.1;
Nh = tf/h;

B = [
    0   0   0   0;
    1   1   0   0;
    1/2 1/4 1/4 0;
    0   1/6 1/6 2/3
    ];

[~, u] = rk_systems(P, B, [0, tf], y0, h);

u1_x2 = u(3, 1+1);
u2_x2 = u(3, 2+1);
uNh_x2 = u(3, end);

disp(u1_x2);
disp(u2_x2);
disp(uNh_x2);

% u1_x2 =
%     2.9246
% u2_x2 =
%     2.8222
% uNh_x2 =
%     -0.3516