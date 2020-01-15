%This script will print the MDP code for PRISM
%copyrigh (c) University of Oxford

%%Q function
Q=zeros(40,40,1);

%%Assignment matrix
up=ones(40,40);
u=ones(40,40);
u(1:5,1:5)=4;
u(6:35,6:35)=3;
u(16:25,16:25)=2;
u(26:35,19:22)=1;

safe=[];
unsafe=[];
pre_tar=[];
tar=[];
probab=0.95;

fid = fopen('PRISM.txt','wt');
fprintf(fid,'mdp\n');
fprintf(fid,'const int initial;\n');
fprintf(fid,'module MDP\n');
fprintf(fid,'s : [1..1600] init initial;\n');
for i=1:40
    for j=1:40
        neigh=AutomataNeighbors(Q,[i,j,1],up);
        for l=1:size(neigh,1)
            fprintf(fid,'[] s=%d -> %4.2f:(s''=%d)',40*(j-1)+i,probab,...
                40*(neigh(l,2)-1)+(neigh(l,1)));
            for m=1:size(neigh,1)
                if m ~= l
                    fprintf(fid,' +%4.2f/%d:(s''=%d)',(1-probab),(size(neigh,1)-1),...
                        40*(neigh(m,2)-1)+(neigh(m,1))); 
                end
            end
            fprintf(fid,';\n');
        end
    end
end
fprintf(fid,'endmodule\n');
for i=1:40
    for j=1:40
        if u(i,j)==1
            safe=[safe;i,j];
        elseif u(i,j)==3
            unsafe=[unsafe;i,j];
        elseif u(i,j)==2
            pre_tar=[pre_tar;i,j];
        elseif u(i,j)==4
            tar=[tar;i,j];
        end
    end
end

fprintf(fid,'label "safe"=');
for i=1:size(safe,1)-1
    fprintf(fid,'(s=%d)|',40*(safe(i,2)-1)+(safe(i,1)));
end
fprintf(fid,'(s=%d);\n',40*(safe(end,2)-1)+(safe(end,1)));

fprintf(fid,'label "unsafe"=');
for i=1:size(unsafe,1)-1
    fprintf(fid,'(s=%d)|',40*(unsafe(i,2)-1)+(unsafe(i,1)));
end
fprintf(fid,'(s=%d);\n',40*(unsafe(end,2)-1)+(unsafe(end,1)));

fprintf(fid,'label "pre_tar"=');
for i=1:size(pre_tar,1)-1
    fprintf(fid,'(s=%d)|',40*(pre_tar(i,2)-1)+(pre_tar(i,1)));
end
fprintf(fid,'(s=%d);\n',40*(pre_tar(end,2)-1)+(pre_tar(end,1)));

fprintf(fid,'label "tar"=');
for i=1:size(tar,1)-1
    fprintf(fid,'(s=%d)|',40*(tar(i,2)-1)+(tar(i,1)));
end
fprintf(fid,'(s=%d);\n',40*(tar(end,2)-1)+(tar(end,1)));

fclose(fid);