function [h] = computeH(cor1, cor2)
sz = size(cor1);
sz = sz(1);
m1 = zeros(2*sz,8);
count=1;
for i=1:2:2*sz-1
    m1(i,1) = 1;
    m1(i,2) = cor1(count,1);
    m1(i,3) = cor1(count,2);
    m1(i,4) = 0;
    m1(i,5) = 0;
    m1(i,6) = 0;
    m1(i,7) = cor1(count,1)*cor1(count,1);
    m1(i,8) = cor1(count,1)*cor1(count,2);
%     m1(i,9) = 1;    
    count=count+1;
end
count=1;
for i=2:2:2*sz
    m1(i,1) = 0;
    m1(i,2) = 0;
    m1(i,3) = 0;
    m1(i,4) = 1;
    m1(i,5) = cor1(count,1);
    m1(i,6) = cor1(count,2);
    m1(i,7) = cor1(count,1)*cor1(count,2);
    m1(i,8) = cor1(count,2)*cor1(count,2);
%     m1(i,9) = 1;    
    count=count+1;
end
m2 = zeros(2*sz,1);
count=1;
for i=1:2:sz*2-1
    m2(i,1) = cor2(count,1);
    m2(i+1,1) = cor2(count,2);
    count=count+1;
end

h1 = zeros(8,1);
h1 = pinv(m1) * m2;
h = zeros(9,1);
for i=1:8
    h(i,1) = h1(i,1);
end
h(9,1) = 1;
% h = pinv(cor1) * cor2;


end

