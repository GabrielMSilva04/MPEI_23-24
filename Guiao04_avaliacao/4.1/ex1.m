%% a)
alphabetAZ='A':'Z';
alphabetaz='a':'z';

letras = [alphabetAZ,alphabetaz];
imin=6;
imax=20;
N=10^5;

[keysa]=keyGen(N,imin,imax,letras);

%% b)
alphabetaz='a':'z';

N=10^5;
letras = alphabetaz;
imin=6;
imax=20;

file = fopen('prob_pt.txt','r');
probs = fscanf(file,"%f");

[keysb]=keyGen(N,imin,imax,letras,probs);