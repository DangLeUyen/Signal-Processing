function T = result_metrics(YPred,YTest)
   
    overallaccuracy = mean(YPred == YTest);
    
    fprintf("Accuracy: %.2f%%\n", overallaccuracy*100);
    
    classes = categories(YTest);
    C = confusionmat(YTest, YPred);
    
    numClasses = numel(classes);
    accuracy = zeros(numClasses,1);
    precision = zeros(numClasses,1);
    recall    = zeros(numClasses,1);
    f1score   = zeros(numClasses,1);
    
    for i = 1:numClasses
    
        TP = C(i,i);
        FP = sum(C(:,i)) - TP;
        FN = sum(C(i,:)) - TP;
    
        precision(i) = TP / (TP + FP + eps);
        recall(i)    = TP / (TP + FN + eps);
        accuracy(i) = TP / sum(C(i,:));
    
        f1score(i) = 2 * precision(i)*recall(i) / ...
                     (precision(i) + recall(i) + eps);
    end
    
    macroF1 = mean(f1score);
    
    fprintf("Macro F1-score: %.4f\n", macroF1);
    fprintf("Macro precision: %.4f\n", mean(precision));
    fprintf("Macro recall: %.4f\n", mean(recall));
    
%     T = table(classes, accuracy, precision, recall, f1score, ...
%         'VariableNames', {'Class','Accuracy', 'Precision','Recall','F1'});
    T = table(overallaccuracy, mean(precision), mean(recall), macroF1, ...
        'VariableNames', {'Accuracy', 'Precision','Recall','F1'});

end