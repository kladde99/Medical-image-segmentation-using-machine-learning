function norm_extract=normalization(Extract_features)
% functions to normalize the 5 feature.Scale each dimension of the feature
% vetor to zero mean and unit variance.
% The input is extracted features.
% The output is normalized features
%% Author Information
%   Hao Wang,Wangbo Zheng
%   patrecgroup08
%	University of Stuttgart
%% Reference
% [1]Andrew R.Webb, Keith D. C.: Statistical Pattern Recognition. 3rd 
% edition. JohnWiley & Sons, 2011;
% [2]Aksoy, Selim ; Haralick, Robert M.: Feature normalization
% and likelihood-based similarity measures for image retrieval.
% In: Pattern Recognition Letters 22 (2001), Nr. 5, 563 - 582.
%% 
for j=1:5
    sigfeature(:,j)=Extract_features(:,j);
    normalfeature(:,j)=(sigfeature(:,j)-mean(sigfeature(:,j),1))/std(sigfeature(:,j),0,1);
% the other normalization technique is transforming features to the range[0,1]    
% normalfeature01(:,j)=(normalfeature(:,j)-min(normalfeature(:,j)))/(max(normalfeature(:,j))-min(normalfeature(:,j)))
end
norm_extract=[normalfeature,Extract_features(:,6:10)];
