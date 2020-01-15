%PRISM to MATLAB
%import PRISM file as a "Numeric Matrix" > run this script > save MATLAB worksapce
%copyrigh (c) University of Oxford

z=ones(40,40);
for i=1:1600
    X=mod(i,40);
    if X==0
        X=40;
    end
    Y=1+(i-X)/40;
    z(X,Y)=PRISMreturnedfile(3,i);
end
X=linspace(1,40,40);
Y=linspace(1,40,40)';
[x,y]=meshgrid(X,Y);
surf(x,y,z)
view([63 28])
