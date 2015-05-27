% This is an attempt to evaluate the advantages of modeling the joint
% probability distribution, due to the capabilities of using unlabelled
% data. The network is being designed to classify between twos and threes,
% this is a problem that Hinton & Ghanarami studied in Hierachical community
% of experts.

clear all
target=[];
data=[];
rand('seed',0) 
randn('seed', 0)
for i=2:3
  eval(['load /user/cs_neural/lawrennd/MIT/digits/vs4tr' num2str(i)])  
  targetvector=ones(size(a, 1), 1)*i-2;% Create a target vector
  targetvector(1:floor(size(a, 1)/2))= ...
      ones(floor(size(a, 1)/2), 1)*2; 	% Assign half as unknown
  targetvector=reorder(targetvector);           % Re-order the target
  target=[target; targetvector];
  data=[data; a];
end
rand('seed', 0)
randn('seed', 0)
[wun, nd, vun, llsun]=blftest190897(data, target, 5);
eval(['save unsuptrain_' date ' wun nd vun llsun target data'])
rand('seed', 0)
randn('seed', 0)
supervised=find(target-2);
datasup=data(supervised, :);
targetsup=target(supervised, :);
[wsup, nd, vsup, llssup]=blftest190897(datasup, targetsup, 5);
eval(['save suptrain_' date ' wsup nd vsup llssup targetsup datasup'])
load /user/cs_neural/lawrennd/MIT/digits/vs4testdata

tests=0;
for k=2:3
  eval(['tests=tests+size(testdata' int2str(k) ', 1);'])
end
nd=[1 30 64];
x=0;
maxiter=10; 				% Maximum passes through algotrithm
linemintol=0.01; 			% tolerance criteria in linemin
percoflll=0.01; 			% % change in lll for stop
display=0;
options(14)=maxiter;
options(3)=percoflll;
options(4)=linemintol;
options(1)=display;           
options(15)=1; 			        % Update mu in first row? yes

classun=zeros(tests, 1);
for k=2:3
  eval(['data=testdata' int2str(k) ';'])

  totaldata=size(data, 1);
  eval(['ntest' int2str(k) '=totaldata;'])
  for i=1:totaldata
    x=x+1;
    v=vun; v(2)=0.5;
    v(size(v, 2)-nd(3)+1:size(v,2))=data(i, :);
    v=mfupdateopt(wun, nd, v, 1e-1, options);
      
    classun(x)=v(2);
    
    %disp(['Test number ' int2str(i) ', digit ' int2str(k) ' complete'])
  end
disp(['Test set for digit ' int2str(k) ' complete'])
end


classsup=zeros(tests, 1);
for k=2:3
  eval(['data=testdata' int2str(k) ';'])

  totaldata=size(data, 1);
  eval(['ntest' int2str(k) '=totaldata;'])
  for i=1:totaldata
    x=x+1;
    v=vsup; v(2)=0.5;
    v(size(v, 2)-nd(3)+1:size(v,2))=data(i, :);
    v=mfupdateopt(wsup, nd, v, 1e-1, options);
      
    classsup(x)=v(2);
    
    %disp(['Test number ' int2str(i) ', digit ' int2str(k) ' complete'])
  end
disp(['Test set for digit ' int2str(k) ' complete'])
end
save fulltest
eval(['save fulltest_' date ' wun wsup nd vun vsup llssup llsun targetsup target datasup data classsup classun'])
save backupsave


