function I = pmedcomp(a, b, N, fun)
% PMEDCOMP: Quadratura con formula del punto medio composita su intervalli equispaziati
%
% Input:
% - a: estremo inferiore
% - b: estremo superiore
% - N: numero di sottointervalli
% - fun: funzione da integrare
%
% Output:
% - I: approssimazione dell'integrale

h = (b - a) / N;

x = a+h/2:h:b-h/2;
I = h * sum(fun(x));

end