function img_NN = NearestNeighbor(img, scale)
    [rows, cols, depth] = size(img);
    R = rows * scale;
    C = cols * scale;
    img_NN = zeros([R, C, depth]);
    
    for i=0:R-1
        for j=0:C-1
            for k=1:depth
                img_NN(i+1, j+1, k) = img(floor(i/scale)+1, floor(j/scale)+1, k);
            end
        end
    end
end