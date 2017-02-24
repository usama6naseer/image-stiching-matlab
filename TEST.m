clear all;
% % c1 = 'sd1.jpg';
% % c2 = 'sd2.jpg';
c1 = 'left.jpg';
c2 = 'right.jpg';
a1 = KLT(c1,1,7,2,3);
a2 = KLT(c2,1,7,2,3);
[mac1 mac2] = correspondence(c1,c2,a1,a2,2,14);
%%
i1 = imread(c1);
i2 = imread(c2);
figure;
imshow(i1);
hold on;
plot(a1(1,:),a1(2,:),'bo');
figure;
imshow(i2);
hold on;
plot(a2(1,:),a2(2,:),'bo');
figure;
imshowpair(i1,i2,'montage');
hold on;
sp = size(i1);
sp = sp(2);
for i=1:2:25
    plot(mac1(i),mac1(i+1),'bo');
end
for i=1:2:25
    plot(sp+mac2(i),mac2(i+1),'bo');
end

for i=1:2:25
    plot([mac1(i),sp+mac2(i)],[mac1(i+1),mac2(i+1)],'r--');
end
%%
% cor1(8,2) = zeros;
% cor2(8,2) = zeros;
% count = 1;
% for i=1:2:15
%     cor1(count,1) = mac1(i);
%     cor1(count,2) = mac1(i+1);
%     cor2(count,1) = mac2(i);
%     cor2(count,2) = mac1(i+1);
%     count=count+1;
% end
% h = computeH(cor1,cor2);

%%
% Code provided by Tayyab Bhai
x1 = [mac1(1); mac1(3); mac1(5); mac1(7)];
y1 = [mac1(2); mac1(4); mac1(6); mac1(8)];
x2 = [mac2(1); mac2(3); mac2(5); mac2(7)];
y2 = [mac2(2); mac2(4); mac2(6); mac2(8)];

T=maketform('projective',[x2 y2],[x1 y1]);
T.tdata.T

[im2t,xdataim2t,ydataim2t]=imtransform(i2,T);
xdataout=[min(1,xdataim2t(1)) max(size(i1,2),xdataim2t(2))];
ydataout=[min(1,ydataim2t(1)) max(size(i1,1),ydataim2t(2))];
im2t=imtransform(i2,T,'XData',xdataout,'YData',ydataout);
im1t=imtransform(i1,maketform('affine',eye(3)),'XData',xdataout,'YData',ydataout);

ims=im1t/2+im2t/2;
figure, imshow(ims)
% Code provided by Tayyab Bhai