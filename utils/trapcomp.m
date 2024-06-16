function I = trapcomp(a, b, N, fun)
%% trapcomp: Quadratura del trapezio composita su intervalli equispaziati

h = (b - a) / N;

I = h/2 * (fun(a) + fun(b)) + h * sum(arrayfun(fun, a+h:h:b-h));
end