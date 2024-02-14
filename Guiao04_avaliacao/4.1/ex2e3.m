% 2
%% keyGen
alphabetAZ='A':'Z';
alphabetaz='a':'z';

letras = [alphabetAZ,alphabetaz];
imin=6;
imax=20;
N=10^5;
[keys]=keyGen(N,imin,imax,letras);

%% simulação
size = [5e5 1e6 2e6];
type = 1; %tipo de hash function a ser usada

for i=1:length(size)
    tic
    hash = zeros(1,length(keys));
    atribuicoes = zeros(1,size(i));
    for j=1:length(keys)
        hash(j) = hf(type, char(keys(j)), size(i));
        atribuicoes(hash(j)) = atribuicoes(hash(j))+1;
    end

    % Display HashTable size
    fprintf('HashTable size: %d\n\n', size(i));
    
    
    % 3.
    %  a)
    %   i) histograma com 100 intervalos
    figure(i)
    histogram(hash,100)

    %   ii)
    %    Normalize the hashcodes
    normalized_hashcodes = hash / size(i);
    
    %    Calculate the empirical moments
    moment2 = mean(normalized_hashcodes .^ 2);
    moment5 = mean(normalized_hashcodes .^ 5);
    moment10 = mean(normalized_hashcodes .^ 10);
    
    %    Calculate the theoretical moments for a uniform distribution
    theoretical_moment2 = 1 / (2 + 1);
    theoretical_moment5 = 1 / (5 + 1);
    theoretical_moment10 = 1 / (10 + 1);
    
    %    Display the results
    fprintf('Empirical 2nd moment: %f\n', moment2);
    fprintf('Theoretical 2nd moment: %f\n\n', theoretical_moment2);
    
    fprintf('Empirical 5th moment: %f\n', moment5);
    fprintf('Theoretical 5th moment: %f\n\n', theoretical_moment5);
    
    fprintf('Empirical 10th moment: %f\n', moment10);
    fprintf('Theoretical 10th moment: %f\n\n', theoretical_moment10);

    %  b)
    colisions = sum(atribuicoes>1);
    fprintf('N de colisões: %d\n', colisions);
    fprintf('N máximo de atribuições: %d\n', max(atribuicoes));
    
    %  c)
    fprintf('Tempo de execução: %f\n', toc);
    fprintf('----------------------------------\n');
end

