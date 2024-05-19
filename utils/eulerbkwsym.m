function [u_h] = eulerbkwsym(symf, iter, y0, h)
%% eulerfwd: Implementazione simbolica del metodo di eulero all'indietro per la risoluzione di un problema di Cauchy.

t0      = 0;
u_h     = sym(zeros(1, iter));

u_h(1) = y0;

for i=1:iter-1
    % u(n+1) = u(n) + h * f(t(n+1), u(n+1))
    % y = phi(y) dove y = u(n+1)
    % phi(y) = u(n) + h * f(t(n), y)
    
    syms y;
    u = u_h(i);
    t_next = t0 + i * h;
    f = subs(symf, {'t', 'y'}, {t_next, y});
    u_next = solve(y == u + h * f, y);
    
    u_h(i+1) = u_next;
end

end