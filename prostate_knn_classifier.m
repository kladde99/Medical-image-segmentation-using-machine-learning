function kNN_opMATRIX = prostate_knn_classifier(feature_test, X_train, y_train, K)  
% function of KNN k-Nearest Neighbors Algorithm.  
% the input:X:         testing sample features, N-by-P_test matrix.  
%           X_train:   training sample features, N-by-P matrix.  
%           y_train:   training sample labels, N-by-1 column vector.  
%           K:         the k in k-Nearest Neighbors  
% the out is kNN_opMATRIX : a matrix containing the true and estimated labels 
% for every test sample in the test field of the feature data structure.
%% Author Information
%   Hao Wang,Wangbo Zheng
%   patrecgroup08
%	University of Stuttgart
%% 
% X_train = trainingdata_selected(:,1:5); for 5 features
% y_train = trainingdata_selected(:,9); labels
% X       = feature_data.test(:,1:5);

[N_test,~] = size(feature_test);  
  
predicted_label = zeros(N_test,1);  
for i=1:N_test  
    [dists, neighbors] = top_K_neighbors(X_train,y_train,feature_test(i,:),K);   
    % calculate the K nearest neighbors and the distances.  
    predicted_label(i) = recog(y_train(neighbors),max(y_train));  
    % recognize the label of the test vector.  
end  
  
kNN_opMATRIX(:,1) = predicted_label;  
kNN_opMATRIX(:,2) = feature_data.test(:,9);
% training_percent=1-sum(y~=feature_data.test(:,9))/size(feature_data.test(:,9),1);
end  
%% calculte distance
function [dists,neighbors] = top_K_neighbors( X_train,y_train,X_test,K )  
%   Input:   
%   X_test the test vector with 1*P  
%   X_train and y_train are the train data set  
%   K is the K neighbor parameter  
[N_train,~] = size(X_train);  
test_mat = repmat(X_test,N_train,1);  
dist_mat = (X_train-double(test_mat)) .^2;  
% The distance is the Euclid Distance.  
dist_array = sum(dist_mat,2);  
[dists, neighbors] = sort(dist_array);  
% The neighbors are the index of top K nearest points.  
dists = dists(1:K);  
neighbors = neighbors(1:K);  
  
end  

function label_index = recog( K_labels,class_num )  
%RECOG Summary of this function goes here  
 
[K,~] = size(K_labels);  
class_count = zeros(class_num,1);  
for i=1:K  
    class_index = K_labels(i); % +1 is to avoid the 0 index reference.  
    class_count(class_index) = class_count(class_index) + 1;  
end  
[result,label_index] = max(class_count);  
% result = result ; % Do not forget -1 !!!  
end  