function [policy_new,policy_stable] = ...
          policy_improv_v2(obj,value_estimates,policy_old,gamma)
    
    policy_stable = true;
    num_states = obj.S;
    num_actions = obj.A;
    new_values=zeros(num_states,num_actions); 
    new_value_estimates= zeros(num_states,1);
    
    for a=1:num_actions
        for i=1:num_states
               new_value_estimates(i)=0;
               for s=1:num_states
                    value =...
                    transition_function(obj,i,a-1,s)*...
                    (reward_function(obj,i,s) + gamma*value_estimates(s));
                    new_value_estimates(i)=new_value_estimates(i)+value;
               end
               new_values(i,a)=new_value_estimates(i);
        end
    end
    
    %We want to store all actions that produce a maximum state-value.
    [maximum,~] = max(new_values');

    policy_new = zeros(num_states,num_actions);
    
    for i=1:num_states
        if (i~=2)&&(i~=11)
            [~,best_actions]=find(new_values(i,:)==maximum(i));
            num_possible_actions = length(best_actions);
            for j=1:length(best_actions)
                policy_new(i,best_actions(j)) = 1/(num_possible_actions);
            end
        end
    end
   
    counter=0;
    for k=1:length(policy_old) 
       if policy_old(k)==policy_new(k)
          counter=counter+1;
       end
    end
    
    if counter==num_states
        policy_stable = false;
    end
end