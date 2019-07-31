N=8;
h=1/N;
omega=1/2;
hold off

u=zeros(N+1,1);
iterationSteps=10;
e = zeros(iterationSteps+1,1);
reductionFactor = zeros(iterationSteps,1);

%%% initialise u at a given frequency
k=2;
for i=1 : 1 : N+1
    u(i)=sin(k*pi*h*(i-1));
end

%%% plot solution and hold the graph
plot([0:1:N]*h,u)
hold on

e(1)=max(abs(u))

for it=1 : 1 : iterationSteps
    uOld=u;
    for i = 2 : 1 : N
        % Jacobi
        %u(i) = 0.5*(uOld(i-1)+uOld(i+1));
        % weighted Jacobi
        u(i) = 0.5*omega*(uOld(i-1)+uOld(i+1))+(1-omega)*u(i);
    end
    e(it+1) =max(abs(u))
    reductionFactor(it) = e(it+1)/e(it);
    plot ([0:1:N]*h,u,'r.-')
end




