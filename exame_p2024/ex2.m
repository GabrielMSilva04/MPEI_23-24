clear all

load input.mat

k = 4;
n = 500;


% a)
dimensao = length(unique(list));

bloomFilter = initializeBloomFilter(n);

for i = 1:length(list)
    bloomFilter = addToBloomFilter(bloomFilter,list{i},k);
end

nAval = checkBloomFilter(bloomFilter, 'Adão', k);

fprintf("Vezes em que Adão é detetado: %d\n", nAval)


% b)
Detecoes = [0 0 0 0];

for i = 1:length(extra)
    nAval = checkBloomFilter(bloomFilter, extra{i}, k);
    if nAval > 2
        Detecoes(4) = Detecoes(4) + 1;
    else
        Detecoes(nAval + 1) = Detecoes(nAval + 1) + 1;
    end
end

Probs = Detecoes/length(extra);

fprintf("igual a 0: %f\n", Probs(1));
fprintf("igual a 1: %f\n", Probs(2));
fprintf("igual a 2: %f\n", Probs(3));
fprintf("igual a 3 ou mais: %f\n", Probs(4));