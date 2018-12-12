Params = getDefaultParams();
rng(Params.seed);
addpath(Params.path);
%C, Kernel
[TrainData, ValidationData, TestData, ...
    TrainLabels, ValidationLabels, TestLabels] = getSplitData(Params);

TrainFeatures =  getVggFeatures(TrainData, Params);%Each class will say if the image belongs it or not and the output will be num between almost -1-1 while -1 is not belong to the class and is possibly 1 belongs to the class.
ValidationFeatures =  getVggFeatures(ValidationData, Params);%Each class will say if the image belongs it or not and the output will be num between almost -1-1 while -1 is not belong to the class and is possibly 1 belongs to the class.

ErrorMatrix = zeros(5,10);
j=1;


for i=1:4
for C=[0.000001, 0.00001, 0.0001, 0.001, 0.01, 0.1, 1.0, 10.0, 100.0, 1000.0];
% choose kernel
KernelType=i;       % 1 -linear
% 2 - Polynomial(2)
% 3 - Polynomial(3)
% 4 - RBF(0.5)
% 5 - RBF(2)
switch KernelType
    case 1
        kernel=linear;
    case 2
       kernel=polynomial(2);
    %case 3
     %   kernel=polynomial(3);
    case 3
        kernel=rbf(0.5);%sigma=0.5
    case 4
        kernel=rbf(2);
end


ModelSVM = TrainSVMTuning(TrainFeatures, TrainLabels, Params, kernel, C);

Results = Test(ModelSVM, ValidationFeatures, Params, ValidationLabels);

%[Summary] = Evaluate(Results, TestLabels, Params);
[Summary] = EvaluateTuning(Results, ValidationLabels, Params);

 ErrorMatrix(i,j)=Summary.Error_Rate;
j=j+1;
 end
j=1;
end



% 2 - Polynomial(2)
% 3 - Polynomial(3)
% 4 - RBF(0.5)
% 5 - RBF(2)
plot (ErrorMatrix(:,1),ErrorMatrix(:,2));
set(gca, 'xtick' , (1:5));
set(gca,'xtickLabels',{'Linear', 'Polynomial(2)', 'Polynomial(3)','rbf(0.5)', 'rbf(2)'});

%ReportResults(Summary, Params.Report);
