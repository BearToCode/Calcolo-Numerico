clear; clc;

lambda = -42;
y0 = 2;
t0 = 0;
t_max = 1;

t_plot = 0:0.001:t_max;

y_exact = @(t) y0 * exp(lambda * (t - t0));

f = @(t, y) lambda * y; % Problema modello
h = 0.05;
[t_h_fwd, u_h_fwd] = eulerfwd(f, t_max, y0, h);

%% Eulero in avanti => instabile

figure;
hold on;
plot(t_h_fwd, u_h_fwd);
plot(t_plot, y_exact(t_plot), '--');
legend('Eulero in avanti', 'Soluzione esatta');
xlabel('t');
ylabel('y(t)');
title('Eulero in avanti');
hold off;

%% Eulero all'indietro => stabile

df_du = @(t, u) lambda;
[t_h_bkw, u_h_bkw, ~] = eulero_indietro_newton(f, df_du, t_max, y0, h);

figure;
hold on;
plot(t_h_bkw, u_h_bkw);
plot(t_plot, y_exact(t_plot), '--');
legend('Eulero all''indietro', 'Soluzione esatta');
xlabel('t');
ylabel('y(t)');
title('Eulero all''indietro');
hold off;

%% 3. Ripetere la stessa analisi del punto precedente usando h = 0.01

h = 0.01;
[t_h_fwd, u_h_fwd] = eulerfwd(f, t_max, y0, h);
[t_h_bkw, u_h_bkw, ~] = eulerbkw_newton(f, df_du, t_max, y0, h);

figure;
hold on;
plot(t_h_fwd, u_h_fwd);
plot(t_plot, y_exact(t_plot), '--');
legend('Eulero in avanti', 'Soluzione esatta');
xlabel('t');
ylabel('y(t)');
title('Eulero in avanti (h = 0.01)');
hold off;

figure;
hold on;
plot(t_h_bkw, u_h_bkw);
plot(t_plot, y_exact(t_plot), '--');
legend('Eulero all''indietro', 'Soluzione esatta');
xlabel('t');
ylabel('y(t)');
title('Eulero all''indietro (h = 0.01)');
hold off;


%% (a) Calcolare la soluzione numerica del problema utilizzando il metodo di Eulero in
% avanti con i seguenti dati: tmax = 1, e h = 0.05. Visualizzare sullo stesso grafico la
% soluzione esatta e la soluzione numerica. Ripetere la stessa procedura utilizzando il
% metodo di Eulero all’indietro con metodo di punto fisso per la soluzione dell’equa-
% zione non lineare di avanzamento temporale (funzione eulero indietro pto fisso).
% Cosa si osserva? Valutare se il valore λh appartiene alla regione di assoluta stabilità
% dei due metodi.

t_max = 1;
h = 0.05;

[t_h_fwd, u_h_fwd] = eulerfwd(f, t_max, y0, h);
[t_h_bkw, u_h_bkw, ~] = eulerbkw_fixedpt(f, t_max, y0, h);

fprintf("Eulero in avanti\n");
fprintf('λh = %f\n', lambda * h);

figure;
hold on;
plot(t_h_fwd, u_h_fwd);
plot(t_plot, y_exact(t_plot), '--');
legend('Eulero in avanti', 'Soluzione esatta');
xlabel('t');
ylabel('y(t)');
title('Eulero in avanti');
hold off;

fprintf("Eulero all'indietro\n");
fprintf('λh = %f\n', lambda * h);

figure;
hold on;
plot(t_h_bkw, u_h_bkw);
plot(t_plot, y_exact(t_plot), '--');
legend("Eulero all'indietro", 'Soluzione esatta');
xlabel('t');
ylabel('y(t)');
title("Eulero all'indietro cont punto fisso");
hold off;

%% (b) Ripetere la stessa analisi del punto precedente usando prima h = 0.03 e poi h = 0.01

h = 0.03;

[t_h_fwd, u_h_fwd] = eulerfwd(f, t_max, y0, h);
[t_h_bkw, u_h_bkw, ~] = eulerbkw_fixedpt(f, t_max, y0, h);

fprintf("h = 0.03\n");

fprintf("Eulero in avanti\n");
fprintf('λh = %f\n', lambda * h);

figure;
hold on;
plot(t_h_fwd, u_h_fwd);
plot(t_plot, y_exact(t_plot), '--');
legend('Eulero in avanti', 'Soluzione esatta');
xlabel('t');
ylabel('y(t)');
title('Eulero in avanti');
hold off;

fprintf("Eulero all'indietro\n");
fprintf('λh = %f\n', lambda * h);

figure;
hold on;
plot(t_h_bkw, u_h_bkw);
plot(t_plot, y_exact(t_plot), '--');
legend("Eulero all'indietro", 'Soluzione esatta');
xlabel('t');
ylabel('y(t)');
title("Eulero all'indietro cont punto fisso");
hold off;

h = 0.01;

[t_h_fwd, u_h_fwd] = eulerfwd(f, t_max, y0, h);
[t_h_bkw, u_h_bkw, ~] = eulerbkw_fixedpt(f, t_max, y0, h);

fprintf("h = 0.01\n");

fprintf("Eulero in avanti\n");
fprintf('λh = %f\n', lambda * h);

figure;
hold on;
plot(t_h_fwd, u_h_fwd);
plot(t_plot, y_exact(t_plot), '--');
legend('Eulero in avanti', 'Soluzione esatta');
xlabel('t');
ylabel('y(t)');
title('Eulero in avanti');
hold off;

fprintf("Eulero all'indietro\n");
fprintf('λh = %f\n', lambda * h);

figure;
hold on;
plot(t_h_bkw, u_h_bkw);
plot(t_plot, y_exact(t_plot), '--');
legend("Eulero all'indietro", 'Soluzione esatta');
xlabel('t');
ylabel('y(t)');
title("Eulero all'indietro cont punto fisso");
hold off;

