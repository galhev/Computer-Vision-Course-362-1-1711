function [TrainData, ValidationData, TestData, TrainLabels, ValidationLabels, TestLabels] = getSplitData(Params)
%{
This function seperate the data to train set, test set and validation set.
%}
load('./Peppers/PeppersData.mat');  

uintType = uint8(0);
resizedData(Params.imageSize, Params.imageSize, Params.imageDim ,size(Images,2)) = uintType;

%resize images
for i=1:size(Images,2)
    resizedData(:,:,:,i) = imresize(Images{i},[Params.imageSize, Params.imageSize]);
end

%create empty matrix for train, test and validation sets and empty vectors
%for saving the labels accordingly
trainData(Params.imageSize, Params.imageSize, ...
    Params.imageDim ,Params.numTrain)=uintType;
trainLabels = zeros(1, Params.numTrain);
 
validationData(Params.imageSize, Params.imageSize, Params.imageDim ,Params.numValidation)=uintType;
validationLabels = zeros(1, Params.numValidation);
 
testData(Params.imageSize, Params.imageSize, Params.imageDim ,Params.numTest)=uintType;
testLabels = zeros(1, Params.numTest);

%Random images
shuffled_img=randperm(size(Images,2));% shuffle vector
%choose training data set from randomized set
trainInd=shuffled_img(1:Params.numTrain);
trainData(:,:,:,1:Params.numTrain)=resizedData(:,:,:,trainInd);%save data
trainLabels(1,1:Params.numTrain)=Labels(1,trainInd);%save labels

%Choose validation data set from randomized set
validInd=shuffled_img(Params.numTrain+1:Params.numTrain+Params.numValidation);
validationData(:,:,:,1:Params.numValidation)=resizedData(:,:,:,validInd);%save data
validationLabels(1,1:Params.numValidation)=Labels(1,validInd);%save labels

%Choose test data set from randomized set
testInd=shuffled_img(Params.numTrain+Params.numValidation+1:Params.numTrain+Params.numValidation+Params.numTest);
testData(:,:,:,1:Params.numTest)=resizedData(:,:,:,testInd);%save data
testLabels(1,1:Params.numTest)=Labels(1,testInd);%save labels

%Augmentation data
if (Params.numAug > 0)
[trainDataAug, trainLabelsAug] = addAugmented(trainData, trainLabels, Params);
TrainData = trainDataAug;
TrainLabels = trainLabelsAug;
%Not using augmentation
else
TrainData = trainData(:,:,:,trainLabels~=0);
TrainLabels = trainLabels(1,trainLabels~=0);
end
 
ValidationData = validationData(:,:,:,validationLabels~=0);
ValidationLabels = validationLabels(1,(validationLabels~=0));
 
TestData = testData(:,:,:,testLabels~=0);
TestLabels = testLabels(1,testLabels~=0);