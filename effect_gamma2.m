close all
clear all
clc

%% Defining the MDP

%Calling the object into this file
import GridWorld
MDP = GridWorld;

p=0.35;
q=(1-p)/3;
MDP.p_gw = p;
MDP.q_gw = q;

%% Initial policy definition
initial_policy = 0.25*ones(MDP.S,MDP.A);
initial_policy(2,:)=0; initial_policy(11,:)=0;

%% Implementing Policy Iteration algorithm to obtain the optimal policy and optimal values

gamma = [0:0.1:1];
for index=1:length(gamma)
    policy_stable=true;
    policy = initial_policy;
    num_iter=0; %To check how many times it is run
    while policy_stable == true
        num_iter=num_iter+1;
        new_policy = policy;
        values = policy_eval(MDP,new_policy,gamma(index));
        [policy,policy_stable] = policy_improv_v2(MDP,values,new_policy,gamma(index));
    end   
    optimal_policy(:,:,index) = policy;
    optimal_values (:,:,index) = values;
end

figure;
for j=1:MDP.S
        opt_val_vec = optimal_values(j,:,:);
        for i=1:length(gamma)
            opt_val(i) = opt_val_vec(i);
        end
        
        if (j~=2)&&(j~=11)
            plot(gamma,opt_val,'LineWidth',1)
            hold on
        end
end

xlabel('gamma value')
ylabel('Value of state')
title('Effect of gamma on state-values, while p=0.35')
legend('s1','s3','s4','s5','s6','s7','s8','s9','s10', 'Orientation',...
       'horizontal','Location','best')