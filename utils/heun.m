function [t_h, u_h] = heun(f, t_max, y0, h)


t_h = 0:h:t_max;
u_h = zeros(1, length(t_h));

u_h(1) = y0;

for i=1:length(t_h)-1
    u_h(i + 1) = u_h(i) + h / 2 * (f(t_h(i), u_h(i)) + f(t_h(i+1), u_h(i) + h * f(t_h(i), u_h(i))));
end

end