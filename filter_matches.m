function [matches, occ, diff] = filter_matches(forward, backward, ratio, threshold)
  [m,n,~] = size(forward);
  u = forward(:,:,1); v = forward(:,:,2);
  [x1, y1] = meshgrid(1:n, 1:m);
  x2 = x1 + u;  y2 = y1 + v;

  % out-of-boundary pixels
  B = (x2>n) | (x2<1) | (y2>m) | (y2<1);
  x2(B) = x1(B);   y2(B) = y1(B);
  inv_u = interp2(backward(:,:,1), x2, y2, 'linear', 0);  inv_v = interp2(backward(:,:,2), x2, y2, 'linear', 0);
  diff = sqrt((u+inv_u).^2 + (v+inv_v).^2);
  occ = diff <= threshold; occ(B) = 0;

  % count bump in the second image
  count = zeros(m,n);
  for r=1:m,
  	for c=1:n
      c1 = round(x2(r,c)); r1 = round(y2(r,c)); count(r1, c1) = count(r1, c1)+1;
    end
  end
  occ(count>=2) = 0;

  j = x1; i = y1;
  matches = [ratio*j(:) - ceil(ratio/2), ratio*i(:) - ceil(ratio/2), ratio*(j(:)+u(:)) - ceil(ratio/2), ratio*(i(:)+v(:)) - ceil(ratio/2)];
  valid = find(occ);
  matches = matches(valid, :);
end
