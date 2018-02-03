function [datasetlabelsNMC,datasetlabelsknn,datasetlabelssvm]=CancerVisualization(dataset,feature_data,NMC_opMATRIX,kNN_opMATRIX,predicted_label,PatientID)
% function for visualize the result of three classifiers,based on the
% Imagine app.
% the input: dataset - medical data set
%            feature_data_our feature dataset structure(only infos of prostate region)
%            NMC_opMATRIX - nearest mean output matrix contains the estimated 
%                          labels in the first column and the true labels in the second.
%            kNN_opMATRIX - kNN output matrix contains the estimated 
%                          labels in the first column and the true labels in the second.
%            predicted_label- output of svm classifier: estimated labels 
%            PatientID- ID number of patient,here we use 12,13,14
% the output:datasetlabelsNMC,datasetlabelsknn,datasetlabelssvm are the
% estimated labels with position information.
% return a interface with 5 pictures ,the first is the T2 weighted
% image,the second is the histological labels,and then the results of three
% classifiers nearest mean,kNN and SVM
%% Author Information
%   Hao Wang,Wangbo Zheng
%   patrecgroup08
%	University of Stuttgart
%%
% for nearest mean classifier
datasetlabelsNMC=dataset{PatientID,1}.labelsHisto;% histological labels
datasetlabelsNMC(datasetlabelsNMC~=0)=0;
NMClabelsandposition=[feature_data.test(:,6:8) NMC_opMATRIX(:,1) feature_data.test(:,10)];% position information and label and PatientID
row_index1=NMClabelsandposition(:,5)==PatientID;% select one patient
NMClabelsandpositionP=NMClabelsandposition(row_index1,:);
linearInd = sub2ind(size(datasetlabelsNMC), NMClabelsandpositionP(:,1), NMClabelsandpositionP(:,2), NMClabelsandpositionP(:,3));
datasetlabelsNMC(linearInd)=NMClabelsandpositionP(:,4);% estimated result with position information
% for knn
datasetlabelsknn=dataset{PatientID,1}.labelsHisto;% histological labels,
datasetlabelsknn(datasetlabelsknn~=0)=0;
knnlabelsandposition=[feature_data.test(:,6:8) kNN_opMATRIX(:,1) feature_data.test(:,10)];% position information and label and PatientID
row_index1=knnlabelsandposition(:,5)==PatientID;% select one patient
knnlabelsandpositionP=knnlabelsandposition(row_index1,:);
linearInd = sub2ind(size(datasetlabelsknn), knnlabelsandpositionP(:,1), knnlabelsandpositionP(:,2), knnlabelsandpositionP(:,3));
datasetlabelsknn(linearInd)=knnlabelsandpositionP(:,4);% estimated result with position information
% for svm
datasetlabelssvm=dataset{PatientID,1}.labelsHisto;
datasetlabelssvm(datasetlabelssvm~=0)=0;
svmlabelsandposition=[feature_data.test(:,6:8) predicted_label feature_data.test(:,10)];% position information and label and PatientID
row_index1=svmlabelsandposition(:,5)==PatientID;% select one patient
svmlabelsandpositionP=svmlabelsandposition(row_index1,:);
linearInd = sub2ind(size(datasetlabelssvm), svmlabelsandpositionP(:,1), svmlabelsandpositionP(:,2), svmlabelsandpositionP(:,3));
datasetlabelssvm(linearInd)=svmlabelsandpositionP(:,4);% estimated result with position information
%% pictures
hImgAxes = imagine(dataset{PatientID,1}.Image(:,:,:,5),'T2',dataset{PatientID,1}.labelsHisto,'Histo',datasetlabelsNMC,'nearest mean',...
    datasetlabelsknn,'kNN',datasetlabelssvm,'SVM');