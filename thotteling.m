%%Input zone
data = imread('');

centroides = sum(data,2)/ size(data,1);

%pre-normalización
aux = zeros(size(data));

for c = 1:size(data,2)
    aux(:,c) = centroide(c);
end

normalizado = data - aux;

covarianzas = (normalizado' * normalizado)/size(data,1);

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



