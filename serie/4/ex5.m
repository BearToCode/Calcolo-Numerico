clc; clear;

syms x1 x2;

sym_phi = 3*x1^2 + x2^2 - x1/4 - x2/6 + exp(-2*x1*x2);
phi_min = [0.099299729019640; 0.179161952163217];

sym_f = gradient(sym_phi);
phi = matlabFunction(sym_phi);

%% 1. Si scriva il problema di minimo e il sistema di equazioni non lineari corrispondente alla
% ricerca dello zero α del gradiente di Φ. Si rappresentino le curve di livello di Φ in
% Matlab per x1 ∈ [−0.15, 0.25] e x2 ∈ [−0.05, 0.35].

x1 = -0.15:0.001:0.25;
x2 = -0.05:0.001:0.35;

[X1, X2] = meshgrid(x1, x2);
Z = phi(X1, X2);

figure;
contour(X1, X2, Z, 100);
hold on
grid on
plot(phi_min(1), phi_min(2), 'rx');
xlabel('$x_1$', 'Interpreter', 'latex');
ylabel('$x_2$', 'Interpreter', 'latex');
title('Curve di livello di Φ');


%% 2. Si risolva il problema di approssimazione dello zero formulato al punto 1 tramite il
% metodo di Newton. Si applichino 5 iterazioni del metodo a partire dall’iterata iniziale
% x(0) = (−0.14, 0.14)T e si rappresenti graficamente la convergenza del metodo ad α.

x0 = [-0.14;0.14];
nmax = 5;
[sol, it, xvect] = symnewton(x0, nmax, 0, sym_f);

figure;
contour(X1, X2, Z, 100);
grid on

% Plot lines for xvect
colors = ['r', 'g', 'b', 'm', 'c', 'y', 'k'];
for i = 1:size(xvect, 1)-1
    hold on
    plot([xvect(i, 1), xvect(i+1, 1)], [xvect(i, 2), xvect(i+1, 2)], colors(mod(i, 7)+1));
end

plot(phi_min(1), phi_min(2), 'rx');

%% 3. Dopo aver risposto al punto 2, si stimi l’ordine di convergenza del metodo di Newton
% ad α.

err_v = zeros(size(xvect, 1), 1);

for i = 1:size(xvect, 1)
    err_v(i) = norm(xvect(i, :) - phi_min);
end

conv_order = err_v(2:end) ./ err_v(1:end-1); % Viene uno ma dovrebbe essere 2 :( FIXME
reduce_factor = err_v(2:end) ./ (err_v(1:end-1) .^ 2);
disp(conv_order)
disp(reduce_factor)