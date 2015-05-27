clear all


  load figure2
  data=reorder(image');
  data=data>.7;  %Threshold
  
  [w, nd, v, lls]=blftest100497(data, 5);
  eval(['save train2_' date])