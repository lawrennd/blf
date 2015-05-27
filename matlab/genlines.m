function x=genlines(examples, noisechance)

%GENLINES Vertical line data set generator
%
%         Description
%         x=genlines(examples, noisechance)
%         This is a data generator which generates a data set of lines in a
%         4x4 grid forr use in testing the belief net system. examples is
%         the number of examples required in the data set, noisechance is
%         the percentage chance of any digit having bit-flipped noise.
%
%        See Also
%	 blf, blfll, blfgrad, blfpak, blfunpak
%

%	 Copyright (c) Neil D Lawrence (1997)


rand('seed',sum(100*clock))
vert_line=[1;1;1;1];
x=zeros(examples, 16);
for i=1:examples

y=zeros(4,4);
num=round(rand(1)*3)+1;
y(:, num)=vert_line;
flipbit=rand(size(y))<noisechance;
y=xor(y, flipbit);
x(i, :)=y(:)';

end