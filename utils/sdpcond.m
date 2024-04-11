function K = sdpcond(A, tol, nmax)
%
% SDPCOND Metodo per il calcolo del numero di condizionamento spettrale di matrici
% simmetriche e definite positive
%
% Parametri di ingresso:
%
% A: matrice di sistema
% tol:  tolleranza criterio d'arresto
% nmax: numero massimo di iterazioni ammesse
%
% Parametri di uscita:
%
% K: numero di condizionamento spettrale di A
%

   % Inizializzazione
   n    = size( A, 2 );
   x0   = rand( n, 1 );
   iter = 0;
   y    = x0 / norm( x0 );
   y_mu = y;

   % lambda = y' * A * y;
   % mu = lambda;

   K   = 1;
   err = tol + 1; % dobbiamo entrare nel ciclo
   [L, U, P] = lu(A); % O(2/3 n^3)

   while err > tol && iter<nmax
      iter = iter + 1;
      
      x = A * y;                % 2n^2-n ops
      y = x / norm(x)  ;        % 2n+1 ops  
      lambda = y' * A * y;      % 2n^2+n-1 ops

      z = fwsub(L, P * y_mu);   % n^2 ops
      x = bksub(U, z);          % n^2 ops
      y_mu = x / norm(x);       % 2n+1 ops
      mu = y_mu' * A * y_mu;    % 2n^2+n-1 ops

      K_new = lambda / mu;  
      err = abs(K - K_new);
      K = K_new;
   end

end

