function hmax = linear_abs_stability(A, R)
% LINEAR_ABS_STABILITY calcola il passo massimo per la stabilità assoluta
% di un metodo numerico per un sistema lineare, dove df(t, y(t))/dy = A;
%
% Per esempio f(t, y) = A*y + g(t)
%
% Input:
%  - A: matrice del sistema lineare
%  - R: funzione di stabilità assoluta

eigs = eig(A);
F = @(z) abs(R(z)) - 1;
hmax = inf;

for lambda = eigs'
    % Evita la soluzione banale 0
    % 100 * abs(lambda) è un valore arbitrario ragionevole
    interval = [1e-5, abs(lambda) * 100];
    if F(interval(2) * lambda) < 0
        continue; % Non c'è soluzione
    end
    
    h = fzero(@(h) F(h * lambda), interval);
    hmax = min(hmax, h);
end

end
