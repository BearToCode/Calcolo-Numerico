function p = convord(f, sym, alpha)
%% CONVORD
% p = convord(f, alpha) restituisce l'ordine di convergenza p di f in alpha
% p è il primo grado della derivata di f in alpha che non è nulla

    p = 0;
    derivate = f;
    tol = 1e-10;
    err = tol + 1;
    while err > tol
        p = p + 1;
        derivate = diff(derivate);
        err = eval(subs(f, sym, alpha));
        fprintf('p = %d, err = %e\n', p, err);
    end
end