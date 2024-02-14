function isInFilter = checkBloomFilter(bloomFilter, item, k)
    item = char(item);
    % Check the item against all hash functions
    for i = 1:k
        item = [item num2str(i)]; %para string2hash

        %hashValue = DJB31MA(item,k);
        hashValue = string2hash(item,'djb2');

        % Convert the hash value to a valid index within the Bloom filter size
        index = mod(hashValue, length(bloomFilter)) + 1;  % +1 for 1-based indexing in MATLAB
        
        % Check the bit at the position indicated by the hash value
        % If any bit is not set, the item is definitely not in the set
        if bloomFilter(index) == 0
            break;  % until ( (i==k) | (B [h] == 0) )
        end
    end

    if i == k
        isInFilter = (bloomFilter(index) == 1);
    else
        isInFilter = false; 
    end
end