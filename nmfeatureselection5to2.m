function ac_max_nm=nmfeatureselection5to2(feature_data)
% function to select 2 of 5 feature for nearest mean classifier.
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
        ac = nearest_mean_classifier2(feature_data,feature_training,feature_test);
        interm_result=cat(2,nmac_result,[n;m;ac]);
        nmac_result=interm_result;
    end
end
[M,index_max]=max(nmac_result(3,:));
ac_max_nm=nmac_result(:,index_max);
%% nearest mean classifier for 2 features
function ac = nearest_mean_classifier2(feature_data,feature_training,feature_test)
% mean classifier using the Mahalanobis distance for 2 features
y_train = feature_data.training(:,end-1);; 
labels = unique(y_train);
d = size(feature_training,2);
mu_nmc = zeros(2,d);
C_nmc = cell(2,1);
for c=1:2
    mu_nmc(c,:) = mean(feature_training(y_train==labels(c),:));
    C_nmc{c} = cov(feature_training(y_train==labels(c),:));
end

N_TEST = size(feature_test,1);
 
% will contain the estimated labels in the first column and the true
% labels in the second column
nmc_output = zeros(N_TEST,2);
nmc_output(:,2) = feature_data.test(:,9);
 
dist = zeros(N_TEST,2);
for c=1:2
    tmp = bsxfun(@minus,feature_test,mu_nmc(c,:)) / chol(C_nmc{c});
    dist(:,c) = sum(tmp.*tmp,2);
end
 
[dummy ind] = min(dist,[],2);
nmc_output(:,1) = labels(ind);
ac = sum(nmc_output(:,1)==nmc_output(:,2))/size(nmc_output,1)
