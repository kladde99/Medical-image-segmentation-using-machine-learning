function er = classifiers_error_rate(NMC_opMATRIX,kNN_opMATRIX,accuracy)
% function to computes the error rate for the the three classifier
% the input:NMC_opMATRIX - nearest mean output matrix contains the estimated 
%                          labels in the first column and the true labels in the second.
%           kNN_opMATRIX - kNN output matrix contains the estimated 
%                          labels in the first column and the true labels in the second.
%           accuracy - the accuracy of svm in % form
% the output er : error rate of three classifiers
%% Author Information
%   Hao Wang,Wangbo Zheng
%   patrecgroup08
%	University of Stuttgart
%%
er=zeros(1,3);
er(1) = sum(NMC_opMATRIX(:,1)~=NMC_opMATRIX(:,2))/size(NMC_opMATRIX,1);
er(2) = sum(kNN_opMATRIX (:,1)~=kNN_opMATRIX (:,2))/size(kNN_opMATRIX ,1);
er(3) = 1-accuracy(1)/100;
