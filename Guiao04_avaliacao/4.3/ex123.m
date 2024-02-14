tic
[Set, users] = createMovieSet('u.data');

%% Calcula a distância de Jaccard entre todos os pares pela definição.
dJ = calcDistancesJ(Set, users);


%% Com base na distância, determina pares com
% distância inferior a um limiar pré-definido
threshold = 0.4; % limiar de decisão
SimilarUsers = findSimilar(dJ,threshold,users);


fprintf("Número de pares com distancias inferiores ao limiar: %d\n",length(SimilarUsers(:,1)))
save SimilarUsers.mat
toc
