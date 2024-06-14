clear; clc;

% Siano date le coppie di dati {(xi, yi)}n i=0 con n = 9, generate dai comandi
% rng(’default’); xi = linspace(0,1,10)’; yi = exp(xi/5) + 0.5.*randn(10,1);
% Quanto vale la previsione della risposta y(x) per x = 1.1 ottenuta mediante ap-
% prossimazione nel senso dei minimi quadrati, con un polinomio di grado m = 3?

rng('default');
xi = linspace(0,1,10)';
yi = exp(xi/5) + 0.5.*randn(10,1);

poly = polyfit(xi, yi, 3);

x = 1.1;
y = polyval(poly, x);

disp(y); % 3.8942