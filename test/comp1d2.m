Nlist = 2.^(7:17);

timNUFFTFact = zeros(size(Nlist));
timNUFFTApp = zeros(size(Nlist));
timNUFFTAppold = zeros(size(Nlist));
timNUFFTAppnyu=zeros(size(Nlist));
timeM=zeros(size(Nlist));
errNUFFT = zeros(size(Nlist));
errNUFFT1 = zeros(size(Nlist));
tol=1e-12;
num = 150;
iflag=-1;

for it = 1:length(Nlist)
    
    N = Nlist(it);
    
    x=sort(N*rand(N,1));
    x1=2*pi*x/N;
    
    tic;
    
    nufftfun = nufftII(x,iflag,N,13,tol);
    
    timNUFFTFact(it) = toc;
    
    c=rand(N,1);
    
    tic;
    for cnt = 1:num
    nufftc = nufftfun(c);
    end
    timNUFFTApp(it) = toc/num;
    
    %for cnt = 1:num
    %nufftfun = nufftIIold(x,iflag,N,15,tol);
    %end
    %timNUFFTFact(it) = toc/num;
    
    %tic;
    %for cnt = 1:num
    %nufftc1 = nufftfun(c);
    %end
    %timNUFFTAppold(it) = toc/num;
%    tic;
%    for cnt = 1:num
%    fk=zeros(N,1)+1i*zeros(N,1);
%    ier=0;
%   nufft1d_demof90(N, x1, c, iflag, tol, N,fk,ier);
    %fk=nufft1d1(N,x1,c,-1,tol,N)*N;
    %fk=fftshift(fk);
%    end
%    timNUFFTAppnyu(it)=toc/num;
    
    
    k=0:(N-1);
    k = k(:);
    [fhatM,ffun] = DeCom_NUFFT1D_II(c,x/N,k,tol);
    tic;
    for cnt = 1:num
        fhatM = ffun(c);
    end
    timeM(it) = toc/num;
    
    
    errNUFFT(it)=norm(nufftc-fhatM,2)/norm(nufftc,2);
    %errNUFFT1(it)=norm(nufftc1-fhatM,2)/norm(nufftc1,2);
end

timNUFFTApp
%timNUFFTAppold
%timNUFFTAppnyu
timeM
errNUFFT,
%errNUFFT1
%timecomp=timeM./timNUFFTAppnyu
fid=fopen('./result1d1/time1d1YH.mat','at');
fprintf(fid,'% -f\n',timeM);
fclose(fid);
%fid=fopen('./result1d1/time1d1LRold.mat','at');
%fprintf(fid,'% -f\n',timNUFFTAppold);
%fclose(fid);
%fid=fopen('./result1d1/time1d1NYU.mat','at');
%fprintf(fid,'% -f\n',timNUFFTAppnyu);
%fclose(fid);
fid=fopen('./result1d1/time1d1LR.mat','at');
fprintf(fid,'% -f\n',timNUFFTApp);
fclose(fid);