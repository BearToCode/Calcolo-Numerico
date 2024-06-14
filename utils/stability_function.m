function R = stability_function(method)
%% STABILITY_FUNCTION  Ritorna la funzione di stabilità per il metodo dato
% Metodi supportati:
% - Eulero in avanti: "eulerfwd"
% - Eulero all'indietro: "eulerbkw"
% - Heun: "heun"
% - Cranck-Nicolson: "cn"
% - Runge-Kutta: "rk#", con # sostituito con il numero di passi fino a 4

if strcmp(method, "eulerfwd")
    R = @(z) 1 + z;
elseif strcmp(method, "eulerbkw")
    R = @(z) 1 ./ (1 - z);
elseif strcmp(method, "heun")
    R = @(z) 1 + z + z.^2 / 2;
elseif strcmp(method, "cn")
    R = @(z) (1 + z / 2) ./ (1 - z / 2);
elseif startsWith(method, "rk")
    p = str2double(method(3:end));
    if p < 1 || p > 4
        error("Ordine del metodo Runge-Kutta non supportato");
    end
    R = @(z) sum(arrayfun(@(k) z.^k / factorial(k), 0:p));
else
    error("Metodo non supportato");
end

end