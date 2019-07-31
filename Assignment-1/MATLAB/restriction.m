clear all; clc; close all;

K = 4;
N = 2*K;
h = 1/N;
R = zeros(K-1, N-1);
G = ceil(sqrt(8));

for i=1:K-1
    R(i,2*i) = 1;
end

xfine = h * (0:N)';
xcoarse = 2*h * (0:K)';

for m=1:N-1
    subplot(G, G, m);
    fplot(@(x) sin(m * pi * x), [0,1]);
    hold on;
    plot(xfine, sin(m * pi * xfine));
    plot(xcoarse, [0; R*sin(m * pi * xfine(2:N)); 0]);
    legend('sine', 'fine', 'coarse');
    title(sprintf('m=%d', m));
end