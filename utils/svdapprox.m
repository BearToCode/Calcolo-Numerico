function approx = svdapprox(U, S, V, k)
%% SVDAPPROX Approssimazione di rango k di una matrice tramite SVD
%
% approx = svdapprox(U, S, V, k) restituisce l'approssimazione di rango k
% della matrice originale, data la sua decomposizione SVD.
%
% Input:
% - U: matrice unitaria sinistra
% - S: matrice diagonale singolare
% - V: matrice unitaria destra
% - k: rango dell'approssimazione

  approx = U(:,1:k) * S(1:k, 1:k) * V(:, 1:k)';

end