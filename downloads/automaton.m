%this function defines the automaton structure
%u is what automaton reads
%u=1 safe
%u=2 pre-target
%u=3 unsafe
%u=4 target
%copyrigh (c) University of Oxford

function next_automaton_state = automaton (u,last_automaton_state)
switch last_automaton_state
    case 1
       if u == 1
             next_automaton_state=1;
         elseif u==4
             next_automaton_state=2;
         elseif u==3
             next_automaton_state=3;
         elseif u==2
             next_automaton_state=1;
       end 
    case 2
       if u == 1
            %inf means that this label is unreadable in this state
             next_automaton_state=inf;
         elseif u==4
             next_automaton_state=2;
         elseif u==3
             next_automaton_state=inf;
         elseif u==2
             next_automaton_state=inf;
       end
    case 3
       next_automaton_state=3;
end