%%Input zone

b1 = reshape(imread('a.jpg'),1,[]);
b2 = reshape(imread('b.jpg'),1,[]);
b3 = reshape(imread('c.jpg'),1,[]);
b4 = reshape(imread('d.jpg'),1,[]);
b5 = reshape(imread('e.jpg'),1,[]);

data = [b1;b2;b3;b4;b5];

centroides = sum(data)/5;

aux = repmat(centroides,size(data,1),1);
normalizado = double(data) - aux;

result = zeros(size(normalizado));
errors = zeros(1,5);
for k = 1:5

    for i=1:size(data,2)
        this = normalizado(:,i)';
        covariance = this'*(this)/size(data,1);
        
        [eignv, eignvls] = eig(covariance);

        %%ordenar los autovalores
        [sortedEigenValues, sortIndexes] = sort(diag(eignvls),'descend');
        sortedEigenVector = eignv(:,sortIndexes);

        sortedEigenVector = sortedEigenVector(1:k,:);

        result(:,i) = this(:,1:k)*sortedEigenVector;
        errors(k) = errors(k)+ sum(sortedEigenValues(k:end));
    end
end

b1 = reshape(result(1,:),size(imread('a.jpg')));
b2 = reshape(result(2,:),size(imread('a.jpg')));
b3 = reshape(result(3,:),size(imread('a.jpg')));
b4 = reshape(result(4,:),size(imread('a.jpg')));
b5 = reshape(result(5,:),size(imread('a.jpg')));



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


%plot the errors
figure, plot(1:5,errors);