% Il metodo di Heron consente di approssimare √5 applicando il seguente algoritmo:
% dato x0, porre xn+1 = xn + 5/xn
% 2 per n = 0, 1, 2 . . .; si ottiene lim
% n→+∞ xn = √5.
% Quante operazioni elementari vengono effettuate per ottenere x50?

function x = heron(x0, n)
    if n == 0
        x = x0;
    else
        prev = heron(x0, n-1);
        x = prev + 5/prev;
    end
end

% Ogni iterazione richiede 3 operazioni elementari (somma e due divisioni)
% Quindi per ottenere x50 vengono effettuate 3*50 = 150 operazioni elementari