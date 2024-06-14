% Siano date le n+1 = 5 coppie di dati {(0, 1), (0.25, 0.5), (0.5, 1.5), (0.75, −0.25), (1, 1)}.
% Qual è valore massimo dell’interpolante polinomiale lineare a tratti ΠH1 (x) dei dati
% precedenti per x ∈ [0, 1]?

nodes = [0, 0.25, 0.5, 0.75, 1];
values = [1, 0.5, 1.5, -0.25, 1];

m = max(values);

disp(m);