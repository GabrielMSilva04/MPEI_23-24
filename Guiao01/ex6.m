%% Codigo 2- ca´lculo analı´tico de probabilidade em se´ries experieˆncias de Bernoulli
% Dados relativos ao problema 1
p = 0.5;
k = 2; %n de acontecimentos
n = 3; %repeticoes
prob= nchoosek(n,k)*p^k*(1-p)^(n-k); % nchoosek(n,k)= n!/(n-k)!/k!

disp(prob)