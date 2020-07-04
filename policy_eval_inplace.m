function value_estimates = policy_eval_inplace(obj,policy,gamma)
    %Initialisation
    num_states = obj.S;
    num_actions = obj.A;
    value_estimates = zeros(num_states,1);
    theta = 0.001;
    delta = 2*theta;
    
   
     while(delta>theta)
            
            values_old = value_estimates;
            
            
            for i=1:num_states
                value_estimates(i)=0;
                for a=1:num_actions
                    value_cum=0;
                    for s=1:num_states
                    
                        value = policy(i,a)*(transition_function(obj,i,(a-1),s) * (reward_function(obj,i,s) + gamma*value_estimates(s)));
                        value_cum = value_cum + value;
                    end
                    
                    value_action = policy(i,a)*value_cum;
                    value_estimates(i)=value_estimates(i)+value_action;
                end
            end
        
        for i=1:length(value_estimates)
            k(i) = abs(values_old(i) - value_estimates(i));
        end
        delta = max(k);
     end
     value_estimates
end
    