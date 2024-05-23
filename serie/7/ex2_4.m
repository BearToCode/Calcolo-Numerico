clear; clc;

%% 2. Utilizzando la function appena scritta, risolvere il problema (3) con il metodo di Crank-
% Nicolson, scegliendo λ = −42, tmax = 1, y0 = 2 per il valore del passo h = 0.02.

lambda = -42;
t_max  = 1;
y0     = 2;
t0     = 0;

y_exact = @(t) y0 * exp(lambda * (t - t0));

f = @(t, y) lambda * y;
h = 0.02;

[t_h_cn, u_h_cn, iter_pf_cn] = crank_nicolson(f, t_max, y0, h);

% Plot

t_plot = 0:0.001:t_max;

figure;
hold on;
plot(t_h_cn, u_h_cn);
plot(t_plot, y_exact(t_plot), '--');
legend('Crank-Nicolson', 'Soluzione esatta');
xlabel('t');
ylabel('y(t)');
title('Crank-Nicolson');

%% 3. Riportare su un grafico il numero di iterazioni impiegate dal metodo di punto fisso per
% risolvere l’equazione non lineare ad ogni passo temporale del metodo

figure;
plot(t_h_cn, iter_pf_cn, 'o:');
xlabel('t');
ylabel('Iterazioni');
title('Iterazioni metodo di punto fisso');

%% 5. Utilizzando la function appena scritta, risolvere il problema con il metodo di Heun

[t_h_heun, u_h_heun] = heun(f, t_max, y0, h);

% Plot

figure;
hold on;
plot(t_h_heun, u_h_heun);
plot(t_plot, y_exact(t_plot), '--');
legend('Heun', 'Soluzione esatta');
xlabel('t');
ylabel('y(t)');
title('Heun');
hold off;

%% 6. Riportare su un grafico l’errore assoluto commesso dai metodi di Crank-Nicolson e Heun
% in scala logaritmica su i seguenti valori di h

h_values = 0.04./2.^(0:4);

errors_cn = zeros(size(h_values));
errors_heun = zeros(size(h_values));
errors_rk4 = zeros(size(h_values));

for i = 1:length(h_values)
    h = h_values(i);
    
    [t_h_cn, u_h_cn, ~] = crank_nicolson(f, t_max, y0, h);
    [t_h_heun, u_h_heun] = heun(f, t_max, y0, h);
    [t_h_rk4, u_h_rk4] = rk4(f, t_max, y0, h);
    
    y_exact_values = y_exact(t_h_cn);
    
    errors_cn(i) = norm(u_h_cn - y_exact_values, Inf);
    errors_heun(i) = norm(u_h_heun - y_exact_values, Inf);
    errors_rk4(i) = norm(u_h_rk4 - y_exact_values, Inf);
end

figure;
loglog(h_values, errors_cn, 'o-');
hold on;
loglog(h_values, errors_heun, 'o-');
loglog(h_values, errors_rk4, 'o-');
loglog(h_values, h_values, '--');
loglog(h_values, h_values.^2, '--');
loglog(h_values, h_values.^4, '--');
legend('Crank-Nicolson', 'Heun', 'RK4');
xlabel('h');
ylabel('Errore assoluto');
title('Errore assoluto in scala logaritmica');
hold off;