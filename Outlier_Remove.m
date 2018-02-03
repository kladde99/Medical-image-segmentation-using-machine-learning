function featuredata_new=Outlier_Remove(feature_data)
% function to detection and remove outliers(10% of dataset),using
% mahalanobis distance.
% the input is feature dataset structure.
% the output is a feature dataset structure without outliers
%% Author Information
%   Hao Wang,Wangbo Zheng
%   patrecgroup08
%	University of Stuttgart
%% the 5 features and labels of dataset
fivefeatures_training=feature_data.training(:,1:5);
featurelabels_tranining=feature_data.training(:,end-1);
fivefeatures_test=feature_data.test(:,1:5);
featurelabels_test=feature_data.test(:,end-1); 
labels = unique(featurelabels_tranining);
%% detection and remove outliers
mu = zeros(2,5);%initial value of means of two classes
C = cell(2,1);%initial value of covariances of two classes
NrOfData = size(fivefeatures_training,1);
dist = zeros(NrOfData,1);%initial value of mahalanobis distance of two classes
fivefeaturesPLUSdist = [feature_data.training dist];
Dataout=[];
for c=1:2
    mu(c,:) = mean(fivefeatures_test(featurelabels_test==labels(c),:));%determine means using test dataset
    C{c} = cov(fivefeatures_test(featurelabels_test==labels(c),:));%determine covariances using test dataset
    tmp = bsxfun(@minus,fivefeatures_training(featurelabels_tranining==labels(c),:),mu(c,:))/chol(C{c});
    intermc1=fivefeaturesPLUSdist(featurelabels_tranining==labels(c),:);
    intermc1(:,11) = sum(tmp.*tmp,2);%calculator mahalanobis distance
    NrSumData = size(intermc1,1);
    Nr_outlier=round(NrSumData/10);%difinition of outlier: 10% features data 
    % of the training dataset,which have most largest distance
    [B I]=sort(intermc1(:,11));
    index_new=I(1:NrSumData-Nr_outlier);% remove the outliers
    intermc2=[Dataout;intermc1(index_new,:)];
    Dataout=intermc2;
end
featuredata_new.training=Dataout(:,1:10);
featuredata_new.test=feature_data.test;