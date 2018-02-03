function ac_max_nm_knn=knnfeatureselection5to2(feature_data)
% function to select 2 of 5 feature for kNN classifier.
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
        feature_training=feature_data.training(:,[n m]);
        feature_test=feature_data.test(:,[n m]);
        ac = prostate_knn_classifier5to2(feature_data,feature_test,feature_training,50);
        interm_result=cat(2,nmac_result,[n;m;ac]);
        nmac_result=interm_result;
    end
end
[M,index_max]=max(nmac_result(3,:));
ac_max_nm_knn=nmac_result(:,index_max);
%% knn for 2 features
function Ac_knn =prostate_knn_classifier5to2(feature_data,feature_test,feature_training,k)
group=feature_data.training(:,9);
classification=knnclassify(feature_test,feature_training,group,k);
Ac_knn = sum(classification==feature_data.test(:,9))/size(classification,1);