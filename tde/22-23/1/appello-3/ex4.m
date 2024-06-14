% Sia dato il sistema lineare Ax = b, con A =
% 4 0 2 2
% 0 2 0 −2
% 2 0 4 2
% 2 −2 2 4
% e b = (1, 1, 2, 2)T .
% Indicata con R ∈ R4×4 una matrice triangolare superiore, simmetrica e definita
% positiva tale che A = R^T R, si riporti il valore dell’elemento (R)3,4. Si utilizzi la ma-
% trice R per applicare il metodo della fattorizzazione di Cholesky alla soluzione del
% sistema lineare A x = b. Si riporti la terza componente (y)3 del vettore ausiliario
% y associato alla soluzione del sistema triangolare inferiore che compare durante
% l’applicazione del metodo.

A = [4, 0, 2, 2; 
     0, 2, 0, -2; 
     2, 0, 4, 2; 
     2, -2, 2, 4];

b = [1; 1; 2; 2];

R = chol(A);
y = fwsub(R', b);
x = bksub(R, y);

fprintf('Elemento (R)3,4: %f\n', R(3, 4));
fprintf('Terza componente (y)3: %f\n', y(3));