function [predicted_label,accuracy,prob_estimates]=svm_classf(feature_data,trainingdata_selected,c)
% function of SVM(support vector machine)classifier for 5 features,based on
% libSVM library.svmtrain and svmpredict
% the input:feature_data is the whole feature dataset:training and test set
%           trainingdata_selected is subset of training set
%           c is the box constraint C for the soft margin. 
% the output:predicted_label accuracy and prob_estimates
%% Author Information
%   Hao Wang,Wangbo Zheng
%   patrecgroup08
%	University of Stuttgart
%% Reference
% [1]Chih-Wei Hsu, Chih-Jen L. Chih-Chung Chang C. Chih-Chung Chang: A Practical
% Guide to Support Vector Classification. In: none 1 (2003), S. 1¨C16
X_train=trainingdata_selected(:,1:5);
y_train=trainingdata_selected(:,9);
libsvm_options=['-c ' num2str(c) ' -g 0.07 -b 1'];
model=svmtrain(y_train,X_train,libsvm_options);
X_test=feature_data.test(:,1:5);
testing_label_vector=feature_data.test(:,9);
[predicted_label,accuracy,prob_estimates]=svmpredict(testing_label_vector,X_test,model, '-b 1');
