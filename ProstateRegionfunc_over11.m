function index4dim=ProstateRegionfunc_over11(i) 
% functions to isolate feature vectors belonging to prostate tissue of 
% patients Nr.12-Nr.14 of from the whole data set .
% The input i is the patients ID number.
% The output is a 10 rows matrix,which contains 5 rows features and 3 rows
% dimensions,label and the patientID.
%% Author Information
%   Hao Wang,Wangbo Zheng
%   patrecgroup08
%	University of Stuttgart
%% load dataset
load dataset.mat                 
%% extract the labels,the patienID and the dimension infomation
dataprostate=dataset{i, 1}.labelsHisto; % the labels from an histological analysis
labelcancer=dataprostate;
nonzerolabel=labelcancer(labelcancer~=0);% the labels of prostate region
patientInd=nonzerolabel;
patientInd(:)=i;% PatientID 
dataprostate(dataprostate~=0)=1;  % nonzero element means the prostate tissue
% linear index of the nonzero element of the matrix(prostate region)
Ind=find(dataprostate); 
[I,J,K]=ind2sub(size(dataprostate),Ind); % row,column,page,feature information
%% extract 5 features 
image=dataset{i,1}.Image;
image(isnan(image))=0; % remove NaN in dataset
for k=1:5
    % prostate region of image(3D),which also includes 5 features
    region=dataprostate.*image(:,:,:,k); 
    feature(:,k) = region(:);
end
feature(all(feature==0,2),:)=[];% throw away zero elements.or:nonzeroregion=feature(feature~=0)
% transform T2 weighted MR image to the range [0,1]
T2=feature(:,5);
T201=(T2-min(T2))/(max(T2)-min(T2));
feature(:,5)=T201;
%% output
index4dim=[feature,I,J,K,nonzerolabel,patientInd]; 


