function [TrainData,ValidationData, TestData , TrainLabels,ValidationLabels, TestLabels, TestImgNames] = TrainTestSplit(Params, Data, Labels)

trainData = zeros(Params.s, Params.s, Params.trainAmount*length(Params.classIndices));
trainLabels = zeros(1, Params.trainAmount*length(Params.classIndices));

validationData = zeros(Params.s, Params.s, Params.trainAmount*length(Params.classIndices));
validationLabels = zeros(1, Params.trainAmount*length(Params.classIndices));

testData = zeros(Params.s, Params.s, Params.testAmount*length(Params.classIndices));
testLabels = zeros(1, Params.testAmount*length(Params.classIndices));
testImgNames = {Params.testAmount*length(Params.classIndices)};
 
validation_num=0;
prevTrain=1;
prevTest=1;
prevValid=1;

%For each class in classIndices, split data into train, validation and test
%data, according to amounts from Params.
for i = 1:length(Params.classIndices)
    j = Params.classIndices(i);
    images_num=Params.numOfImagesInClasses(i,2);

    if images_num>Params.trainAmount+Params.testAmount 
        
        train_num=round(Params.trainAmount*Params.splitRatio); %trainAmount=train+validation
        if Params.needValidation==true;
            validation_num=Params.trainAmount-train_num;
        end 
         test_num=Params.testAmount;  
    else
        train_num=round(0.75*(round(images_num*2/3)));
        if Params.needValidation==true;
            validation_num=round(images_num*2/3)-train_num;
        end  
        test_num=images_num-train_num-validation_num;

    end 
    
        %Extract train data
        Indices=find(Labels==j);%Indexes of Class j images
        shuffled_img=randperm(images_num);% shuffle vector
        trainInd=shuffled_img(1:train_num);
        trainImg=Indices(trainInd);  
        trainData(:,:,prevTrain:prevTrain+train_num-1)=Data(:,:,trainImg);
        trainLabels(1,prevTrain:prevTrain+train_num-1)=Labels(1,trainImg);
        
        %Extract validation data
        if Params.needValidation==true
            validationInd=shuffled_img(train_num+1:train_num+validation_num);
            validationImg=Indices(validationInd);
            validationData(:,:,prevValid:prevValid+validation_num-1)=Data(:,:,validationImg);
            validationLabels(1,prevValid:prevValid+validation_num-1)=Labels(1,validationImg);
        end
        
        %Extract test data
        testInd=shuffled_img(train_num+validation_num+1:train_num+test_num+validation_num);
        testImg=Indices(testInd); 
        testData(:,:,prevTest:prevTest+test_num-1)=Data(:,:,testImg);
        testLabels(1,prevTest:prevTest+test_num-1)=Labels(1,testImg);
        f=1;
        for d = prevTest:prevTest+test_num-1
            testImgNames{d}=Params.Images_names{testImg(f),2};
            f=f+1;
        end
        prevTrain=prevTrain+train_num;
        prevValid=prevValid+validation_num;
        prevTest=prevTest+test_num;
end

%Return data and labels
ValidationData = validationData(:,:,validationLabels~=0);
ValidationLabels = validationLabels(1,(validationLabels~=0));

TrainData = trainData(:,:,trainLabels~=0);
TestData = testData(:,:,testLabels~=0);

TrainLabels = trainLabels(1,trainLabels~=0);
TestLabels = testLabels(1,testLabels~=0);
TestImgNames = testImgNames(1,testLabels~=0);



