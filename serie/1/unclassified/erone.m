function r = erone(n)
%ERONE: Stima la radice quadrata usando l'algoritmo di Erone
% toll: `1e-7`
    tic
    toll = 1e-6;

    r = n;
    r_prev = n + 2 * toll;
    while abs(r - r_prev) > toll
        r_prev = r;
        r = 0.5 * (r + (n / r));
    end
    toc

    tic
    sqrt(n)
    toc
end