function [x, u, A, f] = dtr_upwind(mu, eta, sigma, fun, a, b, a_cond, b_cond, alpha, beta, h)
% DTR_UPWIND: Risoluzione di problemi di diffusione-trasporto-reazione con
% condizioni al contorno di Dirichlet o Neumann, mediante tecnica upwind.
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
% - a_cond, b_cond: condizioni al contorno ("dirichlet", "neumann_centered", "neumann")
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

conditions = ["dirichlet", "neumann_centered", "neumann"];
if ~ismember(a_cond, conditions) || ~ismember(b_cond, conditions)
    error("Condizioni al contorno non riconosciute");
end


mu_internal    = mu(2:end-1);
sigma_internal = sigma(2:end-1);
eta_internal   = eta(2:end-1);


A = mu_internal  / h^2 .* sparsemdiag([-1 +2 -1], N) + ...
    eta_internal / h   .* sparsemdiag([-1 +1 +0], N) .* (eta_internal > 0) + ...
    eta_internal / h   .* sparsemdiag([+0 -1 +1], N) .* (eta_internal < 0) + ...
    sigma_internal     .* speye(N);
f = arrayfun(fun, x(2:end-1))';

prefix = [];
suffix = [];

if strcmp(a_cond, "dirichlet")
    if eta(1) > 0
        f(1) = f(1) + alpha * (mu(1)/h^2 + eta(1)/(h));
    else
        f(1) = f(1) + alpha * (mu(1)/h^2);
    end
    prefix = alpha;
elseif strcmp(a_cond, "neumann_centered")
    [s, ~] = size(A);
    newA   = sparse(s+1, s+1);
    newA(2:end, 2:end) = A;
    
    newA(2, 1) = -mu(1) / h^2;
    if eta(1) > 0
        newA(2, 1) = newA(2, 1) - eta(1)/h;
    end
    % Differenze finite centrate
    newA(1, 1) = -3*mu(1) / (2*h);
    newA(1, 2) =  2*mu(2) /    h;
    newA(1, 3) =   -mu(3) / (2*h);
    
    A = newA;
    f = [alpha; f];
else % "neumann"
    [s, ~] = size(A);
    newA   = sparse(s+1, s+1);
    newA(2:end, 2:end) = A;
    
    newA(2, 1) = -mu(1) / h^2 - eta(1)/(2*h);
    % Differenze finite in avanti
    newA(1, 1) = -mu(1) / h;
    newA(1, 2) =  mu(2) / h;
    
    A = newA;
    f = [alpha; f];
end

if strcmp(b_cond, "dirichlet")
    if eta(end) < 0
        f(end) = f(end) + beta * (mu(end)/h^2 - eta(end)/(h));
    else
        f(end) = f(end) + beta * (mu(end)/h^2);
    end
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
else % "neumann"
    [s, ~] = size(A);
    newA   = sparse(s+1, s+1);
    newA(1:end-1, 1:end-1) = A;
    
    newA(s, s+1) = -mu(N+2) / h^2;
    if eta(1) < 0
        newA(s, s+1) = newA(s, s+1) + eta(end)/h;
    end
    % Differenze finite all'indietro
    newA(s+1, s  ) = -mu(N+1) / h;
    newA(s+1, s+1) =  mu(N+2) / h;
    
    A = newA;
    f = [f; beta];
end

u = [prefix (A\f)' suffix]';
end