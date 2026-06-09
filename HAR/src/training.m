

function [net, info] = training(XTrain_sub, YTrain_sub, XVal, YVal, numClasses, numChannels, minlength, epochs)
    layers = [
        sequenceInputLayer(numChannels, 'MinLength', minlength)
    
        % ===== CNN BLOCK 1 =====
        convolution1dLayer(3,64,'Padding','same')
        batchNormalizationLayer
        reluLayer
        maxPooling1dLayer(2,'Stride',2)
    
        % ===== CNN BLOCK 2 =====
        convolution1dLayer(3,128,'Padding','same')
        batchNormalizationLayer
        reluLayer
        maxPooling1dLayer(2,'Stride',2)
    
        % ===== CNN BLOCK 3 (NEW) =====
        convolution1dLayer(3,256,'Padding','same')
        batchNormalizationLayer
        reluLayer
    
        dropoutLayer(0.3)
    
        % ===== LSTM STACK (deeper) =====
        lstmLayer(128,'OutputMode','sequence')   % NEW layer
        lstmLayer(64,'OutputMode','last')
    
        % ===== FEATURE EXTRACTION HEAD =====
        fullyConnectedLayer(256,'Name','fc_features1')
        reluLayer
        dropoutLayer(0.3)
    
        fullyConnectedLayer(128,'Name','fc_features')
        reluLayer('Name','relu_features')
    
        % ===== CLASSIFICATION HEAD =====
        fullyConnectedLayer(numClasses)
        softmaxLayer
        classificationLayer
    ];

    options = trainingOptions('adam', ...
        'MaxEpochs', epochs, ...
        'MiniBatchSize', 64, ...
        'Shuffle','every-epoch', ...
        'Verbose', false, ...
        'Plots','none', ...
        'ValidationData',{XVal, YVal}, ...
        'ValidationFrequency',5);

    [net, info] = trainNetwork(XTrain_sub, YTrain_sub, layers, options);
end