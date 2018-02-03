function decisionboundary_SVM(trainingdata_selected)
% function to plot 2 dimensional decision boundary for svm classifier
% the input is selected training set,C is the parameter of SVM
% return a decision boundary plot ,blue x: cancer ,red + for healthy cell
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
end
EVAL_MATRIX=svm_classfTWO(DBfeature_data,0.51);
for i = 1:length(X1(:))
    classes(i) = EVAL_MATRIX(i);
end
ma = {'x','+'};% maker x for cancer + for healthy
fc = {[1 0 0]; [0 0 1]};% red blue
tv = unique(t);
% plot points
figure(2); hold off
for i = 1:length(tv)
    pos = find(t==tv(i));
    plot(DBfeature_data.training(pos,1),DBfeature_data.training(pos,2),ma{i},'markerfacecolor',fc{i});
    hold on
end
% plot decision boundary using contour line
contour(X1,X2,classes,[0.5 0.5],'k');
legend('cancer','healthy');
title('SVM');
%% SVM classifier for 2 dimensional feature space
function predicted_label=svm_classfTWO(feature_data,c)
% almost same like svm_classf ,this function only has one output:the
% estimated labels:predicted_label
X_train=feature_data.training(:,1:2);
y_train=feature_data.training(:,3);
libsvm_options=['-c ' num2str(c) ' -g 0.07 -b 1'];
model=svmtrain(y_train,X_train,libsvm_options);
testing_label_vector=feature_data.test(:,end);
[predicted_label,accuracy,prob_estimates]=svmpredict(testing_label_vector,feature_data.test,model, '-b 1');