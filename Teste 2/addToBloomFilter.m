function bloomFilter = addToBloomFilter(bloomFilter, key, k) 
    % bloomfilter = array bloomfilter
    % k = number of hash functions
    % key = key to add
    for i = 1:k
        % aplicar a funçao de dispersao ao elemento 
        h = hashFunction(key, i, length(bloomFilter));
        % incrementar a posição h do vetor -> filtro de Bloom com contagem
        bloomFilter(h) = bloomFilter(h) + 1;
    end
end