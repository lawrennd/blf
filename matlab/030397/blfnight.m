clear all

for i=0:9
  load ../../digits/digidata
  eval(['data=reorder(data' num2str(i) '8);'])
  npatterns=round(0.7*size(data, 1));
  clear ans data0 data08 data1 data18 data2 data28 data3 data38 ...
      data4 data48 data5 data58 data6 data68 data7 data78 data8 ...
      data88 data9 data98

  [w, nd, v, lls]=blftest030397(data(1:npatterns, :), 4);
  eval(['save train' num2str(i) '_' date])
end