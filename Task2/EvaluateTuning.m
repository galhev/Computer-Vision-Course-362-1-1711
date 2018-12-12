%function [MaxImgError,Summary] = Evaluate(Results, TestLabels, Params)
function [Summary] = EvaluateTuning(Results, TestLabels, Params)

tMin=min(Results);
tMax=max(Results);
t=(tMin:0.1:tMax);

Recall=zeros(length(t),1);
Precision=zeros(length(t),1);
TestResults=zeros(1,length(Results));
Error_Rate_matrix=zeros(1,length(t));


TestResults(Results>0)=1;
TestResults(Results<0)=-1; 
Error_Rate=100*sum(TestLabels~=TestResults)/length(TestLabels);%The AVG error for all the images in the tests




Summary= struct('Error_Rate', Error_Rate);

