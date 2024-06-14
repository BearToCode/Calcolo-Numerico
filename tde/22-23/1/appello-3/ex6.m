% Si consideri la funzione f (x) = log(x + 5/2) * cos(πx) nell’intervallo [−2, 0]. Il
% metodo di bisezione pu`o essere applicato per
% 1. calcolare lo zero α1 ∈ [−2, −1] a partire dall’intervallo [−2, 0];
% 2. calcolare lo zero α1 ∈ [−2, −1] a partire dall’intervallo [−2, −1];
% 3. calcolare lo zero α2 ∈ [−1, 0] a partire dall’intervallo [−2, 0];
% 4. calcolare lo zero α2 ∈ [−1, 0] a partire dall’intervallo [−1, 0];
% 5. calcolare entrambi gli zeri α1 e α2 ∈ [−2, 0] a partire dall’intervallo [−2, 0].
% Quale o quali delle precedenti affermazioni sono vere?

syms x;
symf = log(x + 5/2) * cos(pi*x);
f = matlabFunction(symf);

fplot(f, [-2, 0]);
grid on;

% => zero calcolabile in x = -0.5
sol = -0.5;

% 1 falsa
% 2 falsa
% 3 vera
% 4 vera
% 5 falsa