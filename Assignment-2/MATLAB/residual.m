% computes the residual for a 2D (an)isotropic Poisson problem
% a,b    - coefficients in front of second derivatives of Poisson problem
% u      - solution vector
% rhs    - right hand side of poisson problem
function res=residual(a,b,u,rhs);

% size of solution in x- and y-direction (including boundary points)
Nx = length(u(:,1)) - 1;
Ny = length(u(1,:)) - 1;
% mesh size
hx = 1/Nx;
hy = 1/Ny;

% initialise residual
res = zeros(Nx+1,Ny+1);

% compute residual
for i = 2 : 1 : Nx
    for j = 2 : 1 : Ny
        res(i,j) = rhs(i,j) - a/hx^2*(u(i-1,j)-2*u(i,j)+u(i+1,j)) - b/hy^2*(u(i,j-1)-2*u(i,j)+u(i,j+1));
    end
end

return
