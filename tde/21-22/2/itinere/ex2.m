clear; clc;

% Siano date le n+1 = 5 coppie di dati {(0, 3), (0.25, 0.5), (0.5, 1.5), (0.75, −0.5), (1, 1)}.
% Qual è valore minimo dell’interpolante polinomiale lineare a tratti ΠH1 (x) dei dati
% precedenti per x ∈ [0, 1]?

values = [3 0.5 1.5 -0.5 1];

m = min(values);

disp(m); % -0.5