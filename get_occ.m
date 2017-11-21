function get_occ(fns, fns_in, occ_threshold)
    flows = cell(size(fns));
    for i = 1:length(fns)
        flows{i} = readFlowFile([fns{i}, '.flo']);
    end
    for i=1:length(flows)
        cur = flows{i}; next = flows{mod(i, length(flows)) + 1};
        fn_pre = fns{i}; 
        % get occlusion mask 
        [matches, occ, diff] = filter_matches(cur, next, 1, occ_threshold);
        imwrite(occ, [fn_pre, sprintf('_occ_t%f.png', occ_threshold)]);
        imwrite(diff, [fn_pre, '_diff.png']);
        % get visulization of the flow
        cur_vis = flowToColor(cur);
        imwrite(cur_vis, [fn_pre, '_flow.png']);
        % get visualization of disp
        disp = cur(:,:,1); d = min(min(disp)); D = max(max(disp)); disp = (disp-d)/(D-d);
        imwrite(disp, [fn_pre, '_disp.png']);
        figure(); imshow(disp);
        % get masked flow
        occ = 0.5+occ/2;
        masked_vis = mask_occ(cur_vis, occ);
        imwrite(masked_vis, [fn_pre, sprintf('_masked_flow_occ_t%f.png', occ_threshold)]);
        figure(); imshow(masked_vis);
        % get masked original image
        im = imread([fns_in{i}, '.png']);
        masked_im = mask_occ(im, occ);
        imwrite(masked_im, [fn_pre, sprintf('_masked_occ_t%f.png', occ_threshold)]);
        figure(); imshow(masked_im);
        diff_masked_im = mask_occ(im, 1+min(1, diff)/2);
        imwrite(diff_masked_im, [fn_pre, '_diff_masked.png']);
        figure(); imshow(diff_masked_im);
    end
end


function im = mask_occ(flow, occ)
    im = flow;
    for c = 1:size(flow, 3)
        channel = double(im(:,:,c));
        channel = channel.*double(occ);
        im(:,:,c) = uint8(channel);
    end
end
