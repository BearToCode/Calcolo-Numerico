clc; clear;

A = [ 4 -1  0  0  0;
      1  4  0  0  0;
      0 -1  3  0  0;
      0  0  1  6  0;
      0  0  0  9 -1;];

% Per quali valori dello shift
% s ∈ R `e possibile applicare il metodo delle potenze inverse con shift per l’approssimazione
% dell’autovalore 3 di A?

% gershcircles(A);

eigen_values = eig(A);
disp(eigen_values);

% -1.0000 + 0.0000i
% 6.0000 + 0.0000i
% 3.0000 + 0.0000i
% 4.0000 + 1.0000i
% 4.0000 - 1.0000i

% deve essere diverso dal valore => s != 3
% deve essere piu vicino al valore => -1 < s < 4

% Metodo grafico

% A, mu, tol, nmax, x0
tol = 1e-6;
nmax = 100;
x0 = [1; 1; 1; 1; 1];

x = linspace(-1, 6, 1000);
y = arrayfun(@(s) invpowershift(A, s, tol, nmax, x0), x);

plot(x, y);
grid on;
xlabel('s');
ylabel('f(s)');
