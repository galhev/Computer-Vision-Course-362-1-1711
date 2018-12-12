function [data,labels, numOfImagesInClasses, Images_names] = getData(Params)

AllFolderNames = dir(Params.path); %Get all folder (classes) names

counterImages = 0;
countImage = 1;
Params.numOfImagesInClasses = [length(AllFolderNames)-2,2];

%Count total num of images
for i=Params.classIndices 
    currentFolderPath = strcat(Params.path, AllFolderNames(i+2).name); %1 and 2 folder names are "." and ".."
    currentFolder = dir(currentFolderPath);
    currentFolderSize = length(currentFolder);
    counterImages = counterImages + currentFolderSize-2;  %1 and 2 folder names are "." and ".."
end

origData = zeros(Params.s, Params.s, counterImages);
origLabels = zeros(1, counterImages);
Params.Images_names = {counterImages,2};

%Get the data for the requested classes only - 
%according to input vector "classIndices"
classIndex=1;
for i=Params.classIndices
    
    currentFolderPath = strcat(Params.path, AllFolderNames(i+2).name);
    currentFolder = dir(currentFolderPath);
    
    Params.numOfImagesInClasses(classIndex,1) = i;
    Params.numOfImagesInClasses(classIndex,2) = length(currentFolder)-2;
    classIndex=classIndex+1;
    
    for j = 3 : length(currentFolder) %Get all images of class i
        imagePath = strcat(currentFolderPath,'\', currentFolder(j).name);
        image = imread(imagePath);
        if size(image,3) ~=1 %If pixel dimension is 3 (RGB) then turn to grey scale
           if size(image,3)==3
            image = rgb2gray(image);
           end
        end

        image = imresize(image,[Params.s,Params.s]); %Resize image to SXS
        origData(:,:,countImage) = image(:,:);
        origLabels(1,countImage) = i;
        Params.Images_names{countImage,1} = i;
        Params.Images_names{countImage,2} = strcat(AllFolderNames(i+2).name,' - ',currentFolder(j).name); %Save image path
        countImage = countImage+1;        
    end
end

data = origData;
labels = origLabels;

Params.dataInserted = true;

numOfImagesInClasses = Params.numOfImagesInClasses;
Images_names = Params.Images_names;