% 5.86 Mixed distribution test

E = exprnd(.5, 10000, 1);
G = 1 + randn(10000, 1);
var([E; G])
