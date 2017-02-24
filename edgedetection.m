clear all
img1 = im2double(imread('Left.JPG'));
img = rgb2gray(img1);
hsize = size(img);
size = 5;
sigma = 1;
pts = meshgrid(round(-size/2):floor(size/2), round(-size/2):floor(size/2));
for i=1:size
    for j=1:size
        gaus(i,j)=exp(-pts(i,j).^2/(2*sigma^2)-pts(i,j).^2/(2*sigma^2));
    end
end
gaus=gaus./sum(gaus(:));
% h = fspecial('gaussian', [100,100],2);
% hg = [1,2,1;2,4,2;1,2,1];
% hg1 = (1/100).*ones(10);
% imgfil = imfilter(img,h,'same');
% imgfil = conv2(double(img),double(hg1),'same');
imgfil = conv2(img,gaus,'same');
% figure;
% imshow(imgfil);
xfil = [-1,0,1;-1,0,1;-1,0,1];
yfil = [1,1,1;0,0,0;-1,-1,-1];
imgx = conv2(imgfil,xfil,'same');
imgy = conv2(imgfil,yfil,'same');
% figure;
% imshow(imgx);
% figure;
% imshow(imgy);
m = (imgx.^2 + imgy.^2);
% m = double(m);
m = m.^(1/2);
mmax = 0;
for i=1:hsize(1)
    for j=1:hsize(2)
        if m(i,j) > mmax
            mmax = m(i,j);
        end
    end
end
m = (m/mmax).*100;
for i=1:hsize(1)
    for j=1:hsize(2)
        if m(i,j) > 10
            m(i,j) = 1;
        else 
            m(i,j) = 0;
        end
    end
end
figure;
imshow(m);