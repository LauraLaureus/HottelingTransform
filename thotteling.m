%%Input zone
%%data = cat(3,imread('banda1.tif'),imread('banda2.tif'),imread('banda3.tif'),imread('banda4.tif'),imread('banda5.tif'),imread('banda6.tif'));
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

result(:,i) = test*sortedEigenVector;
end

b1 = reshape(result(1,:),size(imread('banda2.tif')));
b2 = reshape(result(2,:),size(imread('banda2.tif')));
b3 = reshape(result(3,:),size(imread('banda2.tif')));
b4 = reshape(result(4,:),size(imread('banda2.tif')));
b5 = reshape(result(5,:),size(imread('banda2.tif')));
b6 = reshape(result(6,:),size(imread('banda2.tif')));

im = b5;
d=linspace(min(im(:)),max(im(:)),256);
im1=uint8(arrayfun(@(x) find(abs(d(:)-x)==min(abs(d(:)-x))),im));
