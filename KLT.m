function [corner1] = KLT(imginp, eigmin, s1, win, eigwin)
img1 = im2double(imread(imginp));
img = rgb2gray(img1);
hsize = size(img);
% size = 7;
sigma = 2;
pts = meshgrid(round(-s1/2):floor(s1/2), round(-s1/2):floor(s1/2));
for i=1:s1
    for j=1:s1
        gaus(i,j)=exp(-pts(i,j).^2/(2*sigma^2)-pts(i,j).^2/(2*sigma^2));
    end
end
gaus=gaus./sum(gaus(:));
imgfil = conv2(img,gaus,'same');
xfil = [-1,0,1;-1,0,1;-1,0,1];
yfil = [1,1,1;0,0,0;-1,-1,-1];
imgx = conv2(imgfil,xfil,'same');
imgy = conv2(imgfil,yfil,'same');
% win = 3; %input
% eigmin = 2; %input
c1=1;
cnr = zeros(3,10000);
%%
for i=1:hsize(1)
    for j=1:hsize(2)
        a = zeros(2,2);
        for k1=-win:win
            for k2=-win:win
                flag = 0;
                if i+k1<=0 || j+k2<=0 || i+k1>hsize(1) || j+k2>hsize(2)
                    devx = 0;
                else
                    devx = imgx(i+k1,j+k2);
                    flag = 1;
                end
                if i+k1<=0 || j+k2<=0 || i+k1>hsize(1) || j+k2>hsize(2)
                    devy = 0;
                else
                    devy = imgy(i+k1,j+k2);
                    flag = 1;
                end
                if flag == 1
                    a(1,1) = a(1,1) + devx.^2;
                    a(1,2) = a(1,2) + devx.*devy;
                    a(2,2) = a(2,2) + devy.^2;
                    a(2,1) = a(2,1) + devx.*devy;
                end
            end
        end
        lmb = eig(a);
        if min(lmb) > eigmin
%             if i < 20 && j < 20
%             elseif i < 20 && j > 500
%             elseif i > 760 && j < 20
%             elseif i > 760 && j > 500
%             else 
                cnr(1,c1) = min(lmb);
                cnr(2,c1) = j;
                cnr(3,c1) = i;
                c1=c1+1;
%             end
        end
    end
end

%%
[d1,d2] = sort(cnr(1,:),'descend');
cnr = cnr(:,d2);
corner = zeros(2,c1);
c2=1;

% figure;
% imshow(imginp);
% hold on;
% plot(cnr(2,:),cnr(3,:),'b+');


% eigwin = 5;
for i=1:c1
    if cnr(2,i) < 20 && cnr(3,i) < 20
    elseif cnr(2,i) > 760 && cnr(3,i) < 20
    elseif cnr(2,i) < 20 && cnr(3,i) > 500
    elseif cnr(2,i) > 760 && cnr(3,i) > 500
    elseif cnr(1,i) ~= 0
        cnr(1,i) = 0;
        xp = cnr(2,i);
        yp = cnr(3,i);
        corner(1,c2) = xp;
        corner(2,c2) = yp;
        c2 = c2 + 1;
        for j=1:c1
            if cnr(1,j) ~= 0
                if (cnr(2,j) > xp-eigwin && cnr(2,j) < xp+eigwin) && (cnr(3,j) > yp-eigwin && cnr(3,j) < yp+eigwin)
                    cnr(1,j) = 0;
                end
            end
        end
    end
end
corner1 = zeros(2,c2-1);
for i=1:c2-1
    corner1(1,i) = corner(1,i);
    corner1(2,i) = corner(2,i);
end
%%
% disp(c2);
% figure;
% imshow(imginp);
% hold on;
% plot(corner1(1,:),corner1(2,:),'b+');
% 
% 



end

