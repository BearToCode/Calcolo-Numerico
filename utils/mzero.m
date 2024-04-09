function m = mzero(f, a)
%% MZERO  Find the molteplity of a zero of a function.

  m = 0;
  df = f;

  while 1
    fn = matlabFunction(df);
    err = abs(fn(a));
    if err > 1e-10
      if m == 0
        warning('mzero: a non è zero di f');
      else
        break;
      end
    end
    
    m = m + 1;
    df = diff(df);
  end
end