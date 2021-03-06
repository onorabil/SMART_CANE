function [err]=sift_test(i)

if i<10
    [s, err]=sprintf('hw2/hw2_000%d.dat', i);
elseif i<100
    [s, err]=sprintf('hw2/hw2_00%d.dat', i);
else
    [s, err]=sprintf('hw2/hw2_0%d.dat', i);
end

a = load(s);
img1 = double(a(144*3+1:144*4, :)/256);
f1 = figure(1); imagesc(a(144*3+1:144*4, :)); colormap(gray);
[frm1, des1] = sift(img1, 'Verbosity', 1); 

a=load('hw2/hw2_0015.dat');
img2=double(a(144*3+1:144*4, :)/256);
f2=figure(2); imagesc(a(144*3+1:144*4, :)); colormap(gray);
[frm2, des2] = sift(img2, 'Verbosity', 1); 

match = siftmatch(des1, des2);

f3=figure(3);
plotmatches(img1,img2,frm1,frm2,match);
