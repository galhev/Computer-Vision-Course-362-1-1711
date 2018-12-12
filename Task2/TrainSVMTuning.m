function Model = TrainSVMTuning(TrainData, TrainLabels, Params, kernel, C)

addpath('./packages/AngliaSVM');

% create tutor
tutor = smosvctutor;

% train support vector machine
data = TrainData';
labels = TrainLabels';
net = train(svc, tutor, data, labels, C,kernel);
net = fixduplicates(net, data, labels);
net2 = strip(net);
%sv = getsv(net2);%get support vector
Model = net2;