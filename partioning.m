function feature_data=partioning(norm_extract)
% function to partition the given 14 datasets into a training set and a
% validation set.
% the input is normalized features.
% the output is a data structure for storing the training and validation
% dataset
%% Author Information
%   Hao Wang,Wangbo Zheng
%   patrecgroup08
%	University of Stuttgart
%% 
row_index1=norm_extract(:,10)<12;
feature_data.training=norm_extract(row_index1,:);% training set
row_index2=norm_extract(:,10)>11;
feature_data.test=norm_extract(row_index2,:);% test set

