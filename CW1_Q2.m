close all
clear all
clc

%% Defining the MDP

%Calling the object into this file
import GridWorld
MDP = GridWorld;

gamma = 1;
p=0.35;
q=(1-p)/3;
MDP.p_gw = p;
MDP.q_gw = q;

%% Initial policy definition
initial_policy = 0.25*ones(MDP.S,MDP.A);
initial_policy(2,:)=0; initial_policy(11,:)=0;

%% Implementing Policy Iteration algorithm to obtain the optimal policy and optimal values

policy_stable=true;
policy = initial_policy;
num_iter=0; %To check how many times it is run

while policy_stable == true
    num_iter=num_iter+1;
    new_policy = policy;
    values = policy_eval(MDP,new_policy,gamma);
    [policy,policy_stable] = policy_improv_v2(MDP,values,new_policy,gamma);
end

optimal_policy = policy
optimal_values = values
