function varargout = rosenbruck(X)
    % if no input is given, return dimensions, bounds and minimum
    if (nargin == 0)
        varargout{1} = inf;  % # dims
        varargout{2} = -100; % LB
        varargout{3} = +100; % UB
        varargout{4} = 1; % solution
        varargout{5} = 0; % function value at solution        
    % otherwise, output function value
    else     
        % keep all values within the domain
        X(X < -100) = inf;  X(X > 100) = inf;    
        % split input vector X into X1, X2
        % NOTE: proper orientation can not be determined automatically
        % the sum is taken by default over the rows:
        X1 = X(1:2:end-1, :);        X2 = X(2:2:end, :);        
        % output rowsum
        varargout{1} = sum(  100*(X2 - X1.^2).^2 + (1 - X1).^2, 1);
    end    
end
    