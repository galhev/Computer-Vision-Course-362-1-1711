function Results = Test(ModelSVM, TestFeatures, Params, TestLabels)

data=TestFeatures';% Transpose data
classification = fwd(ModelSVM,data);%Create score for each image
Results = classification'; 