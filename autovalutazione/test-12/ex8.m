clear; clc;

% Approssimazione DTR tramite differenze finite centrate => accuratezza O(h^2)

h1 = 0.1;
E1 = 4 * 10^-2;

h2 = 0.05;
E2 = (h2 / h1) ^ 2 * E1;

disp(E2)