clear; clc;

% Si consideri l’approssimazione dell’integrale I(f) = ∫[a,b] f(x) dx, dove f ∈ C∞([a, b]),
% tramite la formula dei trapezi composita. Sapendo che per M1 = 25 sottointervalli
% equispaziati di [a, b] si ha un errore pari a e1(f) = 0.08, si stimi l’errore e2(f )
% commesso con M2 = 50 sottointervalli equispaziati.

M1 = 25;
e1 = 0.08;
M2 = 50;

% L'errore commesso con M2 sottointervalli è approssimabile come
% e2(f) = e1(f) * (M1 / M2)^2

e2 = e1 * (M1 / M2)^2;

disp(e2); % 0.02