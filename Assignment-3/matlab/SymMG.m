
Level = 4;
N=2^Level+1;
h=1/N;
epsi=0.2*h;

stencil = [ (epsi/h^2-1/h)  -2*epsi/h^2+1/h  epsi/h^2];
interpolation = [-stencil(1)/stencil(2) 1 -stencil(3)/stencil(2)];

R = [interpolation 0 0 0 0;
     0 0 interpolation 0 0;
     0 0 0 0 interpolation];
 
 A = [stencil(2) stencil(3) 0 0 0 0 0;
      stencil 0 0 0 0;
      0 stencil 0 0 0;
      0 0 stencil 0 0;
      0 0 0 stencil 0;
      0 0 0 0 stencil;
      0 0 0 0 0 stencil(1) stencil(2)];
  
  
  stencilCoarse = 1/stencil(2)*[-stencil(1)^2 stencil(1)^2+stencil(3)^2 -stencil(3)^2];