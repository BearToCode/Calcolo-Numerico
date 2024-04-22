A = [+4 -1 +0 +0;
     -1 +5 -1 +0;
     +0 -1 +6 -1;
     +0 +0 -1 +7]; % SDP
b = [1 1 1 1]';

R = chol(A);

y = fwsub(R', b);
x = bksub(R, y);

fprintf("R23 = %f\n", R(2,3));
fprintf("Y2 = %f\n", y(2));
