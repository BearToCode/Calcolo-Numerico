% Si consideri il seguente algoritmo: dato x0 ∈ R positivo, x_n+1 = (x_n + α/x_n) /2
% per n = 0, 1, . . . fornisce un’approssimazione di √α per n “grande”. Si calcoli
% l’approssimazione x10 di √107 utilizzando n = 10 passi dell’algoritmo partendo da
% x0 = 1 e si riporti il numero di operazioni necessarie per ottenerla.

x0 = 1;
alpha = 107;
n = 10;

x = recursive(alpha, x0, n);

function x = recursive(alpha, x0, n)
    if n == 0
        prev = x0;
    else
        prev = recursive(alpha, x0, n - 1);
    end
    
    x = (prev + alpha / prev) / 2;
end

% Operazioni = 3 * 10 = 30