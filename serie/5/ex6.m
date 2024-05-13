clear; clc;

T = 1;
dt = 0.1;
y0 = 10;

t = 0:dt:T;
yS = [ 10.0 9.89 9.75 9.66 9.10 8.95 8.10 7.49 6.80 6.13 5.05 ];

%% 1. Si rappresentino sullo stesso grafico i dati sperimentali e la legge di moto ideale (in linea
% continua) data da:
% y = y0 − 1/2*g*t^2, g = 9.81 m/s2.

g = 9.81;

t_values = linspace(0, T, 100);
y_values = y0 - 1/2 * g * t_values.^2;

figure;
plot(t_values, y_values, 'DisplayName', 'y(t) = y_0 - 1/2 g t^2', 'LineWidth', 2);
hold on;
plot(t, yS, 'o', 'DisplayName', 'y_S(t)');
legend;

%% 2. A partire dai dati sperimentali disponibili si determinino:
% • il polinomio interpolante di Lagrange;
% • l’interpolante composita lineare;
% • l’approssimante polinomiale di grado 2, nel senso dei minimi quadrati.
% Si confrontino graficamente le approssimazioni, (sull’intervallo [0, 1]), con l’andamento
% previsto dalla legge ideale. Si faccia inoltre un confronto grafico della distribuzione
% dell’errore commesso da ogni interpolante e approssimazione e si valuti anche l’errore
% in norma infinito.

% Lagrange
poly_lagrange = polyfit(t, yS, length(t) - 1);
lagrange_values = polyval(poly_lagrange, t_values);

% Interpolante composita lineare
lin_values = interp1(t, yS, t_values, 'linear');

% Approssimante polinomiale di grado 2
poly2 = polyfit(t, yS, 2);
poly2_values = polyval(poly2, t_values);

% Grafico
figure;
plot(t_values, y_values, 'DisplayName', 'y(t) = y_0 - 1/2 g t^2', 'LineWidth', 2);
hold on;
plot(t, yS, 'o', 'DisplayName', 'y_S(t)');
plot(t_values, lagrange_values, 'DisplayName', 'Lagrange', 'LineWidth', 2);
plot(t_values, lin_values, 'DisplayName', 'Interpolante composita lineare', 'LineWidth', 2);
plot(t_values, poly2_values, 'DisplayName', 'Approssimante polinomiale di grado 2', 'LineWidth', 2);

% Errori

% Lagrange
error_lagrange = abs(y_values - polyval(poly_lagrange, t_values));

% Interpolante composita lineare
error_lin = abs(y_values - interp1(t, yS, t_values, 'linear'));

% Approssimante polinomiale di grado 2
error_poly2 = abs(y_values - polyval(poly2, t_values));

figure;
plot(t_values, error_lagrange, 'DisplayName', 'Errore Lagrange', 'LineWidth', 2);
hold on;
plot(t_values, error_lin, 'DisplayName', 'Errore Interpolante composita lineare', 'LineWidth', 2);
plot(t_values, error_poly2, 'DisplayName', 'Errore Approssimante polinomiale di grado 2', 'LineWidth', 2);


% Norma infinito
norm_inf_lagrange = max(abs(error_lagrange));
norm_inf_lin = max(abs(error_lin));
norm_inf_poly2 = max(abs(error_poly2));

fprintf('Norma infinito errore Lagrange: %f\n', norm_inf_lagrange);
fprintf('Norma infinito errore Interpolante composita lineare: %f\n', norm_inf_lin);
fprintf('Norma infinito errore Approssimante polinomiale di grado 2: %f\n', norm_inf_poly2);

%% 3. Si stimi l’altezza raggiunta dal grave al tempo t = 1.05 s sulla base dei dati sperimen-
% tali: in particolare si confrontino le stime ottenute dall’interpolazione polinomiale di
% Lagrange e dal polinomio approssimante nel senso dei minimi quadrati (di grado 2) con
% il risultato fornito dalle legge ideale. Si commenti il risultato ottenuto.

t_new = 1.05;

y_lagrange = polyval(poly_lagrange, t_new);
y_poly2 = polyval(poly2, t_new);
y_ideal = y0 - 1/2 * g * t_new^2;

fprintf('y_Lagrange(1.05) = %f\n', y_lagrange);
fprintf('y_Approssimante_polinomiale_di_grado_2(1.05) = %f\n', y_poly2);
fprintf('y_Ideale(1.05) = %f\n', y_ideal);