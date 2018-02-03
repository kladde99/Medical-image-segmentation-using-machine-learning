function decisionboundary_knn(trainingdata_selected,K)
% function to plot 2 dimensional decision boundary for kNN classifier
% the input is selected training set,K is the parameter of kNN
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
[X1 X2] = meshgrid(min(DBfeature_data.training(:,1)):0.1:max(DBfeature_data.training(:,1)),min(DBfeature_data.training(:,2)):0.1:max(DBfeature_data.training(:,2)));
classes = zeros(size(X1));% estimated label
% reset test set using training set
DBfeature_data.test=zeros(length(X1(:)),2);
% Loop over test points
for i = 1:length(X1(:))
    DBfeature_data.test(i,:) = [X1(i) X2(i)];
end;
EVAL_MATRIX=prostate_knn_classifierTWO(DBfeature_data,K);
for i = 1:length(X1(:))
    classes(i) = EVAL_MATRIX(i);
end;
ma = {'x','+'};% maker x for cancer + for healthy
fc = {[1 0 0]; [0 0 1]};% red blue
tv = unique(t);
figure(1); hold off
% plot points
for i = 1:length(tv)
    pos = find(t==tv(i));
    plot(DBfeature_data.training(pos,1),DBfeature_data.training(pos,2),ma{i},'markerfacecolor',fc{i});
    hold on
end;
% plot decision boundary using contour line
contour(X1,X2,classes,[0.5 0.5],'k');
legend('cancer','healthy');
ti = sprintf('kNN classifier  K = %g',K);
title(ti);
function EVAL_MATRIX=prostate_knn_classifierTWO(feature_data,k)
% kNN classifier for two dimensional feature
R=feature_data.test(:,1:2);
Q=feature_data.training(:,1:2);
group=feature_data.training(:,end);
EVAL_MATRIX=knnclassify(R,Q,group,k);