%%Input zone
data = cat(3,imread('banda1.tif'),imread('banda2.tif'),imread('banda3.tif'),imread('banda4.tif'),imread('banda5.tif'),imread('banda6.tif'));

centroides = sum(data,3)/ size(data,3);

%pre-normalización
aux = zeros(size(data));

for x = 1:size(data,1)
    for y = 1:size(data,2)
        aux(x,y,:) = centroides(x,y);
    end
end

normalizado = double(data) - aux;

covarianzas = (normalizado' * normalizado)/size(data,3);

[eignv, eignvls] = eig(covarianzas);

eignv
eignvls
diagonal = zeros(size(eignvls,1));
for d = 1:size(eignvls,1)
    diagonal(d) = eignvls(d,d);
end

%%ordenar los autovalores

[sortedEigenValues, pemutationIndex] = sort(diagonal,'descend');
sortedEigenVector = covarianzas(permutationIndex,:);

result = data*sortedEigenVector;



