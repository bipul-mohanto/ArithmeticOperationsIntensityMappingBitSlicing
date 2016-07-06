%% Bipul Mohanto
% Color in Informatics and MEdia Technology
% contact: bipul.mohanto@yahoo.com
% LinkedIn: https://www.linkedin.com/in/mohantobipul


%% Arithmetic operations

clear all
close all
clc

I1=imread('original.bmp');
I2=imread('original2.bmp');

DIF=max(I1-I2,I2-I1);
imshow(DIF);

% to count : just wait for morphological operations and labeling

I1=imread('chroL.bmp');
I2=imread('chroOp.bmp');
DIF=max(I1-I2,I2-I1);

I=imread('chro.bmp');
IC=cat(3,I,I,I); % color image 

for i=1:size(I,1)
    for j=1:size(I,2)
             if (max(DIF(i,j,:))~=0)
                 IC(i,j,:)=DIF(i,j,:);
             end
    end
end
figure, imshow(IC);

%% Intensity mapping

clear all
close all
clc

I=imread('spine.jpg');
imshow(I);
     
% log transform
lut=uint8((255/log(256))*log((1:256)));
J=lut(I+1);
figure, imshow(J);
   
% power-low transform
clear lut;
gamma = 0.5;
lut=uint8(255*((0:255)/255).^gamma);
clear J;
J=lut(I+1);
figure, imshow(J);

IA = imadjust(I,[],[],gamma);
figure, imshow(IA);

%% piecwise linear transform

clear all
close all
clc

I=imread('moon.tif');
imshow(I);
     
% transform definition
r1=90;
s1=60;
r2=160;
s2=190;
    
minI=min(min(I));
a=s1/(r1-minI);
b=-a*minI;
for i=0:r1
    lut(i+1)=uint8(a*i+b);
end

a=(s2-s1)/(r2-r1);
b=s1-a*r1;
for i=r1:r2
    lut(i+1)=uint8(a*i+b);
end

maxI=max(max(I));
a=(255-s2)/(maxI-r2);
b=s2-a*r2;
for i=r2:255
    lut(i+1)=uint8(a*i+b);
end    
    
J=lut(I+1);
figure, imshow(J);

%% bit slicing

clear all
close all
clc

I=imread('bill100.jpg');
img=rgb2gray(I);

chosenPlane = 5;
val=bitand(img,uint8(2^(chosenPlane-1)));
figure,imshow(val,[]);  

img2=bitshift(bitshift(img,-(chosenPlane-1)),chosenPlane-1);
figure; imshow(img2);
    
outNbBitsR=4;
outNbBitsG=3;
outNbBitsB=4;
    
imgR=I(:,:,1);
imgG=I(:,:,2);
imgB=I(:,:,3);
    
imgR2=bitshift(bitshift(imgR,-outNbBitsR),outNbBitsR);
figure; imshow(imgR2);
imgG2=bitshift(bitshift(imgG,-outNbBitsG),outNbBitsG);
figure; imshow(imgG2);
imgB2=bitshift(bitshift(imgB,-outNbBitsB),outNbBitsB);
figure; imshow(imgB2);
    
out=cat(3,imgR2,imgG2,imgB2);
figure, imshow(out);