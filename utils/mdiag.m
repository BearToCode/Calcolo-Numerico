function M = mdiag(values, n)
  assert(mod(length(values), 2) == 1, "values must have an odd number of elements");

  M = zeros(n, n);

  half = (length(values) + 1) / 2;
  for i = 1:length(values)
    M = M + diag(values(i) * ones(n - abs(i - half), 1), i - half);
  end

end