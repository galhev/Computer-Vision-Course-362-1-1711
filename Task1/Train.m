function Model = Train(TrainDataRep, TrainLabels, Params)
%addpath('.\packages\AngliaSVM')
trainClassNum = length(Params.classIndices);
model = cell(trainClassNum,1);
imgLabels = zeros(size(TrainLabels'));

%Create tutor
tutor  = smosvctutor;

%For each class create a binary model which indicates - 
%does a given image belong to the class or not? 
for i = 1:trainClassNum   
    class = Params.classIndices(i);
    imgLabels(TrainLabels~=class)=-1;
    imgLabels(TrainLabels==class)= 1;
   	
    % Train support vector machine for the class
    net = train(svc, tutor, TrainDataRep, imgLabels, Params.C, Params.kernel);
    net = fixduplicates(net, TrainDataRep, imgLabels);
    net2 = strip(net);
    %sv = getsv(net2); %get support vector
    model{i} = net2; %Store model
end

Params.needTraining = true;
Model=model;
