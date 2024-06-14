clear; clc;

% Siano date le 3 coppie di dati {(0, 2), (0.5, 1), (1, 1.5)}. Si costruisca il polinomio
% interpolante Π2(x) di tali dati e si riportino i valori di Π2(0.25) e dΠ2
% dx (0.25).

nodes = [0, 0.5, 1];
values = [2, 1, 1.5];

intpol = lagint(nodes, values);
dintpol = diff(intpol);

f = matlabFunction(intpol);
df = matlabFunction(dintpol);

x = 0.25;
val1 = f(x);
val2 = df(x);

disp(val1);
disp(val2);