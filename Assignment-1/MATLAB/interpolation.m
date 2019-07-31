clear all; clc; close all;

K = 4;
N = 2*K;
h = 1/N;
P = zeros(N-1, K-1);
G = ceil(sqrt(8));

for i=1:K-1
    P(2*i-1, i) = 0.5;
    P(2*i+1, i) = 0.5;
    P(2*i,i) = 1;
end

xfine = h * (0:N)';
xcoarse = 2*h * (0:K)';

for m=1:N-1
    subplot(G, G, m);
    fplot(@(x) sin(m * pi * x), [0,1]);
    hold on;
    scatter(xfine, [0; P*sin(m * pi * xcoarse(2:K)); 0]);
    scatter(xcoarse, sin(m * pi * xcoarse));
    legend('sine', 'fine', 'coarse');
    title(sprintf('m=%d', m));
end