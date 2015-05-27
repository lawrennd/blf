clear all
load test_3-Mar-97
tests=0;
for k=0:9
  eval(['tests=tests+size(data' int2str(k) '8, 1)-np' int2str(k) ';'])
end
nd=[4 24 64];
x=0;

lll=zeros(tests, 10);
for k=0:9
  eval(['data=data' int2str(k) '8;'])
  eval(['np=np' int2str(k) ';'])
  totaldata=size(data, 1);
  eval(['ntest' int2str(k) '=totaldata-np' int2str(k) ';'])
  for i=np+1:totaldata
    x=x+1;
    y=0;
    for j=0:9
      y=y+1;
      eval(['v=v' int2str(j) ';'])
      eval(['w=w' int2str(j) ';'])
      v(size(v, 2)-nd(3)+1:size(v,2))=data(i, :);
      v=mfupdate(w, nd, v, 1e-1);
      lll(x, y)=blfll(w, nd, v);
      %disp(lll(x,y))
    end
    disp(['Test number ' int2str(i-np) ', digit ' int2str(k) ' complete'])
  end
disp(['Test set for digit ' int2str(k) ' complete'])
end

mark1=ntest0      ; mark2=mark1+ntest1; mark3=mark2+ntest2; 
mark4=mark3+ntest3; mark5=mark4+ntest4; mark6=mark5+ntest5; 
mark7=mark6+ntest6; mark8=mark7+ntest7; mark9=mark8+ntest8; 
mark10=mark9+ntest9; 

target=zeros(size(lll, 1), 1);
target(1:mark1)=ones(ntest0, 1);
target(mark1+1:mark2)=ones(ntest1, 1)*2;
target(mark2+1:mark3)=ones(ntest2, 1)*3;
target(mark3+1:mark4)=ones(ntest3, 1)*4;
target(mark4+1:mark5)=ones(ntest4, 1)*5;
target(mark5+1:mark6)=ones(ntest5, 1)*6;
target(mark6+1:mark7)=ones(ntest6, 1)*7;
target(mark7+1:mark8)=ones(ntest7, 1)*8;
target(mark8+1:mark9)=ones(ntest8, 1)*9;
target(mark9+1:mark10)=ones(ntest9, 1)*10;