% Si consideri la matrice A =
% −4 0 0
% 0 2 (√10 − 1)
% 0 −(√10 + 1) 2
% Per quali valori
% dello shift s ∈ R `e possibile applicare il metodo delle potenze inverse con shift per
% l’approssimazione dell’autovalore −4 di A?

A = [-4 0                 0; 
     0  2                 sqrt(10) - 1; 
     0  -(sqrt(10) + 1)   2];

% => s != -4 e altre condizioni da verificare:

% Metodo analitico

eigs = eig(A);
% Devo vedere quanto vicini sono gli autovalori
disp(eigs);

% 2.0000 + 3.0000i
% 2.0000 - 3.0000i
% -4.0000 + 0.0000i

% Punti equidistanti da -4 e 2 + 3i, 2 - 3i
% 

% Metodo grafico

% A, mu, tol, nmax, x0
tol = 1e-6;
nmax = 100;
x0 = [1; 1; 1;];

x = linspace(-5, 0.5, 1000);
y = arrayfun(@(s) invpowershift(A, s, tol, nmax, x0), x);

plot(x, y);
grid on;
xlabel('s');
ylabel('f(s)');