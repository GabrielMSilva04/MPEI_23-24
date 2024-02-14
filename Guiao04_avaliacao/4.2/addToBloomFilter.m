function bloomFilter = addToBloomFilter(bloomFilter, key, k)
    % k = number of hash functions
    key = char(key);
    % Loop through each hash function
    for i = 1:k
        % Compute the hash value for the item using the i-th hash function
        key = [key num2str(i)]; %para string2hash

        %hashValue = DJB31MA(item,k);
        hashValue = string2hash(key,'djb2');

        % Convert the hash value to a valid index within the Bloom filter size
        index = mod(hashValue, length(bloomFilter)) + 1;  % +1 for 1-based indexing in MATLAB
        
        % Set the bit at the computed index to 1
        bloomFilter(index) = true;
    end
end