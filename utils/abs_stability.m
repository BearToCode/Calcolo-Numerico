function hmax = abs_stability(R, symf, cond, symt, symy, interval)
%% ABS_STABILITY Calcola il passo massimo per la stabilità assoluta
%
% Input:
% - R: funzione di stabilità del metodo
% - symf: funzione simbolica del problema (f(t, y(t)))
% - cond: condizione iniziale y(t0) per l'equazione differenziale
% - symt: variabile simbolica temporale
% - symy: variabile simbolica dipendente dichiarata come y(t)
% - interval: intervallo temporale [t0, tf]
%
% Output:
% - hmax: passo massimo per la stabilità assoluta

% Necessito di conoscere y(t), risolvo quindi l'equazione differenziale
eq = diff(symy, symt) == symf;
symsol(symt) = dsolve(eq, cond);

% Un metodo è assolutamente stabile <=> |R(z)| <= 1, con z = h*lambda
% Per determinare lambda, si trova il massimo del modulo della derivata
% di f rispetto a y, all'interno dell'intervallo.

symdfdy = diff(symf, symy);
% Sostituisco y con la soluzione
symdfdy = subs(symdfdy, symy, symsol);
dfdy = matlabFunction(symdfdy);

F = @(t) abs(dfdy(t));

% Trasformo in un problema di minimo

Fmin = @(t) -F(t);

t0 = interval(1);
tf = interval(2);

opts = optimoptions(@fmincon,'Algorithm','sqp');
problem = createOptimProblem('fmincon','objective',...
    Fmin,'x0',tf,'lb',t0,'ub',tf,'options',opts);
gs = GlobalSearch;
[lambda_t] = run(gs,problem);

lambda = -F(lambda_t);

% Trovo hmax risolvendo |R(z)| == 1
E = @(z) abs(R(z)) - 1;

[succ, ~] = bisez(-100, -1e-5, 1e-5, E);
hmax = abs(succ(end) / lambda);
end