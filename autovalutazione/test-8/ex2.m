clear; clc;

syms x;
f = cos(pi * x);

a = -1;
b = 1;

% Stima dell'errore a priori in funzione di n

% f è n+1 volte derivabile in [-1,1] -> ok

syms n;

% err = 1 / (n+1)! * max_{x \in [-1,1]} |f^(n+1)(x)| * max_{x \in [-1,1]} |prod(x-x_i)|

% => Nodi equispaziati

% => 1 / 4*(n+1) * ((b-a) / n)^(n+1) * max_{x \in [-1,1]} |f^(n+1)(x)|

% max_{x \in [-1,1]} |f^(n+1)(x)|  = pi^(n+1)

err = simplify(1/(4*(n+1)) * ((b-a)/n)^(n+1) * pi^(n+1));
display(err);