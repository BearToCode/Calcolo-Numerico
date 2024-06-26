clc
clear
close all

%% Ex 1.4
f1 = @(x) x .* sin(x) + (0.5 .^ (sqrt(x)));
f2 = @(x) x .^ 4 + log(x .^ 3 - 1);

disp(f1);
disp(f2);

%% Symbolic functions
syms x
symbolic_f1 = x .* sin(x) + (0.5 .^ (sqrt(x)));
integral_f1 = int(symbolic_f1);
diff(integral_f1)
disp(symbolic_f1)

%% 1.5
f = @(x) 2 + (x-3) .* sin(5 * (x - 3));
x = linspace(0, 6, 100);
y1 = @(x) -x+5;
y2 = @(x) x-1;

hold on
plot(x, f(x));
plot(x, y1(x), 'w--');
plot(x, y2(x), 'w--');
hold off

%% Esempi di errori numerici
a = 0:0.01:1;
b = linspace(0, 1, 101);

c = abs(a-b);
plot(c, '*-');

x = 1e-16;
disp(((x-1) + 1) / x);

%% Circonferenza
r = 1;
theta = linspace(0, 2*pi, 100);
x = r*cos(theta);
y = r*sin(theta);

plot(x, y);

%% Ellisse
r = 1;
theta = linspace(0, 2*pi, 100);
x = 2*r*cos(theta);
y = 3*r*sin(theta);

plot(x, y);

%% Quadrato
q_size = 5 / 2;
x = [q_size; q_size; -q_size; -q_size; q_size];
y = [q_size; -q_size; -q_size; q_size; q_size];

plot(x, y, 'LineWidth', 2);

%% Funzione definita a tratti
f = @(x) -sqrt(x.^2 - x) .* (x < 0) + ...
         (-x.^2 + 2*x) .* exp(-x) .* (x >= 0);
x = linspace(-10, 10, 100);
plot(x, f(x), 'r--')



