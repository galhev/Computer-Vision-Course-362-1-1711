function Model = TrainSVM(TrainData, TrainLabels, Params)
% This function get the features of the before last layer of the tained 
% NN model and train it by SVM

addpath('./packages/AngliaSVM');

% create tutor
tutor = smosvctutor;

% train support vector machine
data = TrainData';
labels = TrainLabels';
net = train(svc, tutor, data, labels, Params.C,Params.kernel);
net = fixduplicates(net, data, labels);
net2 = strip(net);
%sv = getsv(net2);%get support vector
Model = net2;