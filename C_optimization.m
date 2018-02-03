function [max_accuracy_svm,C_opt]=C_optimization(featuredata_new,trainingdata_selected)
% functions to optimize the parameter C of SVM using simple method
% return a plot and the the optimal C and the best accuracy
%% Author Information
%   Hao Wang,Wangbo Zheng
%   patrecgroup08
%	University of Stuttgart
%% 
a = 0.40:0.01:0.52; % the range should be selected different each time. 
accuracy_rate = arrayfun(@(c) svm_classf2(featuredata_new,trainingdata_selected,feature_training,feature_test,c),a);
[max_accuracy_svm,c_ind] = max(accuracy_rate);
C_opt=a(c_ind);
% plot
plot(a,accuracy_rate,'r:+');
xlabel('parameter c'),
ylabel('accuracy'), title('C Optimization');
grid on;
%% svm function almost same like svm_classf but only one output
function accuracy=svm_classf2(feature_data,trainingdata_selected,feature_training,feature_test,c)
y_train=trainingdata_selected(:,9);
libsvm_options=['-c ' num2str(c) ' -g 0.07 -b 1'];
model=svmtrain(y_train,feature_training,libsvm_options);
testing_label_vector=feature_data.test(:,9);
[predicted_label,accuracy,prob_estimates]=svmpredict(testing_label_vector,feature_test,model, '-b 1');