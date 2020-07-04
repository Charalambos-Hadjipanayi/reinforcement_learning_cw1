close all;clear all; clc;

%% Defining the MDP

%Calling the object into this file
import GridWorld
MDP = GridWorld;
gamma = 0.25;
p=[0:0.05:1];
q=(1-p)./3;

for index=1:length(p)
    MDP.p_gw=p(index);
    MDP.q_gw=q(index);
    initial_policy = 0.25*ones(MDP.S,MDP.A);
    initial_policy(2,:)=0; initial_policy(11,:)=0'
    policy = initial_policy;
    num_iter=0; %To check how many times it is run
    policy_stable = true;
    while policy_stable == true
        num_iter=num_iter+1;
        new_policy = policy;
        values = policy_eval(MDP,new_policy,gamma);
        [policy,policy_stable] = policy_improv_v2(MDP,values,new_policy,gamma);
        policy_stable;
    end
    optimal_policy(:,:,index) = policy;
    optimal_values (:,:,index) = values;
    
       if (p(index)==1)||(p(index)==0)
        p(index)
        optimal_policy(:,:,index)
       end     
end

figure;
for j=1:MDP.S
        opt_val_vec = optimal_values(j,:,:);
        for i=1:length(p)
            opt_val(i) = opt_val_vec(i);
        end
        
        if (j~=2)&&(j~=11)
            plot(p,opt_val,'LineWidth',1)
            hold on
        end
end
xlabel('p value')
ylabel('Value of state')
ylim([-35 10])
title('Effect of p on state-values, while gamma=0.25')
legend('s1','s3','s4','s5','s6','s7','s8','s9','s10', 'Orientation',...
       'horizontal','Location','best')

