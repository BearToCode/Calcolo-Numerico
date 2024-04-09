% Si consideri il metodo delle iterazioni di punto fisso per trovare lo zero α della
% funzione f (x) = x − x1/3 − 2 = 0 nell’intervallo [3, 5]. Date le seguenti funzioni di
% iterazione
% 1. φ(x) = x1/3 + 2,
% 2. φ(x) = (x − 2)3,
% 3. φ(x) = (6 + 2x^1)/(3 − x^−2/3) ,
% si indichi per quale o quali funzioni di iterazione il metodo delle iterazioni di punto
% fisso converge ad α se l’iterata iniziale `e “sufficientemente” vicino ad α.

a = 3;
b = 5;

syms x;
phi1 = x^(1/3) + 2;
phi2 = (x - 2)^3;
phi3 = (6 + 2*x^1)/(3 - x^(-2/3));

dphi1 = diff(phi1);
dphi2 = diff(phi2);
dphi3 = diff(phi3);

% Deve valere |phi'(x)| < 1
fplot(abs(dphi1), [a, b]);
hold on;
fplot(abs(dphi2), [a, b]);
fplot(abs(dphi3), [a, b]);
grid on;
legend('phi1', 'phi2', 'phi3');