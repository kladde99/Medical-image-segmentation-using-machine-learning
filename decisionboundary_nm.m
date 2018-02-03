function decisionboundary_nm(trainingdata_selected)
% function to plot 2 dimensional decision boundary for nearest mean classifier
% the input is selected training set
% return a decision boundary plot,blue x: cancer ,red + for healthy cell
%% Author Information
%   Hao Wang,Wangbo Zheng
%   patrecgroup08
%	University of Stuttgart
%% set dataset for decision boundary
t = trainingdata_selected(:,9);%labels
t(t==2)=0;
DBfeature_data.training = [trainingdata_selected(:,[4 5]) t];% select 2 features
%N = size(DBfeature_data,1);
%% Generate the decision boundaries 
[X1 X2] = meshgrid(min(DBfeature_data.training(:,1)):0.01:max(DBfeature_data.training(:,1)),min(DBfeature_data.training(:,2)):0.01:max(DBfeature_data.training(:,2)));
classes = zeros(size(X1));% estimated label
% reset test set using training set
DBfeature_data.test=zeros(length(X1(:)),2);
% Loop over test points
for i = 1:length(X1(:))
    DBfeature_data.test(i,:) = [X1(i) X2(i)];
end;
NMC_opMATRIX = nearest_mean_classifierTWO(DBfeature_data);
for i = 1:length(X1(:))
    classes(i) = NMC_opMATRIX(i);
end;
ma = {'x','+'};% maker x for cancer + for healthy
fc = {[1 0 0]; [0 0 1]};% red blue
tv = unique(t);
% plot points
figure(1); hold off
for i = 1:length(tv)
    pos = find(t==tv(i));
    plot(DBfeature_data.training(pos,1),DBfeature_data.training(pos,2),ma{i},'markerfacecolor',fc{i});
    hold on
end;
% plot decision boundary using contour line
contour(X1,X2,classes,[0.5 0.5],'k');
legend('cancer','healthy');
title('Nearest mean classifier');
%% nearest mean classifier for 2 dimensional feature space
function NMC_opMATRIX = nearest_mean_classifierTWO(feature_data)
% almost same like the 5 feature nearest mean classifier
% training 
feature_training = feature_data.training(:,1:2);
y_train = feature_data.training(:,3);
 
labels = unique(y_train);
d = size(feature_training,2);
mu_nmc = zeros(2,d);
C_nmc = cell(2,1);
for c=1:2
    mu_nmc(c,:) = mean(feature_training(y_train==labels(c),:));
    C_nmc{c} = cov(feature_training(y_train==labels(c),:));
end
% test
feature_test = feature_data.test(:,1:2);
N_TEST = size(feature_test,1);
NMC_opMATRIX = zeros(N_TEST,1);
% estimate the labels for the samples of the test set
 
dist = zeros(N_TEST,2);
for c=1:2
    tmp = bsxfun(@minus,feature_test,mu_nmc(c,:)) / chol(C_nmc{c});
    dist(:,c) = sum(tmp.*tmp,2);
end

[dummy,ind] = min(dist,[],2);
NMC_opMATRIX(:,1) = labels(ind);