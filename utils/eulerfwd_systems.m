function [t_h, u_h] = eulerfwd_systems(f, tv, y0, Nh)
t0 = tv(1);
tf = tv(2);

t_h   = linspace(t0, tf, Nh+1);
N_len = length(t_h);
u_h   = zeros(length(y0), N_len);

h = (tf - t0) / Nh;

u_h(:, 1) = y0;
for i=1:N_len-1
    u_h(:, i + 1) = u_h(:, i) + h * f(t_h(i), u_h(:, i));
end

end