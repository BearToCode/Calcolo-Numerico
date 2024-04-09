% Dato l’insieme dei numeri floating point F(2, 5, −6, 6), si stimi l’errore assoluto
% |x − fl(x)| tra il numero reale x = e^π e la sua rappresentazione in artimetica
% floating point fl(x).

base = 2;
t = 5;
L = -6;
U = 6;

eps_F = @(b, t) b^(1-t);
roundoff = 0.5 * eps_F(base, t);
roundoff_abs = roundoff * abs(exp(pi));
fprintf('Roundoff error: %e\n', roundoff_abs); 