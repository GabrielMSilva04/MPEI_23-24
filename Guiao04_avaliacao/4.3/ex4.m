[Set, users] = createMovieSet('u.data');

% Define o número de HashFunctions para MinHash
k_values = [50, 100, 200];

% Inicializa uma estrutura para guardar os resultados
results = struct();

threshold = 0.4;
for k = 1:length(k_values)
    tic
    % Chama a função MinHashCalculation com o valor atual de k
    SimilarUsers = MinHashCalculation(Set, k_values(k), threshold);
    
    % Armazena os resultados
    results(k).SimilarUsers = SimilarUsers;

    toc
    fprintf("Número de pares com distancias inferiores ao limiar a partir de %d HashFunctions: %d\n", k_values(k), length(SimilarUsers(:,1)))
end