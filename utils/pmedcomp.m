function I = pmedcomp(a, b, N, fun)
%% pmedcomp: Quadratura del punto medio composita su intervalli equispaziati

h = (b - a) / N;

x = a+h/2:h:b-h/2;
I = h * sum(fun(x));

end