function bloomFilter = addToBloomFilter(bloomFilter, key, k) 
    % bloomfilter = array bloomfilter
    % k = number of hash functions
    % key = key to add
    % aplicar a funçao de dispersao ao elemento 
    n = length(bloomFilter);

    out = kHashValues(key,k);
    out = mod(out, n) + 1;

    for i = 1:k
        % incrementar a posição h do vetor -> filtro de Bloom com contagem
        bloomFilter(out(i)) = bloomFilter(out(i)) + 1;
    end
end