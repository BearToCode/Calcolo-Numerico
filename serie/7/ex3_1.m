clear; clc;

% Sistema massa-molla-smorzatore

% x'' + gamma*x' + omega^2*x = 0
% y1 = x
% y2 = x'
% Il sistema diventa:

% y1' = y2
% y2' = -gamma*y2 - omega^2*y1
% y1(0) = y1_0
% y2(0) = y2_0


% Risolvere il problema nell’intervallo di tempo (0, 100) con le condizioni iniziali x(0) = 2,
% x′(0) = 0 usando la function ode45 built-in di Matlab. Verificare graficamente che
% la soluzione del problema è costituita da un’oscillazione armonica di frequenza ω1/2π
% con ω1 = sqrt(4ω^2 − γ^2/2) smorzata nel tempo

t0 = 0;
tf = 100;
tv = [t0 tf];

y0 = [2 0];

gamma = 0.1;
omega = 1;

[t, u] = ode45(@mms, tv, y0);

% Verifico oscillazione analitica

w1 = sqrt(omega^2 - gamma^2/4);
x = 2*exp(-gamma/2*t).*cos(w1*t);

figure;
plot(t, u(:,1), 'LineWidth', 2);
title('Sistema massa-molla-smorzatore');
xlabel('t');
ylabel('x(t)');
grid on;
hold on;
plot(t, x, 'r--', 'LineWidth', 2);
legend('Soluzione numerica', 'Soluzione analitica');
hold off;

% 3. Aggiungere al sistema la forzante esterna Fext(t) = m A0 sin(ωf t), con A0 = 0.5 e
% ωf = 0.5, ottenendo il seguente bilancio delle forze Fk + Fc + Fext = mx′′. Verificare
% graficamente che, a regime, la soluzione del problema `e un’oscillazione armonica di
% frequenza ωf /2π.

[t, u] = ode45(@mmsf, tv, y0);

% Verifico oscillazione analitica

A0 = 0.5;
omegaf = 0.5;
x = 2*exp(-gamma/2*t).*cos(w1*t) + A0*sin(omegaf*t);

figure;
% u(:, 1) è la soluzione numerica della posizione
% u(:, 2) è la soluzione numerica della velocità
plot(t, u(:,1), 'LineWidth', 2);
title('Sistema massa-molla-smorzatore con forzante esterna');
xlabel('t');
ylabel('x(t)');
grid on;
hold on;
plot(t, x, 'r--', 'LineWidth', 2);
legend('Soluzione numerica', 'Soluzione analitica');
hold off;


function fn = mms(~, y)
% y1' = y2
% y2' = -gamma*y2 - omega^2*y1
gamma = 0.1;
omega = 1;

[n,m] = size(y);
fn = zeros(n, m);

fn(1) = y(2);
fn(2) = -gamma*y(2) - omega^2*y(1);
end

function fn = mmsf(t, y)
% y1' = y2
% y2' = -gamma*y2 - omega^2*y1 + A0*sin(omegaf*t)

gamma  = 0.1;
omega  = 1;
A0     = 0.5;
omegaf = 0.5;

[n,m] = size(y);
fn = zeros(n, m);

fn(1) = y(2);
fn(2) = -gamma*y(2) - omega^2*y(1) + A0*sin(omegaf*t);
end