function [x, it, xvect] = symnewton(x0, nmax, tol, symfun, symJ, mol)
% SYMNEWTON Implementazione del metodo di Newton per funzioni simboliche, non lineari, multidimensionali.
%
% [x, it, xvect] = symnewton(x0, nmax, tol, symfun, symJ, mol)
%
% Parametri di ingresso:
% x0           Vettore iniziale
% nmax         Numero massimo di iterazioni
% tol          Tolleranza
% symfun       Funzione di cui si cerca lo zero
% symJ         Jacobiana della funzione di cui si cerca lo zero. Opzionale, usa [] per calcolarla automaticamente.
% mol          Molteplicita' dello zero.
%
% Parametri di uscita:
% x            Approssimazione dello zero
% xvect        Vettore contenente tutte le iterate
%              xvect = [ x0, x1, x2, ... ] dimensione ( it + 1 )
% it           Numero di iterazioni effettuate
  
  if nargin < 6
    mol = 1;
  end

  it = 0;
  err = tol + 1;
  prev_x = x0;
  x = x0;
  
  xvect = zeros(length(x0), nmax + 1);
  xvect(:, 1) = x0;

  fun = matlabFunction(symfun);
  % Lascia la matrice jacobiana simbolica opzionale
  if isa(symJ, 'sym')
    J = symJ;
  else
    J = jacobian(symfun);
  end
  dfun = matlabFunction(J);

  while err > tol
    if it >= nmax
        warning('newton - raggiunto il numero massimo di iterazioni')
        break;
    end

    it = it + 1;

    % Valuto la matrice jacobiana
    prev_x_cell = num2cell(prev_x);
    dfun_eval = dfun(prev_x_cell{:});

    if det(dfun_eval) == 0
      warning('newton - derivata nulla')
      break;
    end
    
    sigma = dfun_eval \ -fun(prev_x_cell{:});
    x = prev_x + mol * sigma;
    xvect(:, it + 1) = x;
    err = norm(x - prev_x);
    prev_x = x;
  end

  xvect = xvect(:, 1:it + 1);
end