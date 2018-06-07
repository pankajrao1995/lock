clc;clear;close all; warning off all;
%%

[f,p] = uigetfile('*.*');
filename = [p,f];
imagedata = imread(filename);

[Detection] = FireDetection_New(imagedata,100);

if Detection
    imshow(imagedata);
    title 'Detected Fire'
    Detection;
else    
    imshow(imagedata);
    title 'Not Detected'
    Detection;
end