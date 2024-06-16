function hmax = abs_stability(R, interval, dfdy, sol)
% ABS_STABILITY Calcola il passo massimo per la stabilità assoluta
%
% Input:
% - R: funzione di stabilità del metodo
% - interval: intervallo temporale [t0, tf]
% - dfdy: derivata di f rispetto a y, df/dy(t, y(t))
% - sol: soluzione  dell'equazione differenziale sol(t)
%
% Output:
% - hmax: passo massimo per la stabilità assoluta

% Un metodo è assolutamente stabile <=> |R(z)| <= 1, con z = h*lambda
% Per determinare lambda, si trova il massimo del modulo della derivata
% di f rispetto a y, all'interno dell'intervallo.

% 1. Determino lambda
F = @(t) abs(dfdy(t, sol(t)));

% Trasformo in un problema di minimo
Fmin = @(t) -F(t);

t0 = interval(1);
tf = interval(2);

opts = optimoptions(@fmincon,'Algorithm','sqp');
problem = createOptimProblem(...
    'fmincon',         ...
    'objective', Fmin, ...
    'x0',        tf,   ...
    'lb',        t0,   ...
    'ub',        tf,   ...
    'options',   opts  ...
    );
gs = GlobalSearch;
[lambda_t] = run(gs,problem);

lambda = -F(lambda_t);

% 2. Trovo hmax risolvendo |R(z)| == 1
E = @(z) abs(R(z)) - 1;

z = fzero(E, [-100, -1e-5]);
hmax = abs(z / lambda);
end