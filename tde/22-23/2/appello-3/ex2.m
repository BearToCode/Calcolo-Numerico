clear; clc;

% Siano date le n+1 = 5 coppie di dati {(0, 4), (0.25, −0.25), (0.5, 2.5), (0.75, −0.15), (1, 3)}.
% Qual è il valore minimo assunto dall’interpolante polinomiale lineare a tratti ΠH1 (x)
% dei dati precedenti per x ∈ [0, 1]?

nodes = [0 0.25 0.5 0.75 1];
values = [4 -0.25 2.5 -0.15 3];

v = min(values);

disp(v); % -0.25