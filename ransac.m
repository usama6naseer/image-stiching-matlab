function [besth] = ransac(cor1, cor2)
% cor1(29,2) = zeros;
% cor2(29,2) = zeros;
% count = 1;
% for i=1:2:57
%     cor1(count,1) = mac1(i);
%     cor1(count,2) = mac1(i+1);
%     cor2(count,1) = mac2(i);
%     cor2(count,2) = mac1(i+1);
%     count=count+1;
% end
sz = size(cor1);
sz = sz(1);
besth = zeros(9,1);
f = 0;
beste = 1000000;

for i=1:100
    kp = randsample(1:sz,4);
    k1 = kp(1);
    k2 = kp(2);
    k3 = kp(3);
    k4 = kp(4);
    cc1 = [cor1(k1,1),cor1(k2,1),cor1(k3,1),cor1(k4,1);cor1(k1,2),cor1(k2,2),cor1(k3,2),cor1(k4,2)];
    cc2 = [cor2(k1,1),cor2(k2,1),cor2(k3,1),cor2(k4,1);cor2(k1,2),cor2(k2,2),cor2(k3,2),cor2(k4,2)];
    
    h1 = computeH(cc1,cc2);
    if f==0
        besth = h1;
        f=1;
    else
        e1 = h1 - besth;
        e1 = e1.^2;
        e = sum(e1);
        if e < beste
            beste = e;
            besth = h1;
        end
    end
end


end

