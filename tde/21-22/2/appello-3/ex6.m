clear; clc;

% Si consideri l’approssimazione dell’integrale I(f) = ∫ [a,b] f(x) dx, dove f ∈ C3([a, b]),
% tramite la formula del punto medio composita. Sapendo che per M1 = 25 sottoin-
% tervalli equispaziati di [a, b] si ha un errore pari a e1(f) = 0.08, si stimi il nu-
% mero di sottointervalli equispaziati M2 tali per cui l’errore commesso risulta pari
% a e2(f) = 0.02.

% La formula del punto medio composita ha ordine 2

M1 = 25;
e1 = 0.08;
e2 = 0.02;

M2 = M1 / sqrt(e2 / e1);

disp(M2) % 50