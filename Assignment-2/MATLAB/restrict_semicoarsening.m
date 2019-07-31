% only coarses in x-direction
function rCoarse = restrict_semicoarsening(r);

Nx = length(r(:,1)) - 1;
Ny = length(r(1,:)) - 1;
% initialise coarsened vector
rCoarse = zeros( Nx/2+1,Ny + 1);

if ( mod (Nx,2) ~= 0)
    disp('Error! Cannot coarse any further in x-direction!')
    return
end
if ( mod (Ny,2) ~= 0)
    disp('Error! Cannot coarse any further in y-direction!')
    return
end

% loop over inner points and compute the coarsened representation.
% We do not work on the boundary/ outer points, since we expect the
% residual to be zero there anyway.
for i=2 : 1 : Nx/2
    for j = 2 : 1 : Ny
        rCoarse(i,j) = 1/4*(  r(2*(i-1)+1,j ) ...
                            + r(2*(i-1)  ,j ) )...
                     + 1/2*   r(2*(i-1)+1,j );
    end
end

return