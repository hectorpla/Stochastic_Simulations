% costume gaussian dist

function y = g1(x)
% every call calls gmdistribution, problemetic
dis = gmdistribution([2; 4.6; 7.8], cat(3, .5, .5, .5), [.3, .4, .4]);
y = pdf(dis, x);
end