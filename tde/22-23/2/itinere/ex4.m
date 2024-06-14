% Si considerino le coppie di dati nella forma {(xj , yj )}n j=0, tali per cui n + 1 = 5
% e specificamente {(0, 3), (0.25, 0.5), (0.5, 1.5), (0.75, −0.5), (1, 1)}. Si costruisca il
% polinomio p2(x) di grado 2 approssimante tali dati nel senso dei minimi quadrati
% e si riporti il valore dello scarto quadratico n∑j=0 (p2(xj ) − yj )2.

nodes = [0, 0.25, 0.5, 0.75, 1]';
values = [3, 0.5, 1.5, -0.5, 1]';

% pol = regression(nodes, values, 2);
% Altrimenti con polyfit(nodes, values, 2)

pol = polyfit(nodes, values, 2);

sq = 0;
for i = 1:length(nodes)
    sq = sq + (polyval(pol, nodes(i)) - values(i))^2;
end

disp(sq);