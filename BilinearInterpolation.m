function img_BL = BilinearInterpolation(img, scale)
    [rows, cols, depth] = size(img);
    R = rows * scale;
    C = cols * scale;
    img_BL = zeros([R, C, depth]);
    
    for i=1:R
        rx = i / scale;
        r = floor(rx);
        if r < 1 
            r = 1; 
        end
        delta_x = rx - r;
        for j=1:C
            cy = j / scale;
            c = floor(cy);
            if c < 1 
                c = 1; 
            end
            delta_y = cy - c;
            for k=1:depth
                a2 = 0;
                a3 = 0;
                a4 = 0;
                a1 = img(r, c, k) * (1-delta_x) * (1-delta_y);
                if r < rows 
                    a2 = img(r+1, c, k) * delta_x * (1-delta_y);
                end    
                if c < cols 
                    a3 = img(r, c+1, k) * (1-delta_x) * delta_y;
                end
                if r < rows && c < cols
                    a4 = img(r+1, c+1, k) * delta_x * delta_y;
                end
                img_BL(i, j, k) = a1 + a2 + a3 + a4;
            end
        end
    end
            
end