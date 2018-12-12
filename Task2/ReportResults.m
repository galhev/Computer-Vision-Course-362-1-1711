function ReportResults(Summary, Params)

% Recall Precision graph
plot (Summary.Recall,Summary.Precision);
xlabel('Recall');
ylabel('Precision');
%set(gca, 'xtick' ,Recall);
%set(gca,'xtickLabels',Recall);

%Print results to console
display1 = sprintf('The Error Rate is: %d',Summary.Error_Rate);
disp(display1);

%Write to file
mkdir('Results');
fileID = fopen('Results\ResultsOfExp.txt','w');
fprintf(fileID,display1,'ResultsOfExp(display1)');

fclose(fileID);



