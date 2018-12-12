function DataRep = Prepare(TrainData,Labels,Params)
run('.\packages\vlfeat-0.9.20\toolbox\vl_setup');

features_components = 4*Params.bins; %Size of hog's third dimention
hog_dimensionsize = (round(size(TrainData,2)/Params.cellSize))*round((size(TrainData,1)/Params.cellSize))*features_components; %each image enter to different row in tha TrainDataHog matrix
TrainDataHog = zeros(length(Labels), hog_dimensionsize);

%Create a Dalal-Triggs HOG for each input image
for i = 1:length(Labels)
    image = TrainData(:,:,i);
    img_hog = vl_hog(im2single(image), Params.cellSize, 'verbose','numOrientations', Params.bins, 'variant', 'dalaltriggs');%Take the image size and devide into cellsize, Gal-need to check:the 3rd dimension is the 4 cells comparison * 9 orientation = 36
    TrainDataHog(i,:) = img_hog(:);
end

DataRep = TrainDataHog;








