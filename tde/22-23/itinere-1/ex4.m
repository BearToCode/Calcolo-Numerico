% Si consideri un sistema sovradeterminato Ax = b, dove A ∈ R3×2 ha rango
% pieno e b = (1, 2, 2)T ∈ R3. La fattorizzazione QR ridotta di A `e tale che
% 
%     | 1/sqrt(2) 0 |
% Q = | 0         1 | e R = | sqrt(2) -gamma | con gamma parametro > 0. 
%     | 1/sqrt(2) 0 |       | 0        1     |
%
% Si riporti la soluzione del sistema nel senso dei minimi quadrati.

syms x;
Q = [1/sqrt(2) 0; 
     0         1; 
     1/sqrt(2) 0];
R = [sqrt(2) -x; 
     0        1];
b = [1; 2; 2];

x = R \ (Q'*b);

disp(simplify(x));