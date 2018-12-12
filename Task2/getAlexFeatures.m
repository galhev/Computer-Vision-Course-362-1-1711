function Features = getAlexFeatures(Data, Params)

% download a pre-trained CNN from the web (needed once).
% if ~exist('imagenet-caffe-alex.mat', 'file')
%  fprintf('Downloading a model ... this may take a while\n') ;
%  urlwrite('http://www.vlfeat.org/matconvnet/models/imagenet-caffe-alex.mat', ...
%    'imagenet-caffe-alex.mat') ;
% end


% Setup MatConvNet
%run './packages/matconvnet-1.0-beta17/matlab/vl_setupnn.m'


% Load a model
net = load('imagenet-caffe-alex.mat');
%NET = VL_SIMPLENN_TIDY(NET) takes the NET object 
% and upgradesit to the current version of MatConvNet.
net = vl_simplenn_tidy(net); 

% preprocess an image
netImageSize = net.meta.normalization.imageSize(1:2);
im = Data(:,:,:,1);
im = single(im) ; 
im = imresize(im, netImageSize) ;
im = im - net.meta.normalization.averageImage;
% Run the Alex NN
res = vl_simplenn(net,im);
% Number of layers
layersNum = length(res);
% Neumber of nuerons
neuronNum = size(res(layersNum-2).x,3);
DataFeatures = zeros(neuronNum,size(Data,4));
% Take the before last layer and save it
DataFeatures(:,1) = res(layersNum-2).x;

for i=2:size(Data,4)
    im = Data(:,:,:,i);
    im = single(im) ; 
    im = imresize(im, netImageSize);
    im = im - net.meta.normalization.averageImage;
    res = vl_simplenn(net,im);
    DataFeatures(:,i) = res(layersNum-2).x;   
end

Features = DataFeatures;