% Si consideri il metodo di Newton per l’approssimazione dello zero α = 4 della
% funzione f (x) = (x − 4) log (x − 3) sin(πx). Qual è la molteplicità dello zero α?
% Qual è l’ordine di convergenza p atteso dal metodo ad α = 4 partendo da un’iterata
% iniziale x(0) “sufficientemente” vicino ad α?

a = 4;
syms x;
f = (x - 4) * log(x - 3) * sin(pi * x);

m = mzero(f, a);
p = newtonorder(f, a);

fprintf('La molteplicità dello zero α = 4 è: %d\n', m);
fprintf("L\'ordine di convergenza p atteso dal metodo ad α = 4 è: %d\n", p);