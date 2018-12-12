function [Summary] = Evaluate(Results, TestLabels, Params)

load('./Peppers/PeppersData.mat');  

% Lower threshold classification
tMin=min(Results);
% Upper threshold classification
tMax=max(Results);
t=(tMin:0.1:tMax);

% initialize vectors with zeros
Recall=zeros(length(t),1);
Precision=zeros(length(t),1);
TestResults=zeros(1,length(Results));
Error_Rate_matrix=zeros(1,length(t));

for i=1:length(t)
    % Classify all the positive values to the first class - 1 
    TestResults(Results>t(i))=1;
    % Classify all the negative values to the second class - (-1)
    TestResults(Results<t(i))=-1;
    % Calculate sensitivity
    Recall(i)=sum((TestResults==TestLabels).*(TestLabels==1))/(sum(TestLabels==1));
    % Calculate positive predictive value
    Precision(i)=sum((TestResults==TestLabels).*(TestLabels==1))/(sum(TestResults==1));
    % Calculate Accuracy
    Error_Rate_matrix(i)=100*sum(TestLabels~=TestResults)/length(TestLabels);%The AVG error for all the images in the tests

end

% Plot Accuray with all the thresholds
plot(t(:),Error_Rate_matrix);
xlabel('t');
ylabel('Error Rate Matrix');
%set(gca, 'xtick' ,t(:));
set(gca,'xtickLabels',t(:));

%Calculate accuracy with threshold 0 for tuning parameters
TestResults(Results>0)=1;
TestResults(Results<0)=-1; 
Error_Rate=100*sum(TestLabels~=TestResults)/length(TestLabels);%The AVG error for all the images in the tests

% Print the 5 max errors - alpha and beta:

% Initialize the errors vector
errors=TestLabels-TestResults;

for i=1:5
alpha_error=find(errors==2);%if the image is pepper and the classifier tell it is not - FN
beta_error=find(errors==-2);%if the image is not pepper and the classifier tell it is - FP

[maxTypeOneError,alphaInd]=min(Results(alpha_error));% Take the minimum result of type 1 error
[maxTypeTwoError,betaInd]=max(Results(beta_error));% Take the maximum result of type 2 error

alphaInd=alpha_error(alphaInd);% find the index of type 1 error
betaInd=beta_error(betaInd);% find the index of type 2 error

figure;
    image(Images{alphaInd});
    if TestLabels(alphaInd)==1
        title(strcat('Pepper -',' Type 1 Error ',', Classification Score: ',num2str(maxTypeOneError), ', index: ',num2str(i)));
    else
        title('Not Pepper');
    end
    waitforbuttonpress;
 
    image(Images{betaInd});
    if TestLabels(betaInd)==1
        title('Pepper');
    else
        title(strcat('Not Pepper -',' Type 2 Error ',', Classification Score: ',num2str(maxTypeTwoError), ', index: ',num2str(i)));
    end
    waitforbuttonpress;
% Put zero in the indexes of the images with the max errors for finding the
% next type 1 and 2 errors
errors(alphaInd)=0;
errors(betaInd)=0;
end


Summary= struct('Error_Rate', Error_Rate, 'Recall',Recall,'Precision',Precision);

