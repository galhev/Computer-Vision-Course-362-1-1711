function Params = getDefaultParams()
%{
getDefaultParams returns a struct that contain the default experiment parameters
It has several fields, each itself a struct of parameters for the various
experiment stages.
 
Parameters explainations:
 
C - cost for SVM;
kernel - kernel type for SVM;
imageSize - width/height of image in the data;
imageDim - image depth;
numTest - number of images in the test set;
numValidation - number of images in the validation set;
numTrain -number of images in the training set;
numAug - number of images for training data augmentation;
%}
seed = 1754;
 
path = '.\Peppers\' ;
imageSize = 224;
imageDim = 3;
numTest = 343;
numValidation = 333;
numTrain = 667;
kernel=polynomial(2);
C = 0.00001;
numAug = 1200;
 
Params = struct('seed', seed, 'path', path, 'imageSize', imageSize, 'imageDim', imageDim, ...
    'numTest', numTest, 'numValidation', numValidation, 'numTrain', numTrain, ...
    'kernel', kernel, 'C', C, 'numAug', numAug);