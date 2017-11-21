function out_names = add_prefix_suffix(prefix, names, suffix)
    out_names = cell(size(names));
    for i = 1:length(names)
        out_names{i} = [prefix, names{i}, suffix];
    end
end
