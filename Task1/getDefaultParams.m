function params = getDefaultParams()
%{
getDefaultParams returns a struct that contain the default experiment parameters
It has several fields, each itself a struct of parameters for the various
experiment stages.

Parameters explainations:

seed - ; 
dataInserted - check if the data already inserted to arrays;
needValidation - check if need to do validation;
needTraining - check if need to do training;
splitRatio = 0.5;
C = 1;
cellSize=10;
s=150;
bins=9;
kernel=polynomial(2);
path = '.\101_ObjectCategories\' ;
numOfImagesInClasses = [];
Images_names = [];
classIndices = (1:10);%default
trainAmount = 40;
testAmount = 20;
%}
addpath('.\packages\AngliaSVM')
seed = 1754; 
dataInserted = false;
needValidation = false;
needTraining = false;
splitRatio = 0.5;
C = 1;
cellSize=10;
s=150;
bins=9;
kernel=polynomial(2);
path = '.\101_ObjectCategories\' ;
numOfImagesInClasses = [];
Images_names = [];
classIndices = (1:10);%default
trainAmount = 40;
testAmount = 20;

params = struct('seed', seed, 'dataInserted', dataInserted, 'needValidation', needValidation, ...
    'needTraining', needTraining,'s', s, 'path', path,'C',C,'bins', bins,'kernel', kernel, 'cellSize',cellSize,'splitRatio', splitRatio, ...
    'numOfImagesInClasses', numOfImagesInClasses,'Images_names',Images_names, ...
    'classIndices', classIndices, 'trainAmount', trainAmount, 'testAmount', testAmount);




