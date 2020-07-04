%=================================================================================
%===================== Code to specify the GridWorld MDP =========================
%=================================================================================

%Using an object that encapsulates data and the operations performed on that data. 

classdef GridWorld
   properties
        % Specifying the states
        States_names = ["s1", "s2", "s3", "s4", "s5", "s6", "s7","s8","s9","s10","s11"];
        S = 11;
        
        %Specifying Probabilities
        p_gw; %Probability of succeding in moving in the desired direction
        q_gw; %Probability of moving to any of the remaining 3 cardinal directions.
        
        % Specifying actions
        % Actions are: {"N","E","S","W"} --> {0,1,2,3}
        Action_names= ["N","E","S","W"];
        A = 4;
        
        %Matrix indicating absorbing states
        %  STATES -->       1  R  3  4  5  6  7  8  9  10   C    
        Absorbing_states = [0, 1, 0, 0, 0, 0, 0, 0, 0,  0,  1];
                     
   end
    
   methods
       
       %Function below defines the four transition probability matrices
       %One matrix for each action.
       function T_north = TN(obj) 
           p = obj.p_gw;
           q = obj.q_gw;
           
        %For action of going North
        %To state: 1    2    3    4    5    6    7    8    9    10   11
        T_north = [p+q  q    0    0    q    0    0    0    0    0    0;   % 1 From state
                   0    1    0    0    0    0    0    0    0    0    0;   % 2
                   0    q    p+q  q    0    0    0    0    0    0    0;   % 3
                   0    0    q    p+q  0    0    q    0    0    0    0;   % 4
                   p    0    0    0    2*q  q    0    0    0    0    0;   % 5
                   0    p    0    0    q    q    0    q    0    0    0;   % 6
                   0    0    0    p    0    0    2*q  0    0    q    0;   % 7
                   0    0    0    0    0    p    0    2*q  q    0    0;   % 8 
                   0    0    0    0    0    0    0    q    p    q    q;   % 9 
                   0    0    0    0    0    0    p    0    q    2*q  0;   % 10
                   0    0    0    0    0    0    0    0    0    0    1;]; % 11 
       end
       
       function T_east = TE(obj) 
           p = obj.p_gw;
           q = obj.q_gw;
           
        %For action of going East
        %To state: 1    2    3    4    5    6    7    8    9    10   11
        T_east = [ 2*q  p    0    0    q    0    0    0    0    0    0;   % 1 From state
                   0    1    0    0    0    0    0    0    0    0    0;   % 2
                   0    q    2*q  p    0    0    0    0    0    0    0;   % 3
                   0    0    q    p+q  0    0    q    0    0    0    0;   % 4
                   q    0    0    0    2*q  p    0    0    0    0    0;   % 5
                   0    q    0    0    q    p    0    q    0    0    0;   % 6
                   0    0    0    q    0    0    p+q  0    0    q    0;   % 7
                   0    0    0    0    0    q    0    2*q  p    0    0;   % 8 
                   0    0    0    0    0    0    0    q    q    p    q;   % 9 
                   0    0    0    0    0    0    q    0    q    p+q  0;   % 10
                   0    0    0    0    0    0    0    0    0    0    1;]; % 11 
       end
       
       function T_south = TS(obj) 
           p = obj.p_gw;
           q = obj.q_gw;
           
        %For action of going South
        %To state: 1    2    3    4    5    6    7    8    9    10   11
        T_south = [2*q  q    0    0    p    0    0    0    0    0    0;   % 1 From state
                   0    1    0    0    0    0    0    0    0    0    0;   % 2
                   0    q    p+q  q    0    0    0    0    0    0    0;   % 3
                   0    0    q    2*q  0    0    p    0    0    0    0;   % 4
                   q    0    0    0    p+q  q    0    0    0    0    0;   % 5
                   0    q    0    0    q    q    0    p    0    0    0;   % 6
                   0    0    0    q    0    0    2*q  0    0    p    0;   % 7
                   0    0    0    0    0    q    0    p+q  q    0    0;   % 8 
                   0    0    0    0    0    0    0    q    q    q    p;   % 9 
                   0    0    0    0    0    0    q    0    q    p+q  0;   % 10
                   0    0    0    0    0    0    0    0    0    0    1;]; % 11 
       end
       
              
       function T_west = TW(obj) 
           p = obj.p_gw;
           q = obj.q_gw;
           
        %For action of going West
        %To state: 1    2    3    4    5    6    7    8    9    10   11
        T_west = [ p+q  q    0    0    q    0    0    0    0    0    0;   % 1 From state
                   0    1    0    0    0    0    0    0    0    0    0;   % 2
                   0    p    2*q  q    0    0    0    0    0    0    0;   % 3
                   0    0    p    2*q  0    0    q    0    0    0    0;   % 4
                   q    0    0    0    p+q  q    0    0    0    0    0;   % 5
                   0    q    0    0    p    q    0    q    0    0    0;   % 6
                   0    0    0    q    0    0    p+q  0    0    q    0;   % 7
                   0    0    0    0    0    q    0    p+q  q    0    0;   % 8 
                   0    0    0    0    0    0    0    p    q    q    q;   % 9 
                   0    0    0    0    0    0    q    0    p    2*q  0;   % 10
                   0    0    0    0    0    0    0    0    0    0    1;]; % 11 
       end
     
     %This merges all transition matrices into a 3D matrix  
     function TM = transition_matrix(obj)
         TM =zeros(obj.S,obj.S,obj.A);
         TM(:,:,1) = TN(obj);
         TM(:,:,2) = TE(obj);
         TM(:,:,3) = TS(obj);
         TM(:,:,4) = TW(obj);
     end
     
     %Obtains a specific probability from matrix TM
     function prob = transition_function(obj,prior_state,action,post_state)   
         TM = transition_matrix(obj);
         prob = TM(prior_state,post_state,action+1);
     end
     
     %Defining the Reward matrix
     function R_matrix = reward_matrix(obj)
         %Since given any action, all possible directions are available,
         %then we will only need a single reward matrix of the process.

          %To state: 1    2   3   4   5   6   7   8   9   10  11
        R_matrix = [-1   10   0   0  -1   0   0   0   0   0   0;   % 1 From state
                     0    0   0   0   0   0   0   0   0   0   0;   % 2
                     0   10  -1  -1   0   0   0   0   0   0   0;   % 3
                     0    0  -1  -1   0   0  -1   0   0   0   0;   % 4
                    -1    0   0   0  -1  -1   0   0   0   0   0;   % 5
                     0   10   0   0  -1  -1   0  -1   0   0   0;   % 6
                     0    0   0  -1   0   0  -1   0   0  -1   0;   % 7
                     0    0   0   0   0  -1   0  -1  -1   0   0;   % 8 
                     0    0   0   0   0   0   0  -1  -1  -1 -100;  % 9 
                     0    0   0   0   0   0  -1   0  -1  -1   0;   % 10
                     0    0   0   0   0   0   0   0   0   0   0;]; % 11
               
     end
     
     %Obtaining the specific reward
     function reward = reward_function(obj,prior_state,post_state)
         R_matrix = reward_matrix(obj);
         reward = R_matrix(prior_state,post_state);
     end
     
   end
end