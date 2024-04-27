function nodes = chebyshev(interval, n)
%% CHEBYSHEV Nodi di Chebyshev
% interval: intervallo di interpolazione
% n: numero di nodi
a = interval(1);
b = interval(2);
nodes = arrayfun(@(i) (b+a)/2 + (b-a)/2 * (-cos(i*pi/n)), 0:n);
end