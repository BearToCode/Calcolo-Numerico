function [xvect,it] = biseznewton(a, b, nmax_b, nmax_n, toll, fun, dfun)
  it = 0;
  xvect = [];

  toll_b = (b-1) / (2^(nmax_b+1));
  [xvect_b, it_b] = bisez(a, b, toll_b, fun);

  it = it + it_b;
  xvect = [xvect, xvect_b];

  x0 = xvect_b(end);
  [xvect_n, it_n] = newton(x0, nmax_n, toll, fun, dfun);

  it = it + it_n;
  xvect = [xvect, xvect_n(2:end)];
end