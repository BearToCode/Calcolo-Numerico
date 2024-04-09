function [] = dfs(f, sym, n)
  d = f;

  for i = 2:n+1
    d = [d diff(d(i-1), sym)];
    fprintf("f^(%d) = %s\n", i - 1, char(simplify(d(i))));
  end

  % Display all the derivatives using latex
  figure;
  for i = 1:n+1
    text(0.1, i * 0.1, "$f^{("+ num2str(i - 1)+ ")} = " + latex(simplify(d(i))) + "$", 'Interpreter', 'latex', 'FontSize', 15);
  end
end