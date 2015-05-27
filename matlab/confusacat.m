function [MYC, MYall, JJC, JJall]=confusacat(lll, true_class)

% CONFUSACAT For creating a confusion matrix from a matrix for a belief net
%
%    Description
%    [MYC, MYall, JJC, JJall]=confusacat(lll, true_class), named after the
%    famous monty python sketch, this routine takes the lll matrix output
%    from a test and creates a confusion matrix using this and the target
%    values. THe lll matrix is the matrix of log-likelihood values output
%    from each of the ten different models, and thus may be used for
%    classification. The routine also gives one the pleasure of showing Saul
%    Jordan and Jaakola's results so that one may see just how poorly one is
%    doing.
%
%    See Also

%    Copyright Neil D Lawrence 1997
% Jordan and Jaakola's results

JJC=[388     2     2     0     1     3     0     0     4     0; ...
    0   393     0     0     0     1     0     0     6     0; ...
    1     2   376     1     3     0     4     0    13     0; ...
    0     2     4   373     0    12     0     0     6     3; ...
    0     0     2     0   383     0     1     2     2    10; ...
    0     2     1    13     0   377     2     0     4     1; ...
    1     4     2     0     1     6   386     0     0     0; ...
    0     1     0     0     0     0     0   388     3     8; ...
    1     9     1     7     0     7     1     1   369     4; ...
    0     4     0     0     0     0     0     8     5   383];

JJall=[-.447; -.296; -.636; -.583; -.574; -.565; -.515; -.434; -.569; -.495];

[crap, pred_class]=max(lll');
pred_class=pred_class';


pred_class=pred_class;
true_class=true_class;

MYC=zeros(max(pred_class(:)));

for j=1:max(size(pred_class(:)))
  MYC(true_class(j), pred_class(j))=MYC(true_class(j), pred_class(j))+1;
end

MYall=zeros(size(JJall));
for i=1:10
  MYall(i)=sum(lll((i-1)*400+1:i*400, i))/(400*log(2)*64);
end

subplot(2, 2, 1);
matplot(JJC);
title('Confusion Matrix from Saul, Jaakolaa & Jordan')
subplot(2,2,2);
matplot(MYC);
title('Our Confusion Matrix')
subplot(2,2,3)
pltmat(JJC, '', [0, 0, 1], 6)
subplot(2,2,4)
pltmat(MYC, '', [0, 0, 1], 6)