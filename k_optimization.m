function [max_accuracy,max_k_ind]=k_optimization(featuredata_new,trainingdata_selected)
% functions to optimize the parameter K of KNN 
% return a plot and the the optimal K and the best accuracy
%% Author Information
%   Hao Wang,Wangbo Zheng
%   patrecgroup08
%	University of Stuttgart
%% 
RUNS = 200;
a = 1:RUNS;% k for 1 to 200
accuracy_rate = arrayfun(@(k) prostate_knn_classifier(featuredata_new.test,trainingdata_selected(:,1:5),trainingdata_selected(:,9),K),a);
% find the optimal K
[max_accuracy,max_k_ind] = max(accuracy_rate);
% plot 
plot(a,accuracy_rate,'r:+');
xlabel('parameter k'),
ylabel('accuracy'), title('K Optimization');
grid on;