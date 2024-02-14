function h = hf(type, key, size)
    % type = is the function you want to use
    % key = string to hash
    % size = size of the table
    switch type
        case 1
            h = mod(string2hash(key,'djb2'),size)+1;
        case 2
            h = mod(string2hash(key,'sdbm'),size)+1;
        case 3
            h = hashstring(key,size)+1;
        case 4
            h = mod(DJB31MA(key,5381),size)+1;
        otherwise
    end
end