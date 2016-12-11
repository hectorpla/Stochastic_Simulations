p = pi / 4;
n = 5000;
sum = 0;

for i = 1 : n
    tmp = p * 2;
    count = 1;
    while floor(tmp) == (randi(2,1,1) - 1)
        tmp = 2 * (tmp - floor(tmp));
        count = count + 1;
    end
    sum = sum + count;
end

sum / n
