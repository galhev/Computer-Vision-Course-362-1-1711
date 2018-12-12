Params = getDefaultParams();
rng(Params.seed);
addpath(Params.path);

[TrainData, ValidationData, TestData, ...
    TrainLabels, ValidationLabels, TestLabels] = getSplitData(Params);

TrainFeatures =  getVggFeatures(TrainData, Params);
TestFeatures =  getVggFeatures(TestData, Params);
ModelSVM = TrainSVM(TrainFeatures, TrainLabels, Params);
Results = Test(ModelSVM, TestFeatures, Params, TestLabels);

[Summary] = Evaluate(Results, TestLabels, Params);
ReportResults(Summary, Params);
