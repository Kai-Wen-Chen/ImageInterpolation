function img_BC = BicubicInterpolation(img, scale)
    [rows, cols, depth] = size(img);
    R = rows * scale;
    C = cols * scale;
    img_BC = zeros([R, C, depth]);
    Mask = zeros(4, 4);
    t = zeros(1, 4);
    u = zeros(1, 4);
    
    for i=1:R
        rx = i / scale;
        r = floor(rx);
        if r < 1
            r = 1;
        end
        for m=1:4
            t(m) = rx - (r+m-2); %-1<=m<=2, t(m) = rx - (r+m)
        end
        
        for j=1:C
            cy = j / scale;
            c = floor(cy);
            if c < 1
                c = 1;
            end
            
            for n=1:4
                u(n) = cy - (c+n-2); %-1<=n<=2, u(n) = cy - (c+n)
            end
            
            Mask(1, 1) = g(t(1)) * g(u(1));
            Mask(1, 2) = g(t(1)) * f(u(2));
            Mask(1, 3) = g(t(1)) * f(u(3));
            Mask(1, 4) = g(t(1)) * g(u(4));
            Mask(2, 1) = f(t(2)) * g(u(1));
            Mask(2, 2) = f(t(2)) * f(u(2));
            Mask(2, 3) = f(t(2)) * f(u(3));
            Mask(2, 4) = f(t(2)) * g(u(4));
            Mask(3, 1) = f(t(3)) * g(u(1));
            Mask(3, 2) = f(t(3)) * f(u(2));
            Mask(3, 3) = f(t(3)) * f(u(3));
            Mask(3, 4) = f(t(3)) * g(u(4));
            Mask(4, 1) = g(t(4)) * g(u(1));
            Mask(4, 2) = g(t(4)) * f(u(2));
            Mask(4, 3) = g(t(4)) * f(u(3));
            Mask(4, 4) = g(t(4)) * g(u(4));
            
            if r > 1 
                r_low = r-1;
                mx_low = 1;
            else %ignore the first row of mask
                r_low = r;
                mx_low = 2;
            end
            if r > rows-2 %ignore the third (and forth) row(s) of mask
                r_high = rows;
                mx_high = rows-r+2;
            else 
                r_high = r+2;
                mx_high = 4;
            end
                
            if c > 1
                c_low = c-1;
                my_low = 1;
            else %ignore the first column of mask
                c_low = c;
                my_low = 2;
            end
            if c > cols-2 %ignore the third (and forth) column(s) of mask
                c_high = cols;
                my_high = cols-c+2;
            else
                c_high = c+2;
                my_high = 4;
            end
            
            for k=1:depth
                tmp = img(r_low:r_high, c_low:c_high, k) .* Mask(mx_low:mx_high, my_low:my_high);
                img_BC(i, j, k) = sum(sum(tmp)); 
            end
        end
    end
end