%Miranda Heredia
%100996160
close all
clear

%% Question 2 - Part A
%In part 2 of the assignment, the finite difference method was used to
%solve for the current flow in the box with specific boundary consitions. 

% In Part A, the current flow will be calculations, and produce plots for
% resistivity, voltage, electric field and current density

%Dimensions of grid
Length=150;
Width=Length*(2/3);

G=sparse(Length*Width,Length*Width);
F=zeros(Length*Width,1);

% Resistivity parameters
sigOut=1;
sigIn=1e-2;

% Setting up Bottleneck parameters
midX = Length/2;
midY = Width/2;
boxL = Length/4;
boxW = Width*2/3;

leftBC = midX - boxL/2;
rightBC = midX + boxL/2;
topBC = midY + boxW/2;
bottomBC = midY - boxW/2;

% Populating G matrix and sigma matrix
% Boundary conditions of bottleneck are also implemented

for x=1:Length
    for y=1:Width
        n=y+(x-1)*Width;%Mapping equation FD - current position
       
        %Local mapping of the nodes around (x,y)
        nxm = y+(x-2)*Width; 
        nxp = y+(x)*Width;
        nym = (y-1)+(x-1)*Width;
        nyp = (y+1)+(x-1)*Width;   
          
        if x == 1
            G(n,n) = 1;
            F(n) = 1;
            sigMap(x,y) = sigOut;
        elseif x == Length
            G(n,n) = 1;
            F(n) = 0;
            sigMap(x,y) = sigOut;
        elseif (y == Width)
            G(n,n) = -3;
            if(x>leftBC && x<rightBC)
                G(n,nxm) = sigIn;
                G(n,nxp) = sigIn;
                G(n,nym) = sigIn;
                sigMap(x,y) = sigIn;
            else
                G(n,nxm) = sigOut;
                G(n,nxp) = sigOut;
                G(n,nym) = sigOut;
                sigMap(x,y) = sigOut;
            end
        elseif (y == 1)
            G(n,n) = -3;
            if(x>leftBC && x<rightBC)
                G(n,nxm) = sigIn;
                G(n,nxp) = sigIn;
                G(n,nyp) = sigIn;
                sigMap(x,y) = sigIn;
            else
                G(n,nxm) = sigOut;
                G(n,nxp) = sigOut;
                G(n,nyp) = sigOut;
                sigMap(x,y) = sigOut;
            end
        else
            G(n,n) = -4;
            if( (y>topBC || y<bottomBC) && x>leftBC && x<rightBC)
                G(n,nxp) = sigIn;
                G(n,nxm) = sigIn;
                G(n,nyp) = sigIn;
                G(n,nym) = sigIn;
                sigMap(x,y) = sigIn;
            else
                G(n,nxp) = sigOut;
                G(n,nxm) = sigOut;
                G(n,nyp) = sigOut;
                G(n,nym) = sigOut;
                sigMap(x,y) = sigOut;
            end
        end
    end
end

V = G\F;
%Must create matrix to plot surf()
SolVmatrix=zeros(Length,Width);

for x=1:Length
    for y=1:Width
        n=y+(x-1)*Width;
        SolVmatrix(x,y)= V(n);
    end
end


%Plot for Sigma
figure(1)
surf(sigMap)
xlabel('x');
ylabel('y');
zlabel('V(x,y)')
title('Resistive Surface Plot');

%Plot for Voltage
figure(2)
surf(SolVmatrix)
xlabel("X position")
ylabel("Y position")
zlabel('V(x,y)')
title('Voltage Surface Plot');

%Electric Field Plots
[Ex, Ey] = gradient(SolVmatrix);
E = gradient(SolVmatrix);
J_x = sigMap.*Ex;
J_y = sigMap.*Ey;
J = sqrt(J_x.^2 + J_y.^2);


figure(3)
surf(-Ex)
xlabel("X position")
ylabel("Y position")
zlabel('Electric Field')
title('Surface Plot of X-Component Electric Field');

figure(4)
surf(-Ey)
xlabel("X position")
ylabel("Y position")
zlabel('Electric Field')
title('Surface Plot of Y-Component Electric Field');

%Current Density Plot
figure(5)
surf(J)
axis tight
xlabel("X position")
ylabel("Y position")
zlabel("Current Density")
view([40 30]);
title("Curent Density Surface Plot in the X and Y Planes")




