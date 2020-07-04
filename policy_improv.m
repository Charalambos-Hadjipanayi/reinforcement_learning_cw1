function [policy_new,policy_stable] = policy_improv(obj,value_estimates,policy_old,gamma)
    policy_stable = true;
    num_states = obj.S;
    num_actions = obj.A;
    new_values=zeros(num_states,num_actions); 
    new_value_estimates= zeros(num_states,1);
    
    for a=1:num_actions
        
        for i=1:num_states
               new_value_estimates(i)=0;
               for s=1:num_states
                    value = transition_function(obj,i,a-1,s) * (reward_function(obj,i,s) + gamma*value_estimates(s));
                    new_value_estimates(i)=new_value_estimates(i)+value;
               end
               new_values(i,a)=new_value_estimates(i);
        end
    end
    
    [~, best_action]= max(new_values'); 
    policy_new = zeros(num_states,num_actions);
    
    for i=1:num_states
        if (i~=2)&&(i~=11)
        policy_new(i,best_action(i)) =1;
    end
    
    counter=1;
    for k=1:length(policy_old) 
       if policy_old(k)==policy_new(k)
          counter=counter+1;
       end
    end
    
    if counter==num_states
        policy_stable = false;
    end
end