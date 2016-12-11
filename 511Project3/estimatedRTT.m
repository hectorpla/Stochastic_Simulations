alpha = 0.125;
beta = 0.25;

sample = [106 120 140 90 115];

est = zeros(1, 5);
est(1) = sample(1) * alpha + 100 * (1 - alpha);
for i = 2 : 5
    est(i) = sample(i) * (alpha) + est(i - 1) * (1 - alpha);
end

dev = zeros(1, 5);
dev(1) = abs(sample(1) - est(1)) * beta + 5 * (1 - beta);
for i = 2 : 5
    dev(i) = abs(sample(i) - est(i)) * beta + dev(i - 1) * (1 - beta);
end


interval = zeros(1, 5);
for i = 1 : 5
    interval(i) = est(i) + 4 * dev(i);
end
