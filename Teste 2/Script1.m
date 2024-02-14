load("turistas1.data")
rest = readcell('restaurantes.txt','Delimiter','\t');

Nu = length(unique(turistas1(:,1)));


[Set, turistas] = createTouristSet(turistas1);
save("RestaurantsByUser.mat","Set");

k = 200;
dists = MinHashCalculation(Set, k);
save("distanciasUsers.mat","dists")



% opcao 5
m = length(rest(:,1));
p = 0.01;
n = round(- (m * log(p)) / (log(2)^2));
k = round((n * log(2)) / m);

% inicializar o Filtro de Bloom
BloomFilter = initializeBloomFilter(n);
            
% inserir todas as avalições no filtro
for i = 1:size(turistas1, 1)
    idRestaurante = turistas1(i, 2); 
    BloomFilter = addToBloomFilter(BloomFilter, idRestaurante, k);
end
save("BloomFilter.mat","BloomFilter")

