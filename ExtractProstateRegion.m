function Extract_features=ExtractProstateRegion
% functions to isolate feature vectors belonging to prostate tissue from
% the whole data set. There are two subfunctions ,the first one is function
% for patients Nr.1-Nr.11 of dataset.mat .The second is function for patients
% Nr.12-Nr.14. The output is a 10 rows matrix,which contains 5 rows
% features and 3 rows dimensions,label and the patientID.
%% Author Information
%   Hao Wang,Wangbo Zheng
%   patrecgroup08
%	University of Stuttgart
%%
Extract_features=[];
for i=1:11
    interm_v1=[Extract_features;ProstateRegionfunc(i)];
    Extract_features=interm_v1;    
end
for i=12:14
    interm_v2=[Extract_features;ProstateRegionfunc_over11(i)];
    Extract_features=interm_v2;
end