Params = getDefaultParams();
rng(Params.seed); 
addpath(Params.path);
Params.classIndices = (11:20); %Must be a vector with class numbers between 1 - 101.

if Params.dataInserted == false %If data wasn't already inserted
    [Data, Labels, Params.numOfImagesInClasses, Params.Images_names] = getData(Params); %Read image files into workspace
end

[TrainData,ValidationData, TestData ,TrainLabels,ValidationLabels, TestLabels, ...
    TestImgNames] = TrainTestSplit(Params, Data, Labels); %Split data to train and test images

TrainDataRep = Prepare(TrainData,TrainLabels,Params); %Create hogs for train images
TestDataRep = Prepare(TestData,TestLabels, Params); %Create hogs for test images

if Params.needTraining == false
    Model =  Train(TrainDataRep, TrainLabels, Params); %Train model
end

Results = Test(Model, TestDataRep, Params, TestLabels); %Test model
[MaxImgError, Summary] = Evaluate(Results, TestLabels, Params, TestImgNames); %Evaluate test success
ReportResults(Summary); %Print and save results evaluation to a file
