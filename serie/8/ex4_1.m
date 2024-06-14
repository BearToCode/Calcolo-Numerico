clear; clc;

domain = [0 1; 0 1];
mu     = 1;
f      = @(x,y) 5 * pi^2 * sin(pi * x) * sin(2 * pi * y);
g      = @(x,y) 0;

u_exact = @(x,y) sin(pi * x) .* sin(2 * pi * y);

%% 2. Si rappresenti la soluzione esatta attraverso il comando surf, su una griglia con h = hx = hy = 1/10.

hx = 1/10;
hy = 1/10;

x = domain(1,1):hx:domain(1,2);
y = domain(2,1):hy:domain(2,2);

[X, Y] = meshgrid(x, y);

Z = u_exact(X, Y);

figure;
surf(X, Y, Z, 'EdgeColor', 'none');
title('Soluzione esatta');
xlabel('x');
ylabel('y');
zlabel('u(x, y)');

%% 3. Si rappresenti la soluzione approssimata ottenuta.

[X, Y, U] = Poisson_Dirichlet_diff_finite_5punti(mu, f, g, domain, hx, hy);

figure;
surf(X, Y, U, 'EdgeColor', 'none');
title('Soluzione approssimata');
xlabel('x');
ylabel('y');
zlabel('u(x, y)');

% DA FINIRE