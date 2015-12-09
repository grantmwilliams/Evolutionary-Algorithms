%% Test Matrix Stuff
clear; close all; clc;
tic

genome = 10;                                % Genome Size
popSize = genome;                           % Population Size
limit = 1000;
Pop = round(rand(popSize + 1,genome));
F = zeros(limit,1);                         % Initialize Fitness
variableRange = [-3,3];
numberOfVariables = 2;
best = -1*Inf;

for Gen = 1:limit
    
    %% First Evolution Style (modify a single gene)
    [~, idx] = sort(rand(genome,1));
    for i = 1:genome
        Pop(idx(i),i) = Pop(idx(i),i) * -1 + 1;
    end

    
    %% Second Evolution Style (random)
    Pop(popSize + 1,:) = round(rand(1,genome));
    
    %% Fitness
    
    % First Evolution Style
    xy = decode(Pop);                   % Convert to Binary
    xy = normalizeXY(xy,variableRange); % Normalize to x1 <= XY <= x2
    F = getFitness(xy);                 %Fitness function goes here
    
    [current,currentIdx] = max(F);

    
    %% Check for New Best Solution
    % Best from Evolution 1
    if (current > best)
        best = current;
        bestIdx = currentIdx;
        bestGenome = xy(currentIdx,:);
        Pop = repmat(Pop(currentIdx,:),popSize+1,1);
        
        fprintf('Gen: %d    Best Fitness: %d\n', Gen, best);
    end

    
    % Second Evolution Style
    
end
disp('-----------------------------------------');
fprintf('Best Fitness: ');
disp(best);
disp('Best Genome: ');
disp(bestGenome);


toc