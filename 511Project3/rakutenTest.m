% x = randi(2e9, 1, 50);
x = rand(1, 50);
x = ceil((-log(1 - x)).^(1/2).* 1e8);
m = mean(x);
for i = 1 : size(x, 2);
    fprintf('%d,',x(i));
    if mod(i, 5) == 0
        fprintf('\n');
    end
    %disp(pr)
end

[C, I] = max(x - m);
I
x(I)
m