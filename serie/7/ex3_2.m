clear; clc;

% Problema di Keplero

% r''(t) = -4 pi^2 r(t) / |r(t)|^3
% r(0)   = r0
% r'(0)  = v0


% y(t) = [rx(t) vx(t) ry(t) vy(t)] => ordine 4

% y'(t) = f(t, y)
% y(0) = y0

% f(t, y) = [y2(t) -4*pi^2*y1(t)/norm(r(t))^3 y4(t) -4*pi^2*y3(t)/norm(r(t))^3]
% y0 = [rx(0) vx(0) ry(0) vy(0)]

% 2. Posti r0 = (1, 0)T e v0 = (0, −5.1)T , si risolva il problema nell’intervallo di tempo (0, 5)
% usando opportunamente la function ode45 di Matlab® . Si rappresentino l’andamento
% della posizione r(t) approssimata vs. t e l’orbita del pianeta nel piano. Si usi la fun-
% zione come segue [t, u] = ode45( ..., options ); avendo assegnato in precedenza
% options = odeset('reltol',1e−6);.

rx0 = 1;
vx0 = 0;
ry0 = 0;
vy0 = -5.1;

y0 = [rx0 vx0 ry0 vy0]';
t0 = 0;
tf = 5;
tv = [t0 tf];

options = odeset('reltol', 1e-6);
[t, u] = ode45(@twobody, tv, y0, options);

rx = u(:, 1);
ry = u(:, 3);

vx = u(:, 2);
vy = u(:, 4);

% Orbita
figure;
plot(rx, ry, 'LineWidth', 2);
title('Orbita del pianeta');
xlabel('rx(t)');
ylabel('ry(t)');
grid on;
hold on;
% Fuoco in (0, 0)
plot(0, 0, 'ro', 'MarkerSize', 10);
hold off;

% Posizione approssimata
figure;
plot(t, rx, t, ry, 'LineWidth', 2);
title('Posizione approssimata vs t');
legend('rx(t)', 'ry(t)');
grid on;

% 3. Risoluzione usando eulerfwd_systems (metodo di eulero in avanti per sistemi)
% per valori del passo h = 10^−5 (Nh= 5·10^5); si rappresenti
% la soluzione numerica ottenuta. Si ripeta per h = 10^−3 e si commenti il risultato
% ottenuto.

h = 1e-5;
Nh = round((tf - t0) / h);
[t, u] = eulerfwd_systems(@twobody, tv, y0, Nh);

rx = u(1, :);
ry = u(3, :);

figure;
plot(t, rx, t, ry, 'LineWidth', 2);
title('Posizione approssimata vs t (Eulero in avanti) h = 1e-5');
legend('rx(t)', 'ry(t)');
grid on;

h = 1e-3;
Nh = round((tf - t0) / h);
[t, u] = eulerfwd_systems(@twobody, tv, y0, Nh);

rx = u(1, :);
ry = u(3, :);

figure;
plot(t, rx, t, ry, 'LineWidth', 2);
title('Posizione approssimata vs t (Eulero in avanti) h = 1e-3');
legend('rx(t)', 'ry(t)');
grid on;

% Orbita
figure;
plot(rx, ry, 'LineWidth', 2);
title('Orbita del pianeta (Eulero in avanti) h = 1e-3');
xlabel('rx(t)');
ylabel('ry(t)');
grid on;
hold on;
% Fuoco in (0, 0)
plot(0, 0, 'ro', 'MarkerSize', 10);



function fn = twobody(~, y)
r = [y(1) y(3)]';

[n,m] = size(y);
fn = zeros(n,m);

fn(1) = y(2);
fn(2) = -4*pi^2*r(1)/norm(r)^3;
fn(3) = y(4);
fn(4) = -4*pi^2*r(2)/norm(r)^3;
end