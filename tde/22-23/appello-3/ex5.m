% Si consideri la matrice A =
% (t − 3) 0 0
% 11 (t + 4) 3
% −4 0 (t + 1)
% Per quali valori del
% parametro t ∈ R `e possibile applicare il metodo delle potenze per l’approssimazione
% dell'autovalore massimo di A ?

syms t;

A = [t-3 0   0; 
     11  t+4 3; 
     -4  0   t+1];
% A deve avere un autovalore dominante

eigs = abs(eig(A));
disp(eigs);

fplot(eigs(1));
hold on
fplot(eigs(2));
fplot(eigs(3));
hold off

%% Sempre diversi in modulo!
fplot(max(eigs)) % => != -1/2