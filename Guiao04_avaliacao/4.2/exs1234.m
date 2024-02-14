%% (1.) Filling bloomFilter
n = 8000; %tamanho Bloom Filter
k = 3; %numero de hash funtions

% Open the file
fileid = fopen('wordlist-preao-20201103.txt', 'r');

% Check if the file was opened successfully
if fileid == -1
    error('Failed to open the file.');
end

% gerar U1 e U2
U1 = cell(1000, 1);
U2 = cell(10000, 1);

for i = 1:1000 %store 1-1000 lines in U1
    line = fgets(fileid);
    line = strtrim(line);
    if line == -1  % Check if end of file has been reached
        break;
    end
    U1{i} = line;
end

for i = 1:10000 %store 1000-11000 lines in U2
    line = fgets(fileid);
    line = strtrim(line);
    if line == -1  % Check if end of file has been reached
        break;
    end
    U2{i} = line;
end

% Close the file
fclose(fileid);


% start and fill BloomFilter
bloomFilter = initializeBloomFilter(8000);

m = length(U1); %numero de elementos
for l = 1:m
    % To add an item
    bloomFilter = addToBloomFilter(bloomFilter, U1(l), k);
end

%% (2.) Checking the same list U1
negatives = 0;
% Check if line is in the filter
for l=1:m
    isMember = checkBloomFilter(bloomFilter, U1(l), k);
    
    % Display the result
    if ~isMember
        negatives = negatives +1;
    end
end
    
fprintf('Falsos negativos na mesma lista: %d\n', negatives);

%% (3.) Checking other list U2
positives = 0;
% Check if line is in the filter
for l=1:length(U2)
    isMember = checkBloomFilter(bloomFilter, U2(l), k);    
    % Display the result
    if isMember
        positives = positives +1;
    end
end

fprintf('Percentagem de falsos positivos na outra lista: %.2f%%\n', positives/length(U2)*100);

%% (4.) Valor teórico da percentagem de falsos positivos
p_fp = (1 - exp(-k*m/n))^k; % valor teorico de p falsos positivos
fprintf('Percentagem teórica de falsos positivos: %.2f%%\n', p_fp*100);
fprintf('Diferença entre percentagens: %.2f\n', abs(positives/length(U2) - p_fp)*100);
