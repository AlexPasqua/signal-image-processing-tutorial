im = imread('lena_noise.png');
figure, imshow(im), title('Input image')
im = double(im);

[im_r, im_c] = size(im);
veczeros = zeros([1 im_c]);

% creating kernels
kernel(:,:,1) = [0 -0.005 0; -0.005 0.025 -0.005; 0 -0.005 0]; %Laplacian filtering: edges enphasizing
kernel(:,:,2) = [-0.1 0 0.43; -0.1 0 0.43; -0.1 0 0.43]; %directional filtering
kernel(:,:,3) = [-0.5 -0.5 -0.5; -0.5 4.85 -0.5; -0.5 -0.5 -0.5]; %high-pass filtering: sharpening

% adding a border to the image (to perform convolution)
ker_side_len = length(kernel(:,1,1));
brd = floor(ker_side_len / 2);
for i = 1 : brd
    im = [veczeros; im];
    im = [im; veczeros];
    veczeros = transpose([veczeros 0 0]);
    im = [veczeros im];
    im = [im veczeros];
    im_r = im_r+2; im_c = im_c+2;   % or: [im_r, im_c] = size(im)
    veczeros = transpose(veczeros);
end

imfilt(:,:,1) = im; clear im

% Convolution
for k = 2 : length(kernel(1, 1, :))+1 %from 2 to number of filterings (kernels) + 1
    imfilt(:,:,k) = zeros([im_r im_c]);

    for i = brd + 1 : im_r - brd
        for j = brd + 1 : im_c - brd
            % (i,j) indicates the "central" pixel
            for s = -brd : brd
                for t = -brd : brd
                    imfilt(i,j,k) = imfilt(i,j,k) + kernel(s+brd+1, t+brd+1, k-1) * imfilt(i-s, j-t, k-1);
                end
            end
        end
    end
end

figure, imshow(imfilt(:,:,k)), title('Filtered image')
