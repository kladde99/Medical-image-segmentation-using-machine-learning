function ac_max_nm_svm=svmfeatureselection5to2(feature_data,trainingdata_selected)
% function to select 2 of 5 feature for SVM classifier.
% the input is feature dataset
% the output is a vector the best subset number and accuracy
%% Author Information
%   Hao Wang,Wangbo Zheng
%   patrecgroup08
%	University of Stuttgart
%% 
nmac_result=[];
for n=1:4
    for m=n+1:5
        feature_training=trainingdata_selected(:,[n m]);
        feature_test=feature_data.test(:,[n m]);
        ac=svm_classf5to2(feature_data,trainingdata_selected,feature_training,feature_test,0.45);
        interm_result=cat(2,nmac_result,[n;m;ac]);
        nmac_result=interm_result;
    end
end
[M,index_max]=max(nmac_result(3,:));
ac_max_nm_svm=nmac_result(:,index_max);
%% svm for 2 features
function SVM_accuracy=svm_classf5to2(feature_data,trainingdata_selected,feature_training,feature_test,c)
y_train=trainingdata_selected(:,9);
libsvm_options=['-c ' num2str(c) ' -g 0.07 -b 1'];
model=svmtrain(y_train,feature_training,libsvm_options);
testing_label_vector=feature_data.test(:,9);
[predicted_label,accuracy,prob_estimates]=svmpredict(testing_label_vector,feature_test,model, '-b 1');
SVM_accuracy=accuracy(1)/100;