clear; clc;

% Si consideri il seguente problema con soluzione (x1(t), x2(t))T : [0, 20] → R2:
% 4 x1''(t) + 2 x1'(t) + 11 x1(t) − 5 x2(t) = f1(t) t ∈ (0, 20),
% 2 x2''(t) + 3 x2'(t) − 5  x1(t) + 5 x2(t) = f2(t) t ∈ (0, 20),
% x1'(0) = −2, x2'(0) = −1, x1(0) = 8, x2(0) = 4
% dove
% f1(t) = − (20 cos(2t) + 202 cos(3t)) e^(−t/4),
% f2(t) = − (29/2 cos(2t) + 40 cos(3t) + 16 sin(2t)) e^(−t/4).

f1 = @(t) - (20*cos(2*t) + 202*cos(3*t)) * exp(-t/4);
f2 = @(t) - (29/2*cos(2*t) + 40*cos(3*t) + 16*sin(2*t)) * exp(-t/4);

%% 1. Si riscriva il problema (1) come un sistema di Equazioni Differenziali Ordinarie del
% primo ordine nella forma
% dy/dt (t) = A y + g(t) t ∈ (0, tf ),
% y(0) = y0,
% con y(t) = (w1(t), x1(t), w2(t), x2(t), )T , dove w1(t) = x1'(t) e w2(t) = x2'(t). Si
% riportino le espressioni di A ∈ R4×4, g(t) : (0, tf) → R4, y0 ∈ R4 e tf .

% w1'(t) = (-2 w1(t) -11 x1(t) +5 x2(t) +f1(t))/4
% x1'(t) = w1(t)
% w2'(t) = (5 x1(t) -3 w2(t) -5 x2(t) +f2(t))/2
% x2'(t) = w2(t)

A = [
    -1/2  -11/4 0     5/4;
    1     0     0     0;
    0     5/2   -3/2  -5/2;
    0     0     1     0
    ];
g = @(t) [f1(t)/4; 0; f2(t)/2; 0];
y0 = [-2; 8; -1; 4];
tf = 20;

%% 2. Si approssimi il problema tramite il metodo di Heun con passo
% h = 0.1. Si riportino:
% • i valori delle approssimazioni u_1 e u_Nh rispettivamente di y(t1) e y(tf ), dove
%   t_n = n*h per n = 0, 1, . . . , Nh, h = tf/Nh;
% • il tempo discreto tm ≥ 0 tale per cui
%   ∣(u_n)2∣ < 1 e ∣(u_n)4∣ < 1 per ogni
%   n ≥ m, essendo (u_n)2 e (u_n)4 rispettivamente le approssimazioni di x1(tn)
%   e x2(t_n).

h   = 0.1;
Nh  = tf/h;
P   = @(t, y) A*y + g(t);
[~, u] = heun_systems(P, [0, tf], y0, Nh);

u_1  = u(:, 1+1);
u_Nh = u(:, end);

disp(u_1);
disp(u_Nh);

Nm = Nh + 1;
while norm(u(2, Nm)) <= 1 && norm(u(4, Nm)) <= 1
    Nm = Nm - 1;
end

tm = Nm*h;

disp(tm) % 7.6

%% 3. Sapendo che la soluzione esatta del problema è
% (x1(t), x2(t))T =(8 cos(3t) e−t/4, 4 cos(2t) e−t/4)T, si calcolino gli errori sulla
% prima componente, definiti come Eh = max n=0,...,Nh |(u_n)2 − x1(t_n)|, ottenuti con il
% metodo di Heun e corrispondenti ai passi h1 = 10−2, h2 = 5 · 10−3, h3 = 2.5 · 10−3
% e h4 = 1.25 · 10−3. Si riportino i valori Ehi per i = 1, . . . , 4

x1_ex = @(t) 8*cos(3*t).*exp(-t/4);
x2_ex = @(t) 4*cos(2*t).*exp(-t/4);

h_values = [1e-2, 5e-3, 2.5e-3, 1.25e-3];
err_values = zeros(1, length(h_values));

it = 1;
for h = h_values
    Nh = tf/h;
    [t, u] = heun_systems(P, [0, tf], y0, Nh);
    err_values(it) = max(abs(u(2, :) - x1_ex(t)));
    
    it = it + 1;
end

disp(err_values); % [1.6456e-03   4.1069e-04   1.0258e-04   2.5634e-05]

%% 4. Si utilizzino gli errori Ehi ottenuti per stimare algebricamente l’ordine
% di convergenza p del metodo di Heun. Si giustifichi
% la procedura usata per la stima e la si interpreti alla luce della teoria.

% Uso gli ultimi due valori di errore per stimare l'ordine di convergenza

h1 = h_values(end-1);
h2 = h_values(end);

E1 = err_values(end-1);
E2 = err_values(end);

p = log10(E2 / E1) / log10(h2 / h1);

% p = 2.0000
% Come atteso, il metodo di Heun è convergente al secondo ordine nella risoluzione
% del problema di Cauchy. (y è C^3)

%% 5. Con riferimento al sistema di Equazioni Differenziali Ordinarie del Punto 1) per
% g = 0, per quali valori di h > 0 il metodo di Heun risulta assolutamente stabile?
% Si riportino il procedimento e i comandi usati, oltre alla giustificazione
% teorica dettagliata del risultato fornito.

% Il metodo di Heun è condizionamente assolutamente stabile, quindi l'assoluta stabilità
% dipende dal valore di h scelto.

% Estendiamo il concetto di assoluta stabilità dal problema modello a un problema di
% Cauchy generico (p147).

% Nel caso vettoriale(p154) diventa:

eigs = eig(A);

% (h * lambda_i) deve appartenere alla regione di assoluta stabilità del metodo

R = stability_function("heun");
hmax = linear_abs_stability(A, R); % 0.7148

%% 6. Si vuole ora approssimare il sistema di Equazioni Differenziali Ordinarie (2) con i
% dati di cui a Punti 1) e 2) tramite il metodo di Crank-Nicolson con passo h = 0.1. Si
% utilizzi un’implementazione computazionalmente efficiente del metodo, fornendone
% giustificazione. Si riportino i valori delle approssimazioni (u1)2 di x1(t1), (u2)2 di
% x1(t2) e (u3)2 di x1(t3) cos`ı ottenute e i comandi usati.

% Crank-Nicolson = theta-metodo con theta = 0.5
h  = 0.1;
Nh = tf/h;

[~, u] = theta_systems(P, [0 tf], y0, Nh, 0.5);

u1 = u(2, 1+1); % 7.4632
u2 = u(2, 2+1); % 6.3072
u3 = u(2, 3+1); % 4.6625

disp(u1);
disp(u2);
disp(u3);

%% 7. Si vuole ora applicare al sistema di Equazioni Differenziali Ordinarie nella forma
% il metodo di Runge–Kutta associato alla seguente tabella di Butcher
% 0   0   0   0
% 1/3 1/3 0   0
% 2/3 0   2/3 0
%     1/4 0   3/4
% Si discutano le proprietà del metodo corrispondente alla tabella.
% Si implementi in il metodo precedente e lo si utilizzi per risolvere il
% sistema di Equazioni Differenziali Ordinarie con i dati di cui ai Punti 1) e 2)
% usando il passo h = 0.1. Si riportino i valori delle approssimazioni (u1)2, (u2)2 e
% (uNh )2 rispettivamente di x1(t1), x1(t2) e x1(tf), oltre ai comandi e alla funzione
% Matlabr implementata.

B = [
    0   0   0   0;
    1/3 1/3 0   0;
    2/3 0   2/3 0;
    0   1/4 0   3/4
    ];

[t, u] = rk_systems(P, B, [0 tf], y0, h);

u1 = u(2, 1+1); % 7.4528
u2 = u(2, 2+1); % 6.2787
uN = u(2, end); % -0.0513

disp(u1);
disp(u2);
disp(uN);