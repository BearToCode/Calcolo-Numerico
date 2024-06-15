function [x, u, A, f] = dtr(mu, eta, sigma, fun, a, b, a_cond, b_cond, alpha, beta, h)
% DTR: Risoluzione di problemi di diffusione-trasporto-reazione con
% condizioni al contorno di Dirichlet o Neumann.
% attraverso il metodo delle differenze finite centrate
%
% Problema: -mu u''(x) + eta u'(x) + sigma u(x) = f(x) in (a, b)
%
% [x, u, A, f] = dtr(mu, eta, sigma, f, a, b, alpha, beta, h)
%
% Input:
% - mu, eta, sigma: coefficienti del problema / funzioni
% - fun: funzione di carico
% - a, b: estremi dell'intervallo
% - a_cond, b_cond: condizioni al contorno
%   - "dirichlet": condizione di Dirichlet, alpha/beta scalare
%   - "neumann": condizione di Neumann, alpha/beta scalare
%   - "neumann_centered": condizione di Neumann centrata, alpha/beta scalare
%   - "robin": condizione di Robin, alpha/beta del tipo [a, b, c]
%   - "robin_centered": condizione di Robin centrata, alpha/beta del tipo [a, b, c]
%      dove a, b, c sono i valori a*u'(a) + b*u(a) = c
% - alpha, beta: condizioni al contorno
% - h: passo di discretizzazione
%
% Output:
% - u: soluzione approssimata [u_0, ..., u_N+1]
% - x: nodi della griglia [x_0, ..., x_N+1]
% - A: matrice del sistema lineare
% - f: vettore del termine noto

x = a:h:b;
N = length(x) - 2;

if isscalar(mu) && ~isa(mu, "function_handle")
    mu = ones(N+2, 1) * mu;
else
    mu = mu(x)';
end

if isscalar(eta) && ~isa(eta, "function_handle")
    eta = ones(N+2, 1) * eta;
else
    eta = eta(x)';
end

if isscalar(sigma) && ~isa(sigma, "function_handle")
    sigma = ones(N+2, 1) * sigma;
else
    sigma = sigma(x)';
end

conditions = ["dirichlet", "neumann", "neumann_centered", "robin", "robin_centered"];
if ~ismember(a_cond, conditions) || ~ismember(b_cond, conditions)
    error("Condizioni al contorno non riconosciute");
end


mu_internal    = mu(2:end-1);
sigma_internal = sigma(2:end-1);
eta_internal   = eta(2:end-1);


A = mu_internal  / h^2     .* sparsemdiag([-1 2 -1], N) + ...
    eta_internal / (2 * h) .* sparsemdiag([-1 0 1], N) + ...
    sigma_internal         .* speye(N);
f = arrayfun(fun, x(2:end-1))';

prefix = [];
suffix = [];

if strcmp(a_cond, "dirichlet")
    f(1)   = f(1) + alpha * (mu(1)/h^2 + eta(1)/(2*h));
    prefix = alpha;
elseif strcmp(a_cond, "neumann_centered")
    [s, ~] = size(A);
    newA   = sparse(s+1, s+1);
    newA(2:end, 2:end) = A;
    
    newA(2, 1) = -mu(1) / h^2 - eta(1)/(2*h);
    % Differenze finite centrate
    newA(1, 1) = -3*mu(1) / (2*h);
    newA(1, 2) =  2*mu(2) /    h;
    newA(1, 3) =   -mu(3) / (2*h);
    
    A = newA;
    f = [alpha; f];
elseif strcmp(a_cond, "neumann")
    [s, ~] = size(A);
    newA   = sparse(s+1, s+1);
    newA(2:end, 2:end) = A;
    
    newA(2, 1) = -mu(1) / h^2 - eta(1)/(2*h);
    % Differenze finite in avanti
    newA(1, 1) = -mu(1) / h;
    newA(1, 2) =  mu(2) / h;
    
    A = newA;
    f = [alpha; f];
elseif strcmp(a_cond, "robin")
    [s, ~] = size(A);
    newA   = sparse(s+1, s+1);
    newA(2:end, 2:end) = A;
    
    a = alpha(1);
    b = alpha(2);
    c = alpha(3);
    
    newA(2, 1) = -mu(1) / h^2 - eta(1)/(2*h);
    % Differenze finite in avanti + dirichlet
    newA(1, 1) = a*(-mu(1) / h) + b;
    newA(1, 2) = a*(mu(2) / h);
    
    A = newA;
    f = [c; f];
elseif strcmp(a_cond, "robin_centered")
    [s, ~] = size(A);
    newA   = sparse(s+1, s+1);
    newA(2:end, 2:end) = A;
    
    a = alpha(1);
    b = alpha(2);
    c = alpha(3);
    
    newA(2, 1) = -mu(1) / h^2 - eta(1)/(2*h);
    % Differenze finite centrate + dirichlet
    newA(1, 1) = a*(-3*mu(1) / (2*h)) + b;
    newA(1, 2) = a*(2*mu(2)  / h);
    newA(1, 3) = a*(-mu(3)   / (2*h));
    
    A = newA;
    f = [c; f];
end

if strcmp(b_cond, "dirichlet")
    f(end) = f(end) + beta * (mu(end)/h^2 - eta(end)/(2*h));
    suffix = beta;
elseif strcmp(b_cond, "neumann_centered")
    [s, ~] = size(A);
    newA   = sparse(s+1, s+1);
    newA(1:end-1, 1:end-1) = A;
    
    newA(s,   s+1) = -mu(N+2) / h^2 + eta(N+2)/(2*h);
    % Differenze finite centrate
    newA(s+1, s-1) =    mu(N  ) / (2*h);
    newA(s+1, s  ) = -2*mu(N+1) /    h;
    newA(s+1, s+1) =  3*mu(N+2) / (2*h);
    
    A = newA;
    f = [f; beta];
elseif strcmp(b_cond, "neumann")
    [s, ~] = size(A);
    newA   = sparse(s+1, s+1);
    newA(1:end-1, 1:end-1) = A;
    
    newA(s,   s+1) = -mu(N+2) / h^2 + eta(N+2)/(2*h);
    % Differenze finite all'indietro
    newA(s+1, s  ) = -mu(N+1) / h;
    newA(s+1, s+1) =  mu(N+2) / h;
    
    A = newA;
    f = [f; beta];
elseif strcmp(b_cond, "robin")
    [s, ~] = size(A);
    newA   = sparse(s+1, s+1);
    newA(1:end-1, 1:end-1) = A;
    
    a = beta(1);
    b = beta(2);
    c = beta(3);
    
    newA(s,   s+1) = -mu(N+2) / h^2 + eta(N+2)/(2*h);
    % Differenze finite all'indietro + dirichlet
    newA(s+1, s  ) = a*(-mu(N+1) / h);
    newA(s+1, s+1) = a*( mu(N+2) / h) + b;
    
    A = newA;
    f = [f; c];
elseif strcmp(b_cond, "robin_centered")
    [s, ~] = size(A);
    newA   = sparse(s+1, s+1);
    newA(1:end-1, 1:end-1) = A;
    
    a = beta(1);
    b = beta(2);
    c = beta(3);
    
    newA(s,   s+1) = -mu(N+2) / h^2 + eta(N+2)/(2*h);
    % Differenze finite centrate + dirichlet
    newA(s+1, s-1) = a*(mu(N  ) / (2*h));
    newA(s+1, s  ) = a*(-2*mu(N+1) / h);
    newA(s+1, s+1) = a*(3*mu(N+2) / (2*h)) + b;
    
    A = newA;
    f = [f; c];
end

u = [prefix (A\f)' suffix]';
end