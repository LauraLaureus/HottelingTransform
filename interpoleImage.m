function [im1] = interpoleImage(im)
d=linspace(min(im(:)),max(im(:)),256);
im1=uint8(arrayfun(@(x) find(abs(d(:)-x)==min(abs(d(:)-x))),im,false));

end