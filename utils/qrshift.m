function [eigs] = qrshift(A, tol, nmax)
  if check()
    [rows, cols] = size(A);
    assert(rows == cols, 'A deve essere quadrata');
  end

  n = size(A, 1);    
  mu = 0;

  iter = 0;
  err = tol + 1;
  
  while err > tol && iter < nmax 
      iter = iter + 1;

      [Q, R] = qr(A - mu * eye(n));
      A = R * Q + mu * eye(n);
      mu = A(n, n);

      err = max(max(abs(tril(A, -1))));
  end

  eigs = diag(A);
end