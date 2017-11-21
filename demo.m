f = get_epicflow('test_right_0.5.png', 'test_left_0.5.png', 'flow_right.flo');
% compute optical flow for frames in a folder (see dir_get_epicflow.m for more options)
% dir_get_epicflow(FOLDER_PATH, FLOW_SAVE_FOLDER_PATH)
% visualize result (uses Middlebury optical flow toolbox)
addpath(genpath('utils'));
imshow(flowToColor(readFlowFile(f)));
imwrite(flowToColor(readFlowFile(f)), 'epic_flow_right.png')