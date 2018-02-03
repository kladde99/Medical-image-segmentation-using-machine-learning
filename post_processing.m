function post_processing(dataset,datasetlabelsNMC,datasetlabelsknn,datasetlabelssvm)
% post processing based on morphological operations erosion and dilitation
% return the 3 pictures for 3 classifier
% the input:dataset - medical data set
%           datasetlabelsNMC,datasetlabelsknn,datasetlabelssvm are the
%           estimated labels with position information.
%% Author Information
%   Hao Wang,Wangbo Zheng
%   patrecgroup08
%	University of Stuttgart
%%
se = strel('disk',4);% an array specifies the structuring element neighborhood
se2 = strel('disk',5);
NMCerode= imerode(datasetlabelsNMC,se);% erosion
NMCdilate = imdilate(NMCerode,se2);% dilitation
knn12erode= imerode(datasetlabelsknn,se);
knn12dilate = imdilate(knn12erode,se2);
svm12erode= imerode(datasetlabelssvm,se);
svmdilate = imdilate(svm12erode,se2);
hImgAxes = imagine(dataset{12,1}.Image(:,:,:,5),'T2',dataset{12,1}.labelsHisto,'Histo',datasetlabelsNMC,'nearest mean',NMCdilate,'NM+PP');
hImgAxes1 = imagine(dataset{12,1}.Image(:,:,:,5),'T2',dataset{12,1}.labelsHisto,'Histo',datasetlabelsknn,'kNN',knn12dilate,'kNN+PP');
hImgAxes2 = imagine(dataset{12,1}.Image(:,:,:,5),'T2',dataset{12,1}.labelsHisto,'Histo',datasetlabelssvm,'SVM',svmdilate,'SVM+PP');