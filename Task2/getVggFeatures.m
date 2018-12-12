function Features = getVggFeatures(Data, Params)
%This function get features from the before last layer of the trained advanced network VGG.
%This features will be used in SVM model

% Download a pre-trained CNN from the web (needed once).
%urlwrite('http://www.vlfeat.org/matconvnet/models/imagenet-vgg-f.mat', ...
%    'imagenet-vgg-f.mat') ;

% Load a model
net = load('imagenet-vgg-f.mat') ;
%NET = VL_SIMPLENN_TIDY(NET) takes the NET object 
% and upgradesit to the current version of MatConvNet.
net = vl_simplenn_tidy(net) ;


% preprocess an image
netImageSize = net.meta.normalization.imageSize(1:2);
im = Data(:,:,:,1);
im = single(im) ; % note: 255 range
im = imresize(im, netImageSize) ;
im = im - net.meta.normalization.averageImage;
% Run the VGG net
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
    im = single(im) ; % note: 255 range
    im = imresize(im, netImageSize);
    im = im - net.meta.normalization.averageImage;
    res = vl_simplenn(net,im);
    DataFeatures(:,i) = res(layersNum-2).x;   
end

Features = DataFeatures;