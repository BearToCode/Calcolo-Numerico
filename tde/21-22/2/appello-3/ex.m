clear; clc;

% Si consideri il seguente sistema di Equazioni Differenziali Ordinarie del primo or-
% dine nella forma
% dy/dt (t) = A y(t) + g(t) t ∈ (0, tf),
% y(0) = y0,
%
% dove y(t) = (y1(t), y2(t), . . . , ym(t))T , A ∈ Rm×m, g(t) : (0, tf ) → Rm e y0 ∈ Rm,
% per m ≥ 1.
% In particolare, consideriamo m = 10 e A = tridiag (4, −2, −2) ∈ R10×10

m = 10;
A = mdiag([4, -2, -2], m);

%% 1.
% Con riferimento al sistema di Equazioni Differenziali Ordinarie, si
% riporti la definizione di zero-stabilità in relazione al metodo di Eulero in avanti. Si
% definisca tutta la notazione utilizzata.

%% 2.
% Si pongano ora tf = 10, g(t) = cos(π t) 1 e y0 = 7 per il problema (1).
% Si approssimi tale problema tramite il metodo di Eulero in avanti con passo di
% discretizzazione h = 0.1.
% Dopo aver indicato i tempi discreti tn = n h per n = 0, 1, . . . , Nh e h = tf/Nh, si
% riportino:
% • i valori delle approssimazioni u3,1 e u3,Nh rispettivamente di (y(t1))3 e
%   (y(tf))3;
% • il valore minimo u3,min = min n=0,...,Nh u3,n e il tempo discreto
%   t3,min = argmin n=0,...,Nh u3,n corrispondente a u3,min.

tf = 10;
g  = @(t) cos(pi*t) * ones(m, 1);
y0 = 7 * ones(m, 1);

P = @(t, y) A*y + g(t);

h = 0.1;

Nh = tf / h;

[t_h, u_h] = eulerfwd_systems(P, [0 tf], y0, Nh);

u3_1  = u_h(3, 1+1);
u3_Nh = u_h(3, end);

[u3min, u3min_idx] = min(u_h(3, :));
t3min = t_h(u3min_idx);

disp('u3_1:');
disp(u3_1);
disp('u3_Nh:');
disp(u3_Nh);
disp('u3min:');
disp(u3min);
disp('t3min:');
disp(t3min);

% u3,1 = 7.1000, u3,Nh = 0.3117, u3,min = −1.9806, t3,min = 1.0

%% 3.
% Assumendo che la soluzione esatta al tempo tf = 10 del problema nella componente 3 sia
% y3(tf ) = (y(10))3 = 0.269540864495346,
% si calcolino gli errori Eh = |u3,Nh − y3(tf )| ottenuti con il metodo di Eulero in
% avanti e corrispondenti ai passi h1 = 0.05, h2 = 0.025, h3 = 0.0125 e h4 = 0.00625.
% Si riportino i valori Ehi per i = 1, . . . , 4 e i principali comandi Matlabr usati.

sol3 = 0.269540864495346;

h_values = [0.05, 0.025, 0.0125, 0.00625];
err_values = zeros(1, length(h_values));

for h = h_values
    Nh = tf / h;
    [t_h, u_h] = eulerfwd_systems(P, [0 tf], y0, Nh);
    err = abs(u_h(3, end) - sol3);
    err_values(h == h_values) = err;
end

disp('err_values:');
disp(err_values);

% err_values:
%     0.0122    0.0055    0.0026    0.0013

%% 4.
% Si utilizzino gli errori ottenuti al Punto per stimare algebricamente l’ordine
% di convergenza p del metodo di Eulero in avanti. Si giustifichi la risposta data e la
% si motivi alla luce della teoria. Si riportino i principali comandi Matlabr usati.

E1 = err_values(end-1);
E2 = err_values(end);
h1 = h_values(end-1);
h2 = h_values(end);

p = log10(E2 / E1) / log10(h2 / h1);

disp('p:');
disp(p); % 1.0385

%% 5.
% Per il problema con tf = +∞ e g = 0 si ricavi la condizione di assoluta stabilità
% per il metodo di Eulero in avanti. Si illustri la procedura seguita, anche riportando
% i comandi Matlab usati.

R = stability_function("eulerfwd");
hmax = linear_abs_stability(A, R);

disp('hmax:');
disp(hmax); % 0.1195

%% 6.
% Si vuole ora approssimare il sistema di Equazioni Differenziali Ordinarie con i
% dati di cui al Punto 2) tramite il metodo di Eulero all’indietro con passo h = 0.1.
% Si riportino i valori delle approssimazioni u3,1 di (y(t1))3 e u3,2 di (y(t2))3 cos`ı
% ottenute.

h  = 0.1;
Nh = tf / h;

[~, u] = eulerbkw_systems(P, [0 tf], y0, Nh);

u3_1 = u(3, 1+1);
u3_2 = u(3, 2+1);

disp('u3_1:');
disp(u3_1);
disp('u3_2:');
disp(u3_2);

% u3_1: 6.8699 u3_2: 6.4389

%% 7.
% Si vuole ora applicare al sistema di Equazioni Differenziali Ordinarie nella forma (1)
% il metodo di Runge-Kutta associato alla seguente tabella di Butcher
% 1/4 1/4 0
% 3/4 1/2 1/4
% 0   1/2 1/2
% Si implementi il metodo precedente e lo si utilizzi per risolvere il sistema
% di Equazioni Differenziali Ordinarie con i dati di cui al Punto 2) usando il passo
% h = 0.1. Si riportino i valori delle approssimazioni u3,1 e u3,Nh così ottenute.

B = [
    1/4 1/4 0;
    3/4 1/2 1/4;
    0   1/2 1/2
    ];

[t, u] = rk_implicit(P, B, [0 tf], y0, h);

u3_1 = u(3, 1+1);
u3_Nh = u(3, end);

disp('u3_1:');
disp(u3_1);
disp('u3_Nh:');
disp(u3_Nh);

% u3_1:
%     7.0306
% u3_Nh:
%     0.2696