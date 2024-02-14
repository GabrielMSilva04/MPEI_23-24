n = 8000; %tamanho Bloom Filter
k = 4:10; %numero de hash funtions
P1 = zeros(1,length(k));
P2 = zeros(1,length(k));

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

%% start and fill BloomFilter
for i=1:length(k)
    fprintf('Numero de Hash Functions: %d\n', k(i));

    bloomFilter = initializeBloomFilter(8000);
    
    m = length(U1); %numero de elementos
    for l = 1:m
        % To add an item
        bloomFilter = addToBloomFilter(bloomFilter, U1(l), k(i));
    end

    positives = 0;
    % Check if line is in the filter
    for l=1:length(U2)
        isMember = checkBloomFilter(bloomFilter, U2(l), k(i));
        
        % Display the result
        if isMember
            positives = positives +1;
        end
    end

    p_fp_sim = positives/length(U2)*100;
    p_fp_teo = ((1 - exp(-k(i)*m/n))^k(i))*100;

    fprintf('Percentagem simulada de falsos positivos na outra lista: %.2f%%\n',p_fp_sim);
    fprintf('Percentagem teórica de falsos positivos na outra lista: %.2f%%\n\n',p_fp_teo);
    P1(i) = p_fp_sim;
    P2(i) = p_fp_teo;
end

%% Gerar gráfico de pfp em função de k
hold on
plot(k,P1,'o--');
plot(k,P2,'o--');
legend("simulada","teórica")
hold off
title("Percentagem de falsos positivos")
xlabel("k - Número de Hash Functions")