function I = simpcomp(a, b, N, fun)
% SIMPCOMP: Quadratura di Simpson composita su intervalli equispaziati
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

x = a:h:b;

I = 0;

for i=1:N
    I = I + simple(x(i), x(i+1), fun);
end

end

function I = simple(a, b, fun)
I = (b - a) / 6 * (fun(a) + 4 * fun((a + b) / 2) + fun(b));
end