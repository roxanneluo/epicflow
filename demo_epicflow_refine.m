match_method = '_dcflow_sintel_r2.00_D25'
out_method = [match_method, '+epicflow_refine'];
in_folder = '../data/sintel_h436w1024/';
out_folder = 'results/';
match_folder = '../dcflow/results/';
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
    fns_out = add_prefix_suffix(out_folder, fns, out_method);
    fns_match = add_prefix_suffix(match_folder, fns, [match_method, '_matches.txt']);
   
    % compute flows
    for j = 1:length(fns)
        next_j = mod(j, length(fns)) + 1;
        flow_fn = epicflow_refine([fns_in{j}, '.png'], [fns_in{next_j}, '.png'],...
            [fns_out{j}, '.flo'], fns_match{j});
    end

    % compute occlusion
    get_occ(fns_out, fns_in, occ_threshold);
end
