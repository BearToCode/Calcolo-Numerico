%% Metodo delle potenze

% Permette di calcolare l'autovalore dominante di una matrice quadrata

A = [1 2 3; 
     4 5 6;
     7 8 9;];

tol = 1e-6;
nmax = 1000;
x0 = [1; 1; 1];
approx = eigpower(A, tol, nmax, x0);

eigs = eig(A);
max_eig = max(eigs);
assert(norm(approx - max_eig) < tol)

%% Metodo delle potenze inverse

% Permette di calcolare l'autovalore più piccolo(in modulo) di una matrice quadrata

A = [1 2 3; 
     4 -5 6;
     7 8 9;];

tol = 1e-6;
nmax = 1000;
x0 = [1; 1; 1];
approx = invpower(A, tol, nmax, x0);

eigs = eig(A);
[~, idx] = min(abs(eigs));
min_eig = eigs(idx);
assert(norm(approx - min_eig) < tol)


%% Metodo delle potenze con shift

% Permette di calcolare l'autovalore che minimizza |lambda - shift| ad un 
% dato shift di una matrice quadrata

% ATTENZIONE: devo scegliere uno shift che non sia un autovalore della matrice, e che sia strettamente
% vicino all'autovalore che voglio calcolare

A = [1 2 3; 
     23 5 6;
     7 8 9;];

tol = 1e-6;
nmax = 1000;
x0 = [1; 1; 1];
shift = 2;
approx = invpowershift(A, shift, tol, nmax, x0);

eigs = eig(A);
[~, idx] = min(abs(eigs - shift));
closest_eig = eigs(idx);
assert(norm(approx - closest_eig) < tol)

%% Cerchi di Gershgorin

% Utilizzati per localizzare gli autovalori di una matrice quadrata. Possiamo
% poi utilizzare il metodo delle potenze con shift per calcolare gli autovalori.

A = [1 2 3; 
     4 5 6;
     7 8 9;];
gershcircles(A);

%% Metodo delle iterazioni QR

% Permette di calcolare tutti gli autovalori di una matrice quadrata con autovalori distinti

A = [1 2 3; 
     4 5 6;
     7 8 9;];
tol = 1e-6;
nmax = 1000;

[approx] = qrbasic(A, tol, nmax);
assert(norm(sort(approx) - sort(eig(A))) < tol)

%% SVD

A = [1 2 3; 
     4 5 6;
     7 8 9;];

[U, S, V] = svd(A);

% U -> Contiene vettori singolari sinistri
% S -> Contiene i valori singolari (sigma)
% V -> Contiene vettori singolari destri

normF = @(X) sqrt(sum(sum(X.^2)));

%% Funzioni %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% eigpower -> in utils
% invpower -> in utils
% invpowershift -> in utils