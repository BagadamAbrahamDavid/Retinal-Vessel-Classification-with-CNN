%%%% this code is for training the patches with vgg16 segnet
clc;
clear
close all
imgDir=fullfile(pwd,'TRAIN_P_2');
labelDir = fullfile(pwd,'LABEL_P_2');
imds=imageDatastore(imgDir);
classNames = ["background","vessel"];
labelIDs   = [0 255];
pxds = pixelLabelDatastore(labelDir,classNames,labelIDs);
I = read(imds);
C = read(pxds);
B=labeloverlay(I,C);
figure,imshow(B)
imageSize=size(I);
numClasses=numel(classNames);
lgraph = segnetLayers(imageSize,numClasses,'vgg16');
tbl = countEachLabel(pxds)

imageFreq = tbl.PixelCount ./ tbl.ImagePixelCount;
classWeights = median(imageFreq) ./ imageFreq
pxLayer = pixelClassificationLayer('Name','labels','ClassNames',tbl.Name,'ClassWeights',classWeights)

lgraph = removeLayers(lgraph,'pixelLabels');
lgraph = addLayers(lgraph, pxLayer);
lgraph = connectLayers(lgraph,'softmax','labels');

% opts = trainingOptions('sgdm', ...
%     'InitialLearnRate',1e-2, ...
%     'MaxEpochs',100, ...  
%     'MiniBatchSize',16, ...
%     'ExecutionEnvironment','cpu', ...
%     'VerboseFrequency',2);
opts = trainingOptions('sgdm', ...
    'InitialLearnRate',1e-1, ...
    'MaxEpochs',50, ...  
    'MiniBatchSize',64, ...
    'ExecutionEnvironment','cpu', ...
    'VerboseFrequency',2);


datasource = pixelLabelImageSource(imds,pxds);
[net_new6,info] = trainNetwork(datasource,lgraph,opts);
save net_new6 net_new6

I2=imread(imds.Files{20});
figure,imshow(I2)
C2=semanticseg(I2,net_new6);
B2=labeloverlay(I2,C2,'Transparency',0.5);
figure,imshow(B2);
figure,imshow(double(C2)==2)

