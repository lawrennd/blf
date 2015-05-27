close
testllsup1=testllsup(1:400); testllsup4=testllsup(401:800);
[a, c]=hist(testllsup1(find(classsup(1:400)<.5))/(64*log(2))); 
subplot(2,2,1)
hist(testllsup1(find(classsup(1:400)<.5))/(64*log(2)), c);
meanit=mean(testllsup1(find(classsup(1:400)<.5))/(64*log(2)));
title('2s classified as 2s', 'FontSize', 12, 'FontName', 'times')
xlabel(['mean ' num2str(meanit)], 'FontSize', 12, 'FontName', 'times')
set(gca, 'FontSize', 12, 'FontName', 'times')
subplot(2,2,3)
hist(testllsup4(find(classsup(401:800)<.5))/(64*log(2)), c);
meanit=mean(testllsup4(find(classsup(401:800)<.5))/(64*log(2)));
title('3s classified as 1s', 'FontSize', 12, 'FontName', 'times')
xlabel(['mean ' num2str(meanit)], 'FontSize', 12, 'FontName', 'times')
set(gca, 'FontSize', 12, 'FontName', 'times')
subplot(2,2,2)
hist(testllsup1(find(classsup(1:400)>.5))/(64*log(2)), c);
meanit=mean(testllsup1(find(classsup(1:400)>.5))/(64*log(2)));
title('2s classified as 3s', 'FontSize', 12, 'FontName', 'times')
xlabel(['mean ' num2str(meanit)], 'FontSize', 12, 'FontName', 'times')
set(gca, 'FontSize', 12, 'FontName', 'times')
subplot(2,2,4)
hist(testllsup4(find(classsup(401:800)>.5))/(64*log(2)), c);
meanit=mean(testllsup4(find(classsup(401:800)>.5))/(64*log(2)));
title('3s classified as 3s', 'FontSize', 12, 'FontName', 'times')
xlabel(['mean ' num2str(meanit)], 'FontSize', 12, 'FontName', 'times')
set(gca, 'FontSize', 12, 'FontName', 'times')
figure
testllun1=testllun(1:400); testllun4=testllun(401:800);
[a, c]=hist(testllun1(find(classun(1:400)<.5))/(64*log(2))); 
subplot(2,2,1)
hist(testllun1(find(classun(1:400)<.5))/(64*log(2)), c);
meanit=mean(testllun1(find(classun(1:400)<.5))/(64*log(2)));
title('2s classified as 2s', 'FontSize', 12, 'FontName', 'times')
xlabel(['mean ' num2str(meanit)], 'FontSize', 12, 'FontName', 'times')
set(gca, 'FontSize', 12, 'FontName', 'times')
subplot(2,2,3)
hist(testllun4(find(classun(401:800)<.5))/(64*log(2)), c);
meanit=mean(testllun4(find(classun(401:800)<.5))/(64*log(2)));
title('3s classified as 2s', 'FontSize', 12, 'FontName', 'times')
xlabel(['mean ' num2str(meanit)], 'FontSize', 12, 'FontName', 'times')
set(gca, 'FontSize', 12, 'FontName', 'times')
subplot(2,2,2)
hist(testllun1(find(classun(1:400)>.5))/(64*log(2)), c);
meanit=mean(testllun1(find(classun(1:400)>.5))/(64*log(2)));
title('2s classified as 3s', 'FontSize', 12, 'FontName', 'times')
xlabel(['mean ' num2str(meanit)], 'FontSize', 12, 'FontName', 'times')
set(gca, 'FontSize', 12, 'FontName', 'times')
subplot(2,2,4)
hist(testllun4(find(classun(401:800)>.5))/(64*log(2)), c);
meanit=mean(testllun4(find(classun(401:800)>.5))/(64*log(2)));
title('3s classified as 3s', 'FontSize', 12, 'FontName', 'times')
xlabel(['mean ' num2str(meanit)], 'FontSize', 12, 'FontName', 'times')
set(gca, 'FontSize', 12, 'FontName', 'times')

