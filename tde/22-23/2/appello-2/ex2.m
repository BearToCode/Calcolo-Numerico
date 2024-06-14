clear; clc;

% Si consideri la funzione f (x) = e^sin(16x) − x2 sull’intervallo [0, 1] e si determini la
% spline cubica s3(x) (di tipo not-a-knot) interpolante tale funzione in n+1 = 11 nodi
% {xi}n i=0 equispaziati, con x0 = 0, x1 = 0.1, . . ., x10 = 1. Quanto vale il massimo di
% |s3(x)| sull’intervallo [0, 1]? Quanto vale l’errore commesso, max x∈[0,1] |f (x) − s3(x)| ?

f = @(x) exp(sin(16*x)) - x.^2;

a = 0;
b = 1;
n = 10;

nodes  = linspace(a, b, n + 1);
values = f(nodes);
query  = linspace(a, b, 1000);

query_values = spline(nodes, values, query);

max_val = max(abs(query_values));
err = max(abs(f(query) - query_values));

disp(max_val); % 2.8435
disp(err);     % 0.7774