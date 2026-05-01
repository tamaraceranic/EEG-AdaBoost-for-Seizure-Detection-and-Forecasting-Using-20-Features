function [predictied_label]=ai_model_main(TRAINING,label_training,TEST)
   

%% AdaBoostM1 for depth 3, and 'Tree' 300. 

         treeTemplate = templateTree('MaxNumSplits', 3); % ? depth 2
         ClassTreeEns3 = fitensemble(TRAINING,label_training,'AdaBoostM1',300,treeTemplate,'LearnRate', 0.3);
  
         [predictied_label, problikescore] = predict(ClassTreeEns3,TEST);


end



