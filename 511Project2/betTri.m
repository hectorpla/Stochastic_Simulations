function y = betTri(x)

y = zeros(size(x));

bet = find(x > 0 & x <=1);
betDis = makedist('Beta', 'a', 8, 'b', 5);
y(bet) = .5 * pdf(betDis,x(bet));

tri1 = find(x > 4 & x <= 5);
y(tri1) = .5 * (x(tri1) - 4);

tri1 = find(x > 5 & x <= 6);
y(tri1) = -.5 * (x(tri1) - 6);
end