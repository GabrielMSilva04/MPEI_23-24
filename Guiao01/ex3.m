N=10000;
n = 15;
prob= 0.5;
caras= 6;

lancamentos=rand(n,N);
totalcaras=lancamentos>0.5;
sucessos=sum(totalcaras)==caras;
probSimulacao= sum(sucessos)/N;

disp(probSimulacao)