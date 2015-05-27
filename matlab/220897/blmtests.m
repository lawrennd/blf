% function blmtests

mixn=2;
load /user/cs_neural/lawrennd/MIT/digits/vs4testdata
load fulltest_23-Aug-97
netun=blftoblm(wun, nd, vun, mixn);
netsup=blftoblm(wsup, nd, vsup, mixn); 

tests=0;
for k=2:3
  eval(['tests=tests+size(testdata' int2str(k) ', 1);'])
end

maxiter=10; 				% Maximum passes through algotrithm
linemintol=0.01; 			% tolerance criteria in linemin
percoflll=0.01; 			% % change in lll for stop
display=0;
options(14)=maxiter;
options(3)=percoflll;
options(4)=linemintol;
options(1)=display;           
options(15)=1; 			        % Update mu in first row? yes

x=0;
mclassun=zeros(tests, 1);
mtestllun=zeros(tests, 1);
for k=2:3
  eval(['data=testdata' int2str(k) ';'])

  totaldata=size(data, 1);
  eval(['ntest' int2str(k) '=totaldata;'])
  for i=1:totaldata
    x=x+1;
    net=blm(1, 30, 64, mixn);
    netun.mf=net.mf;
    netun.mix=net.mix;
    netun.mf.mu1(:, :, :)=nrepmat(.5 ,3, mixn);
    netun.mf.mu3(:,:,:)=nrepmat(data(i,:), 3, mixn);
    
    netun=mmfupdateopt(netun, options);
      
    mclassun(x)=sum(netun.mix.coeff.*squeeze(netun.mf.mu1));
    mtestllun(x)=blmmixb(netun);
    %disp(['Test number ' int2str(i) ', digit ' int2str(k) ' complete'])
  end
disp(['Test set for digit ' int2str(k) ' complete'])
end

x=0;
mclasssup=zeros(tests, 1);
mtestllsup=zeros(tests, 1);
for k=2:3
  eval(['data=testdata' int2str(k) ';'])

  totaldata=size(data, 1);
  eval(['ntest' int2str(k) '=totaldata;'])
  for i=1:totaldata
    x=x+1;
    net=blm(1, 30, 64, mixn);
    netsup.mf=net.mf;
    netsup.mix=net.mix;
    netsup.mf.mu1(:, :, :)=nrepmat(.5 ,3, mixn);
    netsup.mf.mu3(:,:,:)=nrepmat(data(i,:), 3, mixn);
    
    netsup=mmfupdateopt(netsup, options);
      
    mclasssup(x)=sum(netsup.mix.coeff.*squeeze(netsup.mf.mu1));
    mtestllsup(x)=blmmixb(netsup);
    %disp(['Test number ' int2str(i) ', digit ' int2str(k) ' complete'])
  end
disp(['Test set for digit ' int2str(k) ' complete'])
end

eval(['save mixtest_' date ' mclassun mclasssup mtestllun mtestllsup netun netsup'])
save backupsave
