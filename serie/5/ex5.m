clc; clear;

syms x;
symf = exp(-x^2) * sin(x);

f = matlabFunction(symf);

a = -2;
b = 3;

% 1. Si calcoli il polinomio interpolante composito lineare ΠH_1 f (x)
% su n = 3 sottointervalli di uguale ampiezza H = (b − a)/n,
% si utilizzi la funzione interp1, e se ne disegni il grafico
% insieme a quello della funzione f (x).

n = 3;
H = (b - a) / n;

x_nodes = a:H:b;
y_nodes = arrayfun(f, x_nodes);

x_values = linspace(a, b, 100);
y_values = arrayfun(f, x_values);

y_values_lin = interp1(x_nodes, y_nodes, x_values, 'linear');

figure;
plot(x_values, y_values, 'DisplayName', 'f(x)');
hold on;
plot(x_values, y_values_lin, 'DisplayName', 'ΠH_1 f(x)', 'LineWidth', 3);
legend;

%% 2. Si calcoli l’errore in norma infinito e_H = max x∈[a,b] |f (x) − ΠH_1 f (x)|

e_H = max(abs(y_values - y_values_lin));
fprintf('Errore in norma infinito: %f\n', e_H);

%% 3. Si calcoli ora il polinomio interpolante composito lineare ΠH_1 f su n = 4, 8, 16, 32, 64, 128
% sottointervalli di uguale ampiezza. Si valuti l’errore in norma infinito e_H in ciascun
% caso e se ne visualizzi l’andamento in funzione di H su un grafico in scala logaritmica
% su entrambi gli assi. Verificare graficamente che ci sia accordo con la stima teorica
% dell’errore:
% e_H ≤ H^2/8 max x∈[a,b] |f ′′(x)|

n_values = [4, 8, 16, 32, 64, 128];
err_values = zeros(size(n_values));

d2f = matlabFunction(diff(symf, x, 2));

err_approx = @(H) H^2 / 8 * max(abs(arrayfun(d2f, x_values)));

for i = 1:length(n_values)
    n = n_values(i);
    H = (b - a) / n;
    
    x_nodes = a:H:b;
    y_nodes = arrayfun(f, x_nodes);
    
    x_values = linspace(a, b, 100);
    y_values = arrayfun(f, x_values);
    
    y_values_lin = interp1(x_nodes, y_nodes, x_values, 'linear');
    
    e_H = max(abs(y_values - y_values_lin));
    err_values(i) = e_H;
end

figure;
H_values = (b - a) ./ n_values;
loglog(H_values, err_values, 'o-', 'LineWidth', 2);
xlabel('H');
ylabel('e_H');
title('Errore in norma infinito in funzione di H');
grid on;
hold on;

H_values = linspace(0.01, 0.7, 100);
err_approx_values = arrayfun(err_approx, H_values);

plot(H_values, err_approx_values, 'LineWidth', 2);
legend('Errore in norma infinito', 'Stima teorica');