function [predictied_label]=ai_model_main(TRAINING,label_training,TEST)
   
% The model parameters are set to values that achieved strong performance on the available test datasets. 
% Users are encouraged to further experiment with and optimize hyperparameters on their own datasets, as performance may vary depending on data characteristics.
%% AdaBoostM1 for depth 3, and 'Tree' 300. 

         treeTemplate = templateTree('MaxNumSplits', 3); % ? depth 2
         ClassTreeEns3 = fitensemble(TRAINING,label_training,'AdaBoostM1',300,treeTemplate,'LearnRate', 0.3);
  
         [predictied_label, problikescore] = predict(ClassTreeEns3,TEST);


end



