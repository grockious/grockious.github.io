close all
%choose the run number here
run_number=mini;
%
v = VideoWriter('animation1_w.avi');
open(v);
figure('Position', [700, 100, 1049, 895])
fx_X=linspace(0.5,X(end)+0.5,max(size(X))+1);
fx_Y=linspace(0.5,Y(end)+0.5,max(size(Y))+1);
[fx_x,fx_y]=meshgrid(fx_X,fx_Y);
%redefine u
u=ones(41,41);
u(1:5,1:5)=4;
u(6:35,6:35)=3;
u(16:25,16:25)=2;
u(26:35,19:22)=1;
%
z=u.^2;
surf(fx_x,fx_y,z)
set(gca,'xlim',[0.5 max(size(X))+0.5])
set(gca,'ylim',[0.5 max(size(Y))+0.5])
view([90 -90])

for n=1:minv
    hold on
    h1=plot3(accepted_pathes{run_number}(n,2),accepted_pathes{run_number}(n,1),...
        -((accepted_pathes{run_number}(n,3))^2+100),'.','MarkerSize', 25,'MarkerEdgeColor','r','MarkerFaceColor','r');
    set(gca,'xtick',1:max(size(X)))
    set(gca,'ytick',1:max(size(Y)))
    drawnow
    frame = getframe;
    writeVideo(v,frame);
    h1=plot3(accepted_pathes{run_number}(n,2),accepted_pathes{run_number}(n,1),...
        -((accepted_pathes{run_number}(n,3))^2+100),'.','MarkerSize', 25,'MarkerEdgeColor','g','MarkerFaceColor','g');
%   delete(h1)  
end
close(v)