nd=[1 30 64];
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
classun=zeros(tests, 1);
for k=2:3
  eval(['data=testdata' int2str(k) ';'])

  totaldata=size(data, 1);
  eval(['ntest' int2str(k) '=totaldata;'])
  for i=1:totaldata
    x=x+1;
    v=rand(size(vun)); v(2)=0.5;
    v(size(v, 2)-nd(3)+1:size(v,2))=data(i, :);
    v=mfupdateopt(wun, nd, v, 1e-1, options);
      
    classun(x)=v(2);
    
    %disp(['Test number ' int2str(i) ', digit ' int2str(k) ' complete'])
  end
disp(['Test set for digit ' int2str(k) ' complete'])
end

x=0;

classsup=zeros(tests, 1);
for k=2:3
  eval(['data=testdata' int2str(k) ';'])

  totaldata=size(data, 1);
  eval(['ntest' int2str(k) '=totaldata;'])
  for i=1:totaldata
    x=x+1;
    v=rand(size(vsup)); v(2)=0.5;
    v(size(v, 2)-nd(3)+1:size(v,2))=data(i, :);
    v=mfupdateopt(wsup, nd, v, 1e-1, options);
      
    classsup(x)=v(2);
    
    %disp(['Test number ' int2str(i) ', digit ' int2str(k) ' complete'])
  end
disp(['Test set for digit ' int2str(k) ' complete'])
end
eval(['save fulltest_' date ' wun wsup nd vun vsup llssup llsun targetsup target datasup data classsup classun'])
save backupsave

