clear; clc;

f1 = @(t) 6/25 * (-5 * sin(2*t) - 100 * cos(t) + 348 * cos(t).^2 - 174) .* exp(-t/5);
f2 = @(t) 3/5  * (19 * cos(t) - 5 * sin(t) - 40 * cos(t).^2 + 20) .* exp(-t/5);

A = [
    -1/3 -26/3 8/3;
    1     0    0;
    0     4    -4;
    ];

g = @(t) [
    f1(t)/3;
    0;
    f2(t);
    ];

y0 = [-3/5; 3; 3];
tf = 10;

%% 2.

P = @(t, y) A * y + g(t);

h  = 0.1;
Nh = tf/h;
[~, u] = heun_systems(P, [0 tf], y0, Nh);

u1  = u(:, 1+1);
uNh = u(:, end);

disp(u1);
disp(uNh);

% u1 =
% -1.7716
% 2.8806
% 2.9348
% uNh =
% -0.7984
% 0.1339
% -0.3552

% Differenze finite in avanti per approssimare x2'(0)

% x2'(0) = (x2(0+h) - x2(0)) / h

x2_0 = u(3, 1);
x2_h = u(3, 2);

dx2_0 = (x2_h - x2_0) / h;
disp(dx2_0); % -0.6515

%% 3.

sol = @(t) [
    3 * cos(2*t) .* exp(-t/5);
    3 * cos(t) .* exp(-t/5);
    ];

h_values   = [1e-1, 5e-2, 2.5e-2, 1.25e-2];
err_values = zeros(1, length(h_values));

it = 1;
for h = h_values
    Nh = tf/h;
    [t, u] = heun_systems(P, [0, tf], y0, Nh);
    
    u_x1 = u(2, :);
    
    exact = sol(t);
    ex_x1 = exact(1, :);
    
    err_values(it) = max(abs(u_x1 - ex_x1));
    
    it = it + 1;
end

disp(err_values);

% err_values =     0.1858    0.1817    0.1836    0.1843

h1 = h_values(end-1);
h2 = h_values(end);

E1 = err_values(end-1);
E2 = err_values(end);

p = log10(E2 / E1) / log10(h2 / h1);

disp(p); % -0.0059, l'errore rimane costante e non atteso come p = 2; devo aver sbagliato a copiare qualcosa...

%% 4.

R = @(z) 1 + z + z.^2 / 2;
hmax = linear_abs_stability(A, R);

disp(hmax); % 0 < hmax < 0.4910, come previsto il metodo di heun non è incondizionalmente assolutamente stabile
% L'hmax è il valore di h massimo che consente di rientrare nella regione di stabilità data dalla funzione di stabilità R
% |R(z)| < 1, con z = h * lambda

%% 5.

% Metodo implicito
B = [
    0 0 0 0;
    1/2 1/4 1/4 0;
    1 0 1 0;
    0 1/6 2/3 1/6
    ];
h = 0.1;

[t, u] = rk_implicit(P, B, [0 tf], y0, h);

u1_2 = u(2, 1+1);
u2_2 = u(2, 1+2);
uNh_2 = u(2, end);

disp(u1_2);
disp(u2_2);
disp(uNh_2);

% 2.9005
% 2.6854
% 0.1024