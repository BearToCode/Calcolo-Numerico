function f = dft(nodes, values)
%% DFT: Interpolante di Fourier discreta
% nodes: nodi di interpolazione
% values: valori della funzione nei nodi
syms x;
n = length(nodes) - 1;
f = 0;
for k = -M(n)-mu(n):M(n)+mu(n)
    f = f + C_k_tilde(k, nodes, values) * exp(1i * k * x);
end
end

function v = C_k_tilde(k, nodes, values)
n = length(nodes) - 1;
if n == M(n) + 1 || n == -M(n) - 1
    v = C_k(k, nodes, values) / 2;
else
    v = C_k(k, nodes, values);
end
end

function v = C_k(k, nodes, values)
n = length(nodes) - 1;
v = 0;
for j = 1:n+1
    v = v + values(j) * exp(-1i * k * (j-1) * h(n));
end
v = v * 1/(n+1);
end

function v = mu(n)
if mod(n, 2) == 0
    v = 0;
else
    v = 1;
end
end

function v = M(n)
if mod(n, 2) == 0
    v = n/2;
else
    v = (n-1)/2;
end
end

function v = h(n)
v = 2 * pi / (n+1);
end