clc; clear;

a  = 0;
b  = 1;
T  = 1;
mu = 1;

f = @(x,t) (-sin(t) + 1/4 * cos(t)) .* sin(x/2);

us = @(t) 0;
ud = @(t) sin(1/2) * cos(t);
g0 = @(x) sin(x/2);

u_ex = @(x,t) sin(x/2) .* cos(t);

%% 2. Eulero implicito

theta   = 1;
h       = 0.01;
delta_t = 0.1;

[u, x, ~] = EqCalore_DiffFin_Theta(mu, f, a, b, us, ud, g0, T, h, delta_t, theta);

% Plot al tempo iniziale
figure(1);
plot(x, u(:,1), 'r', x, u_ex(x,0), 'b');
title('Soluzione al tempo iniziale');
legend('Soluzione numerica', 'Soluzione esatta');

% Plot al tempo finale
figure(2);
plot(x, u(:,end), 'r', x, u_ex(x,T), 'b');
title('Soluzione al tempo finale');
legend('Soluzione numerica', 'Soluzione esatta');

%% 3. Euler esplicito

theta   = 0;

% delta_t < h^2 / 2mu per assoluta stabilità

% Caso 1

h       = 0.01;
delta_t = 0.1;

[u, x, ~] = EqCalore_DiffFin_Theta(mu, f, a, b, us, ud, g0, T, h, delta_t, theta);

% Plot al tempo finale
figure(4);
plot(x, u(:,end), 'r', x, u_ex(x,T), 'b');
title('Soluzione al tempo finale');
legend('Soluzione numerica', 'Soluzione esatta');

% Caso 2

h       = 0.1;
delta_t = 0.001;

[u, x, ~] = EqCalore_DiffFin_Theta(mu, f, a, b, us, ud, g0, T, h, delta_t, theta);

% Plot al tempo finale
figure(4);
plot(x, u(:,end), 'r', x, u_ex(x,T), 'b');
title('Soluzione al tempo finale');
legend('Soluzione numerica', 'Soluzione esatta');

%% 4. Indicando con eT = maxi=0,...,N +1 |uex(xi, T ) − ui(T )| l%errore di discretizzazione al
% tempo finale T , studiare l’andamento di eT al variare di ∆t per i metodi di Eulero
% implicito, Eulero esplicito, Crank-Nicolson (θ = 1/2), usando come parametri
% • h = 0.1, ∆t = 0.1, 0.05, 0.025, 0.0125, 0.00625, 0.003125 per Eulero implicito e
% Crank-Nicolson;
% • h = 0.1, ∆t = 0.001, 0.005, 0.00025, 0.000125, 0.00003125 per Eulero esplicito.

h = 0.1;
delta_t = [0.1, 0.05, 0.025, 0.0125, 0.00625, 0.003125];
err_ei = zeros(1, length(delta_t));
err_cn = zeros(1, length(delta_t));

for i = 1:length(delta_t)
    [u, x, ~] = EqCalore_DiffFin_Theta(mu, f, a, b, us, ud, g0, T, h, delta_t(i), 1);
    u_ex_t = u_ex(x', T);
    err_ei(i) = max(abs(u_ex_t - u(:,end)));
    
    [u, x, ~] = EqCalore_DiffFin_Theta(mu, f, a, b, us, ud, g0, T, h, delta_t(i), 0.5);
    u_ex_t = u_ex(x', T);
    err_cn(i) = max(abs(u_ex_t - u(:,end)));
end

figure(5);
loglog(delta_t, err_ei, 'r', delta_t, err_cn, 'b');
title('Errore di discretizzazione al tempo finale');
hold on;
loglog(delta_t, delta_t, '--');
loglog(delta_t, delta_t .^ 2, '--');
hold off;
legend('Eulero implicito', 'Crank-Nicolson', 'O(\Delta t)', 'O(\Delta t^2)');
xlabel('\Delta t');
ylabel('e_T');

h = 0.1;
delta_t = [0.001, 0.0005, 0.00025, 0.000125, 0.00003125];
err_ee = zeros(1, length(delta_t));

for i = 1:length(delta_t)
    [u, x, ~] = EqCalore_DiffFin_Theta(mu, f, a, b, us, ud, g0, T, h, delta_t(i), 0);
    u_ex_t = u_ex(x, T);
    err_ee(i) = max(abs(u_ex_t' - u(:,end)));
end

figure(6);
loglog(delta_t, err_ee, 'r');
title('Errore di discretizzazione al tempo finale');
hold on;
loglog(delta_t, delta_t, '--');
loglog(delta_t, delta_t .^ 2, '--');
hold off;
legend('Eulero esplicito', 'O(\Delta t)', 'O(\Delta t^2)');
xlabel('\Delta t');
ylabel('e_T');