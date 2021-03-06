function neri_match2(i)

prefix = 'of1/of1';
if i<10
    [s, err]=sprintf('%s_000%d.dat', prefix, i);
elseif i<100
    [s, err]=sprintf('%s_00%d.dat', prefix, i);
else
    [s, err]=sprintf('%s_0%d.dat', prefix, i);
end

a = load(s);

z=a(1:144, :);  x=a(145:288, :);  y=a(289:432, :);
idx=find(z==0); x(idx)=nan; y(idx)=nan; z(idx)=nan;
x1=medfilt2(x);  y1=medfilt2(y);    z1=medfilt2(z);
f4=figure(4);   imagesc(z1);    colormap(gray);     title(['Range image: frame ', int2str(i)]);

[imgc1, img1]=convert_triband(x1,y1,z1);

img1=img1/max(max(img1));
f1 = figure(1); imagesc(img1); colormap(gray); title(['NERI: frame ', int2str(i)]);
[frm1, des1] = sift(z1, 'Verbosity', 1);  %plotsiftframe(frm1);

i=i+3;
if i<10
    [s, err]=sprintf('%s_000%d.dat', prefix, i);
elseif i<100
    [s, err]=sprintf('%s_00%d.dat', prefix, i);
else
    [s, err]=sprintf('%s_0%d.dat', prefix, i);
end

b=load(s);
z=b(1:144, :);  x=b(145:288, :);  y=b(289:432, :);
idx=find(z==0); x(idx)=nan; y(idx)=nan; z(idx)=nan;
x2=medfilt2(x);  y2=medfilt2(y);    z2=medfilt2(z);
f5=figure(5);   imagesc(z2);    colormap(gray);     title(['Range image: frame ', int2str(i)]);

[imgc2, img2]=convert_triband(x2,y2,z2); 

img2=img2/max(max(img2));
f2=figure(2); imagesc(img2); colormap(gray); title(['NERI: frame ', int2str(i)]);
[frm2, des2] = sift(z2, 'Verbosity', 1); %plotsiftframe(frm2);

match = siftmatch(des1, des2);

f3=figure(3);
plotmatches(img1,img2,frm1,frm2,match);

f4=figure(6);   hist(z2);   title(['Histogram: frame ', int2str(i)]);


