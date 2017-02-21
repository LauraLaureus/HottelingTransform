%%Input zone

b1 = reshape(imread('a.jpg'),1,[]);
b2 = reshape(imread('b.jpg'),1,[]);
b3 = reshape(imread('c.jpg'),1,[]);
b4 = reshape(imread('d.jpg'),1,[]);
b5 = reshape(imread('e.jpg'),1,[]);

data = [b1;b2;b3;b4;b5];
data = data';
data = double(data);

C = cov(data);
[SortedEV,SortedEVls] = eigs(C);
SortedEV = SortedEV';
SortedEV = flip(SortedEV); 
mx=mean(mean(data));

y = SortedEV*(data'-mx);
 
b1 = reshape(y(1,:),size(imread('a.jpg')));
b2 = reshape(y(2,:),size(imread('a.jpg')));
b3 = reshape(y(3,:),size(imread('a.jpg')));
b4 = reshape(y(4,:),size(imread('a.jpg')));
b5 = reshape(y(5,:),size(imread('a.jpg')));

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

diagonal = diag(SortedEVls);

errors = zeros(5);

for i = 1:5
    errors(i) = sum(diagonal(1:(5-i)));
end

%plot the errors
figure, plot(1:5,errors);