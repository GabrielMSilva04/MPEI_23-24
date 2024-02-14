function [keys] = keyGen(N,imin,imax,chars,probs)
    if nargin == 4
        probs = ones(1, length(chars)) / length(chars);
    end
    keys = {};
    cumulative_probabilities = cumsum(probs);
    
    % Generate each key
    for i=1:N
        key='';
        n = randi([imin, imax]);
        for j=1:n
            index = find(cumulative_probabilities >= rand(), 1);
            selected_character = chars(index);

            key=append(key,selected_character);
        end
        keys{i}=key;
    end
end