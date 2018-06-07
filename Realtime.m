clc;clear;close all;
%%
imaqreset
vid = videoinput('winvideo', 1, 'YUY2_640x480');
src = getselectedsource(vid);
vid.ReturnedColorspace = 'rgb';
vid.FramesPerTrigger = Inf;
vid.FrameGrabInterval = 5;

start(vid);

background = getsnapshot(vid);
indicator_matrix = [];

while (vid.FramesAcquired <=400)
    
    data = getsnapshot(vid);
    
    %    diff_im = imsubtract(data(:,:,1), rgb2gray(data));
    diff_im = imsubtract(rgb2gray(data), rgb2gray(background));
    diff_im = medfilt2(diff_im);
    level = graythresh(diff_im);
    diff_im = im2bw(diff_im,level);
    diff_im = bwareaopen(diff_im,300);  % fill holes
    
    bw = bwlabel(diff_im);
    stats = regionprops(bw,'BoundingBox','Centroid');
    imshow(data);
    
    hold on;
    
    for objects=1:length(stats)
        
        bb = stats(objects).BoundingBox;
        bc = stats(objects).Centroid;
        
        rectangle('Position',bb,'EdgeColor','r','LineWidth',2);
        plot(bc(1),bc(2),'-m+')
        
        ROI = imcrop(data,bb);
        
        [yes_no] = FireDetection_New(ROI,100);
        [indicator_matrix] = [indicator_matrix;yes_no];
        
        if yes_no
            title 'Detected Fire'
            disp 'Detected Fire'
%             yes_no
        else
            title 'Not Detected'
            disp 'Not Detected'
%             yes_no
        end
   
    end
    
    hold off
    
end

stop(vid)
flushdata(vid);

