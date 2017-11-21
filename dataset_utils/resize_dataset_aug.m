folder_in = '../../data/fullsize/';
opts.mode = 'crop'; opts.size = [436, 1024];
folder_out = sprintf('../../data/%s_h%dw%d/', opts.mode, opts.size);

addpath('../utils/');
im_names = dir([folder_in, '*.png']);
mkdir(folder_out);
for i = 1:length(im_names)
    fn_in = [folder_in, im_names(i).name];
    fn_out = [folder_out, im_names(i).name];
    im = imread(fn_in);
    im_out = imresize_aug(im, opts);
    imwrite(im_out, fn_out);
end
