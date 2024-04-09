% Si consideri la matrice inversa di Hilbert A = invhilb(3)∈ R3×3. Si applichi il
% metodo delle potenze inverse con shift s = 10 per l’approssimazione di λ2(A) a
% partire dal vettore iniziale x(0) = 1 ∈ R3. Si riportino i valori delle approssimazioni
% λ(0), λ(1) e λ(2) di tale autovalore.

A = invhilb(3);
s = 10;
x0 = ones(3,1);

[lambda0] = invpowershift(A, s, 0, 0, x0);
[lambda1] = invpowershift(A, s, 0, 1, x0);
[lambda2] = invpowershift(A, s, 0, 2, x0);

fprintf('lambda0 = %f\n', lambda0);
fprintf('lambda1 = %f\n', lambda1);
fprintf('lambda2 = %f\n', lambda2);