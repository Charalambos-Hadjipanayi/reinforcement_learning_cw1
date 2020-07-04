close all;clear all; clc;

%Resetting default figure size
set(groot, 'defaultFigurePosition', [20, 100, 800, 400]);
%Resetting default font size
set(groot, 'defaultAxesFontSize', 14);
set(groot, 'defaultLegendFontSize', 14);
set(groot, 'defaultLegendFontSizeMode', 'manual');
%Remove extra whitespace around figure
set(groot,'defaultAxesLooseInset',[0,0,0,0]);
%Enable grid by default on figure
set(groot,'defaultAxesXGrid','on');
set(groot,'defaultAxesYGrid','on');

%% Defining the MDP

%Calling the object into this file
import GridWorld
MDP = GridWorld;

gamma = [0:0.05:1];
for index=1:length(gamma)

    initial_policy = 0.25*ones(MDP.S,MDP.A);
    initial_policy(2,:)=0; initial_policy(11,:)=0;

    policy = initial_policy;
    num_iter=0; %To check how many times it is run
    policy_stable = true;

    while policy_stable == true
        num_iter=num_iter+1;
        new_policy = policy;
        values = policy_eval(MDP,new_policy,gamma(index));
        [policy,policy_stable] = policy_improv_v2(MDP,values,new_policy,gamma(index));
        policy_stable;
    end

    optimal_policy(:,:,index) = policy
    optimal_values (:,:,index) = values
    
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

xlabel('Gamma value')
ylabel('Value of state 9')
title('Effect of gamma on state-value of s9')

