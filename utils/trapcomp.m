function I = trapcomp(a, b, N, fun)
% TRAPCOMP: Quadratura del trapezio composita su intervalli equispaziati
%
% Input:
% - a: estremo inferiore dell'intervallo
% - b: estremo superiore dell'intervallo
% - N: numero di sottointervalli
% - fun: funzione da integrare
%
% Output:
% - I: approssimazione dell'integrale

h = (b - a) / N;

I = h/2 * (fun(a) + fun(b)) + h * sum(arrayfun(fun, a+h:h:b-h));
end