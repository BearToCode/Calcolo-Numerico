function M = sparsemdiag(values, n)
assert(mod(length(values), 2) == 1, "values must have an odd number of elements");

M = sparse(n, n);
half = (length(values) + 1) / 2;
for i = 1:length(values)
    shift = i - half;
    M = M + sparse(                             ...
        max(1, -shift + 1):min(n - shift, n),   ...
        max(1, +shift + 1):min(n + shift, n),   ...
        values(i) * ones(n - abs(i - half), 1), ...
        n, n);
end

end