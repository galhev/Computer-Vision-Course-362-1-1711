function [MaxImgError,Summary] = Evaluate(Results, TestLabels, Params, TestImgNames)

[score_result Result_Labels] = max(Results); %For each image, which model "shouted" highest?
Result_Labels = Params.classIndices(Result_Labels); %Get class labels
Error_Rate = 100*sum(Result_Labels~=TestLabels)/length(TestLabels); %The error rate for all tested images
confusion_matrix=confusionmat(TestLabels,Result_Labels); %Confusion matrix
margin = zeros(length(TestLabels),5);

%Calculate margin 
counter=1;
for img=1:length(TestLabels)
    [Score_j Label_Decsion] = max(Results(:,img));%Get class result for each image
    Label_Decsion = Params.classIndices(Label_Decsion);
    if TestLabels(img)~=Label_Decsion
        Score_i=Results(find(Params.classIndices==(TestLabels(img))),img);            
        margin(counter,1) = img;
        margin(counter,2) = TestLabels(img);
        margin(counter,3) = Label_Decsion;
        margin(counter,4) = (Score_i-Score_j);
        counter=counter+1;           
    end
end

Max_Errors = {length(Params.classIndices)*2,2};

%Find the 2 worst errors (according to margin) of each class
counter = 1;
for i=1:length(Params.classIndices)
        class= Params.classIndices(i);
        temp = zeros(length(find(margin(:,2)==class)),2);
        if length(temp)~=0
            temp(:,1) = find(margin(:,2)==class);%find the real class
            temp(:,2) = margin(temp(:,1),4);  
            temp(:,1) = margin(temp(:,1),1);
            [max_error max_error_ind] = min(temp(:,2)); 
            imgMaxError = TestImgNames(1,temp(max_error_ind,1));
            temp=temp(1:end~=max_error_ind,:);
            Max_Errors{counter,1} = class;
            Max_Errors{counter,2} = imgMaxError;
            counter=counter+1;
        end
        if length(temp)~=0
           [Sec_max_error Sec_max_error_ind] = min(temp(:,2));
           Sec_imgMaxError = TestImgNames(1,temp(Sec_max_error_ind,1));
           Max_Errors{counter,1} = class;
           Max_Errors{counter,2} = Sec_imgMaxError;
           counter=counter+1;
        end
end

Summary= struct('confusion_matrix', confusion_matrix,'Error_Rate', Error_Rate);
MaxImgError = Max_Errors;