A = [+5 -1 +0;
     +1 +3 +0;
     +0 +0 +8;];

% 1.

x0 = [1 1 0]';

[lambda] = eigpower(A, 0, 100, x0); % FALSA
disp('1');
disp(lambda);

% 2.

x0 = [1 1 1]';

[lambda] = eigpower(A, 0, 2, x0);
disp('2');
disp(lambda);

% 3.

gershcircles(A);