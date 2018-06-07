function [yes_no] = FireDetection_New(RGB,threshold)



%%

if ~isempty(threshold)
    Rt = threshold;
else
    Rt = 100;
end

format long


R = ceil(mean2(RGB(:,:,1)));
G = ceil(mean2(RGB(:,:,2)));
B = ceil(mean2(RGB(:,:,3)));

Y1 = 100 - 0.3922 * B;
Y2 = -2.0147 + 90.59435 * exp( -B/77.6027);

HSV = rgb2hsv(RGB);
S = mean2(HSV(:,:,2)) * 100;

if ( (R >= Rt) && (R >= G) && (R >= B) && (Y1>=S) && (S>=Y2) )    
    yes_no = 1;
else
    yes_no = 0;
end






end