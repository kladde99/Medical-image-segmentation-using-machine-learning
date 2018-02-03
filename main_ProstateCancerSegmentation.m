% main function of part 1:Prostate cancer segmentation based on MRI and PET
% images.
%% Author Information
%   Hao Wang,Wangbo Zheng
%   patrecgroup08
%	University of Stuttgart
%% preprocessing
% Extract prostate region
Extract_features=ExtractProstateRegion;
% Feature normalization
norm_extract=normalization(Extract_features);
% Data set partitioning
feature_data=partioning(norm_extract);
% Outlier detection and removal
featuredata_new=Outlier_Remove(feature_data);
% Training set selection
trainingdata_selected = set_selection(featuredata_new,5000);
%% Implementation of classifiers
NMC_opMATRIX = nearest_mean_classifier(featuredata_new);%nearest mean
kNN_opMATRIX = prostate_knn_classifier(featuredata_new.test,trainingdata_selected(:,1:5),trainingdata_selected(:,9),K);%kNN  
[predicted_label,accuracy,prob_estimates]=svm_classf(featuredata_new,trainingdata_selected,c);%svm
%% Feature selection
ac_max_nm=nmfeatureselection5to2(featuredata_new);% feature selection for nearest mean classifier
ac_max_nm_knn=knnfeatureselection5to2(featuredata_new);% feature selection for kNN classifier
ac_max_nm_svm=svmfeatureselection5to2(featuredata_new,trainingdata_selected);% feature selection for SVM classifier
% Parameter optimization
[max_accuracy,max_k_ind]=k_optimization(featuredata_new,trainingdata_selected);% K optimization
[max_accuracy_svm,C_opt]=C_optimization(featuredata_new,trainingdata_selected);% C optimization
%% Validation
% error rates comparing
er = classifiers_error_rate(NMC_opMATRIX,kNN_opMATRIX,accuracy);
% ROC of svm
ROCofSVM(predicted_label,prob_estimates);
%% Visualization
% decision boundaries
decisionboundary_nm(trainingdata_selected);
decisionboundary_knn(trainingdata_selected,K);% select k parameter to plot different DB
decisionboundary_SVM(trainingdata_selected);
% visualization using imagine.m
hImgAxes=CancerVisualization(dataset,featuredata_new,NMC_opMATRIX,kNN_opMATRIX,predicted_label,PatientID);
%% post processing
post_processing(dataset,datasetlabelsNMC,datasetlabelsknn,datasetlabelssvm);


