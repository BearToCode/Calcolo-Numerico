% Dati i nodi x0 = 0, x1 = 1/2 e x2 = 2, sia ϕ0(x) la funzione caratteristica
% di Lagrange associata al nodo x0. Quanto vale l’approssimazione dell’integrale
% ∫ [x0,x2] ϕ0(x) dx ottenuta con il metodo di Simpson?

nodes = [0, 1/2, 2];
phi0 = matlabFunction(lphi(nodes, 1));

a = 0;
b = 2;

I = simpcomp(a, b, 1, phi0);

disp(I);

% Funzione caratteristica di Lagrange
function phi = lphi(nodes, k)
syms x;
phi = 1;
for i = 1:length(nodes)
    if i ~= k
        phi = phi * (x - nodes(i)) / (nodes(k) - nodes(i));
    end
end
end