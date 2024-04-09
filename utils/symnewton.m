function [x, it, xvect] = symnewton(x0, nmax, tol, symfun, mol)  
  if nargin < 6
    mol = 1;
  end

  it = 0;
  err = tol + 1;
  prev_x = x0;
  x = x0;
  
  xvect = zeros(nmax + 1, length(x0));
  xvect(:, 1) = x0;

  fun = matlabFunction(symfun);
  J = jacobian(symfun);
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