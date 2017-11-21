method = '_epicflow';
in_folder = '../data/crop_h600w600/';
out_folder = 'results/';
fn_pairs = {
    {'clean_bg_left', 'clean_bg_right'},...
    {'cluttered_bg_left', 'cluttered_bg_right'},...
    {'motion_blur_left', 'motion_blur_right'},...
    {'sit_left', 'sit_right'}};
occ_threshold = 0.5;
addpath(genpath('utils'));

for i = 1:length(fn_pairs)
    fns = fn_pairs{i};
    fns_in = add_prefix_suffix(in_folder, fns, '');
    fns_out = add_prefix_suffix(out_folder, fns, method);

    % compute flow
    for j = 1:length(fns)
        next_j = mod(j, length(fns)) + 1;
        flow_fn = get_epicflow([fns_in{j}, '.png'], [fns_in{next_j}, '.png'], [fns_out{j}, '.flo']);
    end

    % compute occlusion
    get_occ(fns_out, fns_in, occ_threshold);
end

