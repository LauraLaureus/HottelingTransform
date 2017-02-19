%%Input zone
%%data = cat(3,imread('banda1.tif'),imread('banda2.tif'),imread('banda3.tif'),imread('banda4.tif'),imread('banda5.tif'),imread('banda6.tif'));
k = 1;
b1 = reshape(imread('banda1.tif'),1,[]);
b2 = reshape(imread('banda2.tif'),1,[]);
b3 = reshape(imread('banda3.tif'),1,[]);
b4 = reshape(imread('banda4.tif'),1,[]);
b5 = reshape(imread('banda5.tif'),1,[]);
b6 = reshape(imread('banda6.tif'),1,[]);
data = [b1;b2;b3;b4;b5;b6];

centroides = sum(data)/6;

%pre-normalización
aux = repmat(centroides,size(data,1),1);
normalizado = double(data) - aux;

result = zeros(size(normalizado));
errors = zeros(1,6);
for k = 1:6

for i=1:size(data,2)
test = normalizado(:,i)';
covariance = test'*(test)/size(data,1);

[eignv, eignvls] = eig(covariance);

diagonal = zeros(size(eignvls,1));
for d = 1:size(eignvls,1)
    diagonal(d) = eignvls(d,d);
end

%%ordenar los autovalores
[sortedEigenValues, permutationIndex] = sort(diagonal,'descend');
sortedEigenVector = eignv(permutationIndex(:,1),:);

sortedEigenVector = sortedEigenVector(1:k,:);

result(:,i) = test(:,1:k)*sortedEigenVector;
errors(k) = errors(k)+ sum(sortedEigenValues(k:end));
end
end

b1 = reshape(result(1,:),size(imread('banda2.tif')));
b2 = reshape(result(2,:),size(imread('banda2.tif')));
b3 = reshape(result(3,:),size(imread('banda2.tif')));
b4 = reshape(result(4,:),size(imread('banda2.tif')));
b5 = reshape(result(5,:),size(imread('banda2.tif')));
b6 = reshape(result(6,:),size(imread('banda2.tif')));


im = b1;
d=linspace(min(im(:)),max(im(:)),256);
im1=uint8(arrayfun(@(x) find(abs(d(:)-x)==min(abs(d(:)-x))),im));
figure, subplot(3,2,1), imshow(im1);

im = b2;
d=linspace(min(im(:)),max(im(:)),256);
im1=uint8(arrayfun(@(x) find(abs(d(:)-x)==min(abs(d(:)-x))),im));
subplot(3,2,2), imshow(im1);

im = b3;
d=linspace(min(im(:)),max(im(:)),256);
im1=uint8(arrayfun(@(x) find(abs(d(:)-x)==min(abs(d(:)-x))),im));
subplot(3,2,3), imshow(im1);

im = b4;
d=linspace(min(im(:)),max(im(:)),256);
im1=uint8(arrayfun(@(x) find(abs(d(:)-x)==min(abs(d(:)-x))),im));
subplot(3,2,4), imshow(im1);

im = b5;
d=linspace(min(im(:)),max(im(:)),256);
im1=uint8(arrayfun(@(x) find(abs(d(:)-x)==min(abs(d(:)-x))),im));
subplot(3,2,5), imshow(im1);

im = b6;
d=linspace(min(im(:)),max(im(:)),256);
im1=uint8(arrayfun(@(x) find(abs(d(:)-x)==min(abs(d(:)-x))),im));
subplot(3,2,6), imshow(im1);

%plot the errors
plot(1:6,errors);