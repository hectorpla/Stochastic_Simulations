% exponential dist(X) conditioned on geometric dist(N)

n = 5;
t = 4;
lambda = 1;
% compute E(X^t)
fun = @(x) n * lambda * exp(-n * lambda * x) .* x.^(t);
fprintf('E(X^t): ');
disp( integral(fun, 0, inf) )

fprintf('E(X): ');
fun0 = @(x) n * lambda * exp(-n * lambda * x) .* x;
disp( integral(fun0, 0, inf) )