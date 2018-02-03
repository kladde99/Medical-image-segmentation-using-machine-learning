function ROCofSVM(predicted_label,prob_estimates)
% function of roc plot for svm
% the input are the output of svm classifier: predicted label and probability 
% of estimates
%% Author Information
%   Hao Wang,Wangbo Zheng
%   patrecgroup08
%	University of Stuttgart
%% 
predicted_label(predicted_label==2)=0;
plotroc(predicted_label,prob_estimates);