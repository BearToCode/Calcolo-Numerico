function order = newtonorder(symf, sol)
  f = matlabFunction(symf);
  err = f(sol);
  tol = 1e-10;
  assert(f(sol) < tol, sprintf('sol non è una radice di f, err: %e', err));

  m = mzero(symf, sol);
  
  if m == 1
    order = 2;
    return;
  else 
    order = 1;
    return;
  end
end