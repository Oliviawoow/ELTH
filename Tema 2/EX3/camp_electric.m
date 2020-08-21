function camp_electric ()
  %reprezentare spectru
  a = 3;
  [x, y] = meshgrid (-3:0.5:3);
  [m, n] = size (x);
  
  for i = 1:m
    for j = 1:n
      r = sqrt(x (i, j) ^ 2 + y (i, j) ^ 2);
      if r != 0
        Dx (i, j) = D (r, a) * x (i, j) / r;
        Dy (i, j) = D (r, a) * y (i, j) / r;
      endif
    endfor
  endfor
  figure;
  quiver (x, y, Dx, Dy);
  title ("spectrul lui D");
  
  %reprezentare echivalori
  [x, y] = meshgrid (-4:0.5:4);
  [m, n] = size (x);
  
  for i = 1:m
    for j = 1:n
      r = sqrt(x (i, j) ^ 2 + y (i, j) ^ 2);
      echival (i, j) = D (r, a);
    endfor
  endfor
  figure;
  gradient (echival);
  contourf (x, y, echival);
  colormap cool;
  colorbar;
  title ("echivalorile lui D");
endfunction

  %functia de distributie
function ret = D (r, a)
  if r > a
    ret = (243 / (5 * r ^ 2)) + (27 / (r ^ 2));
  else
    ret = ((r ^ 3) / 5) + r;
  endif
endfunction

