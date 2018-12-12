function [TrainDataAug, TrainLabelsAug] = addAugmented(TrainData, TrainLabels, Params)
%Add augmented samples to the train data: 
%Selects images from the training set randomly,
%then decides randomly if the image's copy will be horizontally flipped
%or cropped to 80-90% of its original size.
%The cropping percentage is decided for the image width and height
%separately. The pixel from which the cropping will begin is also decided
%randomly.
 
uintType = uint8(0);
trainDataNew(Params.imageSize, Params.imageSize, ...
    Params.imageDim ,Params.numTrain + Params.numAug) = uintType;
trainLabelsNew = zeros(1, Params.numTrain + Params.numAug);
 
%Copy train data
trainDataNew(:,:,:,1:Params.numTrain) = TrainData;
trainLabelsNew(1,1:Params.numTrain) = TrainLabels;
 
%Add the samples
for i = 1:Params.numAug
    pic_index = randi([1,Params.numAug]);
    pic_data = trainDataNew(:,:,:, pic_index);
    pic_label = trainLabelsNew(1, pic_index);
 
    switch randi([1,3])
       case 1 %Flip horizontally
          pic_data_new = pic_data(: , end:-1:1 , :);
       case 2 %Crop and resize
          crop_w_pixels = ceil(((rand*0.1)+0.8) * Params.imageSize);
          crop_h_pixels = ceil(((rand*0.1)+0.8) * Params.imageSize);
          crop_w_start = randi([1,Params.imageSize-crop_w_pixels]);
          crop_h_start = randi([1,Params.imageSize-crop_h_pixels]);
          crop_w_end = crop_w_start + crop_w_pixels;
          crop_h_end = crop_h_start + crop_h_pixels;
          pic_data_new = pic_data(crop_h_start+1:crop_h_end,crop_w_start+1:crop_w_end,:);
          pic_data_new = imresize(pic_data_new,[Params.imageSize, Params.imageSize]);
        case 3
          pic_data_new = imadjust(pic_data,[.2 .3 0; .6 .7 1],[]);
    end
     
    trainDataNew(:,:,:,Params.numTrain+i) = pic_data_new;
    trainLabelsNew(1,Params.numTrain+i) = pic_label;
end
 
% Return shuffled data
shuffled_index = randperm(size(trainLabelsNew,2));
TrainDataAug = trainDataNew(:,:,:,shuffled_index);
TrainLabelsAug = trainLabelsNew(1,shuffled_index);