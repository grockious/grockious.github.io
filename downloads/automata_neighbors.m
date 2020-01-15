%this function determines the neighbor cells in the product MDP
%copyrigh (c) University of Oxford

function neigh = automata_neighbors (matrix,IND,u)
n=IND(1);
m=IND(2);
p=IND(3);
neigh=[n+1,m;n,m-1;n-1,m;n,m+1;n,m];
s=size(matrix);
if n-1==0
    row=find(ismember(neigh,[n-1,m],'rows'),1);
    neigh(row,:)=[];
end
if m-1==0
    row=find(ismember(neigh,[n,m-1],'rows'),1);
    neigh(row,:)=[];
end
if n+1>s(1)
    row=find(ismember(neigh,[n+1,m],'rows'),1);
    neigh(row,:)=[];
end
if m+1>s(2)
    row=find(ismember(neigh,[n,m+1],'rows'),1);
    neigh(row,:)=[];
end
Neigh_Numbers=size(neigh,1);
for i=1:Neigh_Numbers
    newcolumn(i)=automaton(u(neigh(i,1),neigh(i,2)),p);
end
neigh=[neigh,newcolumn'];
row=find(ismember(newcolumn',inf));
neigh(row',:)=[];

