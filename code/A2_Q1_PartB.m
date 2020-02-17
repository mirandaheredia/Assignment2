close all
clear
%Miranda Heredia 100996160
%Assignment 2 
%% Question 1 - Part B
%Similar to part A, using FD method but in 2D. Using the analytical method.


%Initializing dimensions of matrix 

Length = 50;
Width = (3/2)*Length;

G = sparse(Length*Width, Length*Width); %sparse to store non-zero elements
F = zeros(Length*Width, 1);

% Populating G matrix
for x =1:Length
    for y=1:Width
        n =  y +(x-1)*Width;    %Mapping equation FD
        %Local mapping of the nodes around (x,y)
        nxm = y+(x-2)*Width; 
        nxp = y+(x)*Width;
        nym = (y-1)+(x-1)*Width;
        nyp = (y+1)+(x-1)*Width;
        
        %Boundaries
        if x==1     %Left BC
            G(n,n) = 1;
            F(n) = 1;
        elseif x==Length    %Right BC
            G(n,n) = 1;
            F(n) =0;
        elseif y==Width     %Upper BC
            G(n,n) = 1;
        elseif y==1         %Lower BC
            G(n,n) = 1;
        else
            %Laplacian Equation in Differences
            G(n,n) = -4;
            G(n,nxm)= 1;
            G(n,nxp) = 1;
            G(n,nym) = 1;
            G(n,nyp) = 1;
        end       
    end
end

SolV = G\F;

%must create matrix to plot the surf()

SolVmatrix = zeros(Length, Width);

for i=1:Length
    for j=1: Width
        n = j+(i-1)*Width;
        SolVmatrix(i,j) = SolV(n);
    end
end

figure(1)
surf(SolVmatrix)
colorbar
title("Voltage plot using FD in 1D")
xlabel("X position")
ylabel("Y position")
zlabel("Voltage")


%variables to be used in our anayltical solution
a = Width;
b = Length/2;

x2 = linspace(-b,b, 50);
y2 = linspace(0,Width,Width);

[i,j] = meshgrid(x2,y2);

Vx = sparse(Width,Length);

%iterating to create a summation of the infinite series (finite in this
%case, ideally would be infinite for analytical)
% as n increases, the precision of the solution increases.


%Using fixed number of iterations (600) beause the analytical soltution had
%cosh and singh. Going over 600 iterations the plot does not match the
%soltion

for n = 1:2:600 
    
    Vx = (Vx + (cosh(n*pi*i/a).*sin(n*pi*j/a))./(n*cosh(n*pi*b/a)));
    figure(2)
    surf(x2,y2,(4/pi)*Vx)
    title("Analytical Method 2D Voltage Surface Plot")
    xlabel("X position")
    ylabel("Y position")
    zlabel("Voltage")
    axis tight
    view(-130,30);
    pause(0.001)
end

%% Conclusion
% After using both methods, I can conclude that the meshing and analytical
% approach similar results. However, there are some pros and cons to each
% methods. The numerical method is easy to visualize, easy to implements
% and provides decent approximations. Although some weakness is that this
% method could only handle simple equations.

%The analytical method requires an infinite sumation, so could not be
%implemented here on MATLAB. This method is slower due to sparsity.
%However, it proved a more accurate solution. 

