function [u_h] = eulerfwdsym(f, iter, y0, h)
%% eulerfwd: Implementazione simbolica del metodo di eulero in avanti per la risoluzione di un problema di Cauchy.

u_h = sym(zeros(1, iter));

u_h(1) = y0;
for i=1:iter-1
    t = (i - 1) * h;
    u_h(i + 1) = u_h(i) + h * f(t, u_h(i));
end

end