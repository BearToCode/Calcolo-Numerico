function use_checks = check()
  use_checks = ~exist('DISABLE_CHECKS', 'var');
end