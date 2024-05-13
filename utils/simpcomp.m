function I = simpcomp(a, b, N, fun)
%% simpcomp: Quadratura di Simpson composita su intervalli equispaziati

h = (b - a) / N;

x = a:h:b;

I = 0;

for i=1:N
    I = I + simple(x(i), x(i+1), fun);
end

end

function I = simple(a, b, fun)
I = (b - a) / 6 * (fun(a) + 4 * fun((a + b) / 2) + fun(b));
end