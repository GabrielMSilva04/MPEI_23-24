tic
% Marcar o tempo de CPU no início
startTime = cputime;

[Set, users] = createMovieSet('u.data');

%% Calcular a distância de Jaccard entre todos os pares
dJ = calcDistancesJ(Set, users);


% Determina pares com distância inferior a um limiar pré-definido
threshold = 0.4; % limiar de decisão
SimilarUsers = findSimilar(dJ,threshold,users);


fprintf("Número de pares com distancias inferiores ao limiar: %d\n",length(SimilarUsers(:,1)))
save SimilarUsers.mat

toc
% Marcar o tempo de CPU após a execução do código
endTime = cputime;
fprintf("Cpu time: %f seconds\n",endTime-startTime);
%fprintf("etime: %f\n",etime());