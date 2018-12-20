clc
clear all;
close all;
I=imread('input_image.jpg');
size(I)
figure;
imshow(I);
title('Original image');
 
J=rgb2gray(I);
%whos
figure,imshow(J);
title('grayscale image');
%[a,b]=size(J);
%K = zeros(a,b);
% K=imadjust(J,[0.5 0.9],[]); 
%P=find(J >= 127.5);
%S=find(J <= 229.5);
%M=intersect(P,S);
%K(M)= J(M);
figure;
imshow(J);

level = graythresh(J);  
I=im2bw(J,level);     
I=imread('input_image.jpg');
I = im2bw(I, 0.65);
figure;
imshow(I);
title('Binary image after thresholding');


B = medfilt2(I);
figure,imshow(B);
title('median filtered image');

im = bwareaopen(B,15000);
%Binary = imfill(im,'holes');
figure,imshow(im);
title('removing connected components(pixel <6)');
gt=imread('ground_truth.jpg');
gt_binary=im2bw(gt,0.65);

gt_numeric=double(gt_binary*1);
im_numeric=double(im*1);

% gt_char=char(gt_numeric);
% im_char=char(im_numeric);

C=gt_numeric==im_numeric;
C=double(C*1);
% C=confusionmat(gt_char,im_char);
sum_1=sum(C(:)==1);
sum_0=sum(C(:)==0);

disp(sum_1);
disp(sum_0);

Accuracy1=(sum_1/((sum_1)+(sum_0)))*100;
disp(Accuracy1);

gt_1D=gt_numeric(:);
im_1D=im_numeric(:);
C1=confusionmat(gt_1D,im_1D);
disp(C1);
Accuracy2=((C1(1,1)+C1(2,2))/(C1(1,1)+C1(1,2)+C1(2,1)+C1(2,2)))*100;
disp(Accuracy2);

BW = bwmorph(im,'remove');
figure,imshow(BW);
title('morphological filtering');

BW1 = edge(BW,'sobel');
figure,imshow(BW1);
title('edge detection(sobel)');

H = vision.AlphaBlender;
J = im2single(J);
BW1 = im2single(BW1);
Y = step(H,J,BW1);
figure,imshow(Y)
title('overlay on grayscale image');
%whos

