function index4dim=ProstateRegionfunc(i) 
% functions to isolate feature vectors belonging to prostate tissue of 
% patients Nr.1-Nr.11 of from the whole data set . 
% The input i is the patients ID number.
% The output is a 10 rows matrix,which contains 5 rows features and 3 rows
% dimensions,label and the patientID.
%% Author Information
%   Hao Wang,Wangbo Zheng
%   patrecgroup08
%	University of Stuttgart
%% load dataset
load dataset.mat                 
%% ground truth 
% the ground truth :label=0,if labelA not equals to labelB,label=labelA,
% if labelA = labelB. label=0 for non-prostate tissue,label=1 for healthy
% prostate tissue,label=2 for cancer prostate tissue.
data1=dataset{i,1}.LabelsA; 
data2=dataset{i,1}.LabelsB;% data1 & data2 are manual labels from two experts
dataprostate=data1.*data2;% a combination of the two expert labels
dataprostate(dataprostate==2)=0;% label=0,if labelA not equals to labelB
dataprostate(dataprostate==4)=2;% label=2,if labelA = labelB=2
labelcancer=dataprostate;
nonzerolabel=labelcancer(labelcancer~=0);% the prostate region labels
%% extract the patienID and the dimension infomation
patientInd=nonzerolabel;
patientInd(:)=i; % PatientID
dataprostate(dataprostate~=0)=1;% nonzero element means the prostate tissue
% linear index of the nonzero element of the matrix(prostate region)
Ind=find(dataprostate); 
[I,J,K]=ind2sub(size(dataprostate),Ind);% row,column,page,feature information
%% extract 5 features 
image=dataset{i,1}.Image;
for k=1:5
   % prostate region of image(3D),which also includes 5 features
    region=dataprostate.*image(:,:,:,k); 
    feature(:,k) = region(:);
end
feature(all(feature==0,2),:)=[]; % throw away zero elements.or:nonzeroregion=feature(feature~=0)
% transform T2 weighted MR image to the range [0,1]
T2=feature(:,5);
T201=(T2-min(T2))/(max(T2)-min(T2));
feature(:,5)=T201;

%% output
index4dim=[feature,I,J,K,nonzerolabel,patientInd]; 




