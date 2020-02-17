close all
clear
clc
%Miranda Heredia 100996160
%Assignment 2 
%% Question 1 - Part A
% A grid and specifixc boundary conditions were defined for this problem.
% Using finite difference method and (GV = F), the electrostatic
% potential was found and plotted

%Intializing the Dimensions of the matrix

Length = 30;    %the x-axis upper limit
Width = 20;     %The y-axis upper limit

%Initialize G and F matrix
%Solution will be in the form of Ax = b, where x = b\A
%Our solution will be GV = F, solving for V

G = sparse(Length*Width, Length*Width); %sparse to store non-zero elements
F = zeros(Length*Width, 1);

%Populating G matrix and Boundary Conditions using a loop

for x =1:Length
    for y=1:Width
        n =  y +(x-1)*Width;    %Mapping equation FD - current position
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
            F(n) =1;
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
%Creating sparse matrix
figure(1)
spy(G)
SolV = G\F;

%must create matrix to plot the surf()

SolVmatrix = zeros(Length, Width);

for i=1:Length
    for j=1: Width
        n = j+(i-1)*Width;
        SolVmatrix(i,j) = SolV(n);
        
    end
end

% Plot 1
figure(2)
surf(SolVmatrix)
colorbar
title("Voltage Plot using FD in 1D")
xlabel("X position")
ylabel("Y position")
zlabel("Voltage")




        

