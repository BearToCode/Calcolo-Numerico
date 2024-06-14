clear; clc;

% Siano date le coppie di dati {(xi, yi)}n i=0
% con n = 7, generate dai seguenti comandi

rng('default'); xi = linspace(0,1,8)';
yi = xi .* (xi+3) .* (xi-2) + 0.25 * randn(8,1);

% Quanto vale la previsione della risposta y(x) per x = 1.1 ottenuta mediante ap-
% prossimazione nel senso dei minimi quadrati dei dati con un polinomio di grado
% m = 3?

n = 7;
poly = polyfit(xi, yi, 3);
x = 1.1;

y = polyval(poly, x);

disp(y); % -3.8544