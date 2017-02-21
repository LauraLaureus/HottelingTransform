%%Input zone

b1 = reshape(imread('banda1.tif'),1,[]);
b2 = reshape(imread('banda2.tif'),1,[]);
b3 = reshape(imread('banda3.tif'),1,[]);
b4 = reshape(imread('banda4.tif'),1,[]);
b5 = reshape(imread('banda5.tif'),1,[]);
b6 = reshape(imread('banda6.tif'),1,[]);
data = [b1;b2;b3;b4;b5;b6];

data = data';
data = double(data);

C = cov(data);
[SortedEV,SortedEVls] = eigs(C);
mx=mean(mean(data));

y = SortedEV'*(data'-mx);
 
b1 = reshape(y(1,:),size(imread('banda1.tif')));
b2 = reshape(y(2,:),size(imread('banda1.tif')));
b3 = reshape(y(3,:),size(imread('banda1.tif')));
b4 = reshape(y(4,:),size(imread('banda1.tif')));
b5 = reshape(y(5,:),size(imread('banda1.tif')));
b6 = reshape(y(6,:),size(imread('banda1.tif')));

im = mat2gray(b1);
figure, subplot(3,2,1), imshow(im);

im = mat2gray(b2);
subplot(3,2,2), imshow(im);

im = mat2gray(b3);
subplot(3,2,3), imshow(im);

im = mat2gray(b4);
subplot(3,2,4), imshow(im);

im = mat2gray(b5);
subplot(3,2,5), imshow(im);
im = mat2gray(b6);
subplot(3,2,5), imshow(im);

diagonal = diag(SortedEVls);

errors = zeros(6);

for i = 1:6
    errors(i) = sum(diagonal(1:(6-i)));
end

%plot the errors
figure, plot(1:6,errors);