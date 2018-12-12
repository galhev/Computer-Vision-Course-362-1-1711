function Results = Test(Model, TestDataRep, Params, TestLabels)

classification=zeros(length(Params.classIndices),length(TestLabels));

%Test images with each of the models
for i = 1:length(Model)
    Temp_model = fwd(Model{i},TestDataRep);%Create score for each image, according to model i
    classification(i,:) = Temp_model';
end

Results = classification; %row = class, column = image