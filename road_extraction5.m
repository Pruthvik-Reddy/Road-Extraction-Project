clc
clear all;
close all;
I=imread('input_image5.png');
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
I=imread('input_image5.png');
I = im2bw(I, 0.55);
figure;
imshow(I);
title('Binary image after thresholding');


B = medfilt2(I);
figure,imshow(B);
title('median filtered image');

im = bwareaopen(B,1500);
%Binary = imfill(im,'holes');
figure,imshow(im);
title('removing connected components(pixel <6)');

  gt=imread('ground_truth5.png');
  gt_numeric=double(gt);
  im_numeric=double(im*1);
  
  figure,
  imshow(gt_numeric);
  title('image 5 groundtruth');
  
  gt_1D=gt_numeric(:);
  im_1D=im_numeric(:);
  
  C2=confusionmat(gt_1D,im_1D);
  disp(C2);
  
  Accuracy=((C2(1,1)+C2(2,2))/(C2(1,1)+C2(1,2)+C2(2,1)+C2(2,2)))*100;
  disp(Accuracy);

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