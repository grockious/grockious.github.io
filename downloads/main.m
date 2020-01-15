%main loop of the algorithm
%copyrigh (c) University of Oxford

for run_num=1:200
    current_state=[40,40,1];
    current_path=[40,40,1];
    run_num
    for it_num=1:4000
        neigh=automata_neighbors(Q,current_state,u);
        neigh_f=ones(size(neigh,1),1);
        
        for i=1:size(neigh,1)
           neigh_f(i)=vpa(0.95*f(neigh(i,1),neigh(i,2),neigh(i,3)));
        end
        neigh_temp_f=zeros(size(neigh,1),1);
        for i=1:size(neigh,1)
           for j=1:size(neigh,1)
               if j~=i
                   neigh_temp_f(i)=vpa(neigh_temp_f(i)+0.05/(size(neigh,1)-1)*...
                       f(neigh(j,1),neigh(j,2),neigh(j,3)));
               end
           end
        end
        neigh_f=vpa(neigh_f+neigh_temp_f);
        f(current_state(1),current_state(2),current_state(3))=max(neigh_f);
        
        for i=1:size(neigh,1)
            available_Qs(i)=Q(neigh(i,1),neigh(i,2),neigh(i,3));
        end
        available_Qs=available_Qs';
        [sorted_available_Qs,sortingIndices] = sort(available_Qs,'descend');
        hom_many_maxes=find(ismember(sorted_available_Qs,sorted_available_Qs(1)));
        row_max_Q=sortingIndices(floor(hom_many_maxes(end)*rand)+1);
        if rand<0.85
            current_state=neigh(row_max_Q,:,:);
            Q(current_state(1),current_state(2),current_state(3))=(1-alpha)*...
            Q(current_state(1),current_state(2),current_state(3))+alpha*(...
            r(current_state(1),current_state(2),current_state(3))+...
            discount_factor*max(available_Qs));
        else
            current_state=neigh(floor(size(neigh,1)*rand)+1,:,:);
            state_with_max_Q=neigh(row_max_Q,:,:);
            Q(state_with_max_Q(1),state_with_max_Q(2),state_with_max_Q(3))=(1-alpha)*...
            Q(current_state(1),current_state(2),current_state(3))+alpha*(...
            r(current_state(1),current_state(2),current_state(3))+...
            discount_factor*max(available_Qs));
        end
        current_path=[current_path;current_state];
        available_Qs=[];
    end
        accepted_pathes{run_num}=current_path;
end

for i=1:run_num
    try
    A=find(ismember(accepted_pathes{i}(:,3),2));
    target_time(i)=A(1);
    catch
    target_time(i)=5000;
    end
end

plot(target_time)
[minv,mini]=min(target_time)
maxv=5000;

beep
pause(1)
beep
pause(1)
beep   
        