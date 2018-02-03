function NMC_opMATRIX = nearest_mean_classifier(feature_data)
% function of nearest mean classifier for 5 features using the Mahalanobis 
% distance 
% the input is the feature dataset
% the output NMC_opMATRIX is a matrix containing the true and estimated labels 
% for every test sample in the test field of the feature data structure.
%% Author Information
%   Hao Wang,Wangbo Zheng
%   patrecgroup08
%	University of Stuttgart      
%% training 
feature_training = feature_data.training(:,1:5);
y_train = feature_data.training(:,9);%labels
 
labels = unique(y_train);
d = size(feature_training,2);
mu_nmc = zeros(2,d);
C_nmc = cell(2,1);
for c=1:2
    mu_nmc(c,:) = mean(feature_training(y_train==labels(c),:));
    C_nmc{c} = cov(feature_training(y_train==labels(c),:));
end 
%% test 
feature_test = feature_data.test(:,1:5);
N_TEST = size(feature_test,1);
% will contain the estimated labels in the first column and the true
% labels in the second column
NMC_opMATRIX = zeros(N_TEST,2);
NMC_opMATRIX(:,2) = feature_data.test(:,9);
% estimate the labels for the samples of the test set
 
dist = zeros(N_TEST,2);
for c=1:2
    tmp = bsxfun(@minus,feature_test,mu_nmc(c,:)) / chol(C_nmc{c});
    dist(:,c) = sum(tmp.*tmp,2);
end
 
[dummy,ind] = min(dist,[],2);
NMC_opMATRIX(:,1) = labels(ind);
%ac = sum(NMC_opMATRIX(:,1)==NMC_opMATRIX(:,2))/size(NMC_opMATRIX,1);