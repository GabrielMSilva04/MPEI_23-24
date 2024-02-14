T = [0    0.8/3  0       0.8/3   0    0
     0.5  0      0.8/3   0       0.5  0
     0    0.8/3  0       0.8/3   0    0
     0.5  0      0.8/3   0       0.5  0
     0    0.8/3  0.8/3   0.8/3   0    0
     0    0.2    0.2     0.2     0    0];



rand=randi(5);
[state]=crawl(T, rand, 6);
disp(state)



function [state] = crawl(H, first, last)
     % the sequence of states will be saved in the vector "state"
     % initially, the vector contains only the initial state:
     state = [first];
     % keep moving from state to state until state "last" is reached:
     while (1)
          state(end+1) = nextState(H, state(end));
          if ismember(state(end), last) % verifies if state(end) is absorving
              break;
          end
     end
end

function state = nextState(H, currentState)
     % find the probabilities of reaching all states starting at the current one:
     probVector = H(:,currentState)';  % probVector is a row vector 
     n = length(probVector);  %n is the number of states
     % generate the next state randomly according to probabilities probVector:
     state = discrete_rnd(1:n, probVector);
end

% Generate randomly the next state.
% Inputs:
% states = vector with state values
% probVector = probability vector 
function state = discrete_rnd(states, probVector)
     U=rand();
     i = 1 + sum(U > cumsum(probVector));
     state= states(i);
end