function ReportResults(Summary)

%Print results to console
display1 = sprintf('The Error Rate is: %d',Summary.Error_Rate);
disp(display1);

display2=sprintf('\n The Confusion Matrix is: \n\n');
disp(display2);

display3=(Summary.confusion_matrix);
disp(display3);

%Write to file
mkdir('Results');
fileID = fopen('Results\ResultsOfExp.txt','w');
fprintf(fileID,display1,'ResultsOfExp(display1)');
fprintf(fileID,display2,'ResultsOfExp(display2)');
for ii = 1:size(display3,1)
    fprintf(fileID,'%g\t',display3(ii,:));
    fprintf(fileID,'\n');
end
fclose(fileID);



