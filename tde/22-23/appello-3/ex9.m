% Si consideri una funzione f ∈ C∞(R), dotata di uno zero sempice α. Si supponga di
% approssimare α tramite il metodo di Newton e che all’iterata k-esima sia associato
% l’errore ∣x(k) − α∣ = 0.1. Assumendo che ∣x(k+1) − α∣ = 0.005, si riporti il valore
% stimato dell’error ∣x(k+2) − α∣

% zero semplice => f'(alpha) != 0 => convergenza quadratica
% |x(k+1) - alpha| = (|x(k) - alpha|)^p * 1/p! * df_p(f)(alpha)

err0 = 0.1;
err1 = 0.005;

df_p = err1 / err0^2 * factorial(2);

err2 = err1^2 * 1/factorial(2) * df_p;

disp(err2);


