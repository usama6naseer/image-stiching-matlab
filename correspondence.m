function [mac1 mac2] = correspondence(imileft, imiright, a1, a2, p, ncoor)
n1 = size(a1);
n1 = n1(2);
n2 = size(a2);
n2 = n2(2);
jj1 = imread(imileft);
jj2 = imread(imiright);
img1 = im2double(jj1);
img1 = rgb2gray(img1);
hsize1 = size(img1);
img2 = im2double(jj2);
img2 = rgb2gray(img2);
hsize2 = size(img2);
%%
% p = 2; %input
arr1x = zeros(2*p+1,(2*p+1)*n1);
arr1y = zeros(2*p+1,(2*p+1)*n1);
arr1z = zeros(2*p+1,(2*p+1)*n1);
pop = p;
for i=1:n1
    for k1=-p:p
        for k2=-p:p
            if a1(2,i)+k2<=0 || a1(1,i)+k1<=0 || a1(2,i)+k2>hsize1(1) || a1(1,i)+k1>hsize1(2)
                arr1x(p+1+k1,pop+1+k2) = 0;
                arr1y(p+1+k1,pop+1+k2) = 0;
                arr1z(p+1+k1,pop+1+k2) = 0;
            else
                arr1x(p+1+k1,pop+1+k2) = jj1(a1(2,i)+k2,a1(1,i)+k1,1);
                arr1y(p+1+k1,pop+1+k2) = jj1(a1(2,i)+k2,a1(1,i)+k1,2);
                arr1z(p+1+k1,pop+1+k2) = jj1(a1(2,i)+k2,a1(1,i)+k1,3);
            end
        end
    end
    pop = pop + 2*p + 1;
end
arr2x = zeros(2*p+1,(2*p+1)*n2);
arr2y = zeros(2*p+1,(2*p+1)*n2);
arr2z = zeros(2*p+1,(2*p+1)*n2);
pop = p;
for i=1:n2
    %     disp(i);
    %     pop = pop + 2*p + 1;
    for k1=-p:p
        for k2=-p:p
            if a2(2,i)+k2<=0 || a2(1,i)+k1<=0 || a2(2,i)+k2>hsize2(1) || a2(1,i)+k1>hsize2(2)
                arr2x(p+1+k1,pop+1+k2) = 0;
                arr2y(p+1+k1,pop+1+k2) = 0;
                arr2z(p+1+k1,pop+1+k2) = 0;
            else
                arr2x(p+1+k1,pop+1+k2) = jj2(a2(2,i)+k2,a2(1,i)+k1,1);
                arr2y(p+1+k1,pop+1+k2) = jj2(a2(2,i)+k2,a2(1,i)+k1,2);
                arr2z(p+1+k1,pop+1+k2) = jj2(a2(2,i)+k2,a2(1,i)+k1,3);
            end
        end
    end
    pop = pop + 2*p + 1;
end
%%
s1 = p*2+1;
s2 = size(arr1x);
s2 = s2(2);
s3 = size(arr2x);
s3 = s3(2);
e1 = zeros(5,5);
e2 = zeros(5,5);
% dist = zeros(1,110000);
mac = zeros(5,n1*n2);
num = 1;
t1=0;
t2=0;
for i=1:s1:s2
    t1=t1+1;
    for j=1:s1:s3
        t2=t2+1;
        e1 = arr1x(1:s1,i:i+4);
        e2 = arr2x(1:s1,j:j+4);
        e3 = e2 - e1;
        e3 = e3.^2;
        sm = sum(e3);
        smx = sum(sm);
        
        e1 = arr1y(1:s1,i:i+4);
        e2 = arr2y(1:s1,j:j+4);
        e3 = e2 - e1;
        e3 = e3.^2;
        sm = sum(e3);
        smy = sum(sm);
        
        e1 = arr1z(1:s1,i:i+4);
        e2 = arr2z(1:s1,j:j+4);
        e3 = e2 - e1;
        e3 = e3.^2;
        sm = sum(e3);
        smz = sum(sm);
        sm = smx+smy+smz;
        %         disp(sm);
        mac(1,num) = a1(1,t1);
        mac(2,num) = a1(2,t1);
        mac(3,num) = a2(1,t2);
        mac(4,num) = a2(2,t2);
        mac(5,num) = sm;
        num = num + 1;
    end
    t2=0;
end
nmn = mac;
[d1,d2] = sort(mac(5,:),'ascend');
mac = mac(:,d2);
mac1 = zeros(1,28);
mac2 = zeros(1,28);

%
%
% figure;
% i1 = imread('left.jpg');
% i2 = imread('right.jpg');
% imshowpair(i1,i2,'montage');
% hold on;
cnt = 1;
for i=2:30
    mac1(cnt) = mac(1,i);
    cnt = cnt+1;
    mac1(cnt) = mac(2,i);
    cnt = cnt+1;
%     plot(mac(1,i),mac(2,i),'bo');
end
cnt = 1;
for i=2:30
    mac2(cnt) = mac(3,i);
    cnt = cnt+1;
    mac2(cnt) = mac(4,i);
    cnt = cnt+1;
%     plot(778+mac(3,i),mac(4,i),'bo');
end
for i=2:15
%     plot([mac(1,i),778+mac(3,i)],[mac(2,i),mac(4,i)],'r--');
end





