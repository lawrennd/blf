close
mtestllsup1=mtestllsup(1:400); mtestllsup4=mtestllsup(401:800);
[a, c]=hist(mtestllsup1(find(mclasssup(1:400)<.5))/(64*log(2))); 
subplot(2,2,1)
hist(mtestllsup1(find(mclasssup(1:400)<.5))/(64*log(2)), c);
meanit=mean(mtestllsup1(find(mclasssup(1:400)<.5))/(64*log(2)));
title('2s classifed as 2s', 'FontSize', 12, 'FontName', 'times')
xlabel(['mean ' num2str(meanit)], 'FontSize', 12, 'FontName', 'times')
set(gca, 'FontSize', 12, 'FontName', 'times')
subplot(2,2,3)
hist(mtestllsup4(find(mclasssup(401:800)<.5))/(64*log(2)), c);
meanit=mean(mtestllsup4(find(mclasssup(401:800)<.5))/(64*log(2)));
title('3s classifed as 2s', 'FontSize', 12, 'FontName', 'times')
xlabel(['mean ' num2str(meanit)], 'FontSize', 12, 'FontName', 'times')
set(gca, 'FontSize', 12, 'FontName', 'times')
subplot(2,2,2)
hist(mtestllsup1(find(mclasssup(1:400)>.5))/(64*log(2)), c);
meanit=mean(mtestllsup1(find(mclasssup(1:400)>.5))/(64*log(2)));
title('2s classifed as 3s', 'FontSize', 12, 'FontName', 'times')
xlabel(['mean ' num2str(meanit)], 'FontSize', 12, 'FontName', 'times')
set(gca, 'FontSize', 12, 'FontName', 'times')
subplot(2,2,4)
hist(mtestllsup4(find(mclasssup(401:800)>.5))/(64*log(2)), c);
meanit=mean(mtestllsup4(find(mclasssup(401:800)>.5))/(64*log(2)));
title('3s classifed as 3s', 'FontSize', 12, 'FontName', 'times')
xlabel(['mean ' num2str(meanit)], 'FontSize', 12, 'FontName', 'times')
set(gca, 'FontSize', 12, 'FontName', 'times')
figure
mtestllun1=mtestllun(1:400); mtestllun4=mtestllun(401:800);
[a, c]=hist(mtestllun1(find(mclassun(1:400)<.5))/(64*log(2))); 
subplot(2,2,1)
hist(mtestllun1(find(mclassun(1:400)<.5))/(64*log(2)), c);
meanit=mean(mtestllun1(find(mclassun(1:400)<.5))/(64*log(2)));
title('2s classifed as 2s', 'FontSize', 12, 'FontName', 'times')
xlabel(['mean ' num2str(meanit)], 'FontSize', 12, 'FontName', 'times')
set(gca, 'FontSize', 12, 'FontName', 'times')
subplot(2,2,3)
hist(mtestllun4(find(mclassun(401:800)<.5))/(64*log(2)), c);
meanit=mean(mtestllun4(find(mclassun(401:800)<.5))/(64*log(2)));
title('3s classifed as 2s', 'FontSize', 12, 'FontName', 'times')
xlabel(['mean ' num2str(meanit)], 'FontSize', 12, 'FontName', 'times')
set(gca, 'FontSize', 12, 'FontName', 'times')
subplot(2,2,2)
hist(mtestllun1(find(mclassun(1:400)>.5))/(64*log(2)), c);
meanit=mean(mtestllun1(find(mclassun(1:400)>.5))/(64*log(2)));
title('2s classifed as 3s', 'FontSize', 12, 'FontName', 'times')
xlabel(['mean ' num2str(meanit)], 'FontSize', 12, 'FontName', 'times')
set(gca, 'FontSize', 12, 'FontName', 'times')
subplot(2,2,4)
hist(mtestllun4(find(mclassun(401:800)>.5))/(64*log(2)), c);
meanit=mean(mtestllun4(find(mclassun(401:800)>.5))/(64*log(2)));
title('3s classifed as 3s', 'FontSize', 12, 'FontName', 'times')
xlabel(['mean ' num2str(meanit)], 'FontSize', 12, 'FontName', 'times')
set(gca, 'FontSize', 12, 'FontName', 'times')

