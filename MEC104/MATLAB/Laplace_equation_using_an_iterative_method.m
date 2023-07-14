function [phi, n, error] = Laplace_equation_using_an_iterative_method(phi_ini, relaxation_factor, tolerance)

phi = phi_ini;
[nodeNum_x, nodeNum_y] = size(phi);
n = 0;
while (true)
    
    % Iterate
    phi_old = phi;
    for j = 2 : nodeNum_y-1
        for i = 2 : nodeNum_x-1
            phi(i,j) = phi_old(i,j) + (relaxation_factor/4) * ...
                ( phi_old(i,j+1) + phi(i,j-1) + phi(i-1,j) + phi_old(i+1,j) - 4*phi_old(i,j) );
        end
    end
    n = n + 1;
    
    % Stop the iteration until the max diff between entries of the current solution
    % and those from previous is smaller than the tolerance 
    error = max(abs(phi(:)-phi_old(:)));  % Use (:) to turn a matrix into a vector
    if error < tolerance
        break
    end
    
    % Stop the iteration if solution diverge
    if any(isnan(phi(:))) || any(isinf(phi(:)))
        error('solution diverge');
    end
end

% Reference
% https://www.mathworks.com/matlabcentral/answers/157632-jacobi-iterative-method-in-matlab
% https://www.coursera.org/lecture/numerical-methods-engineers/matlab-solution-of-the-laplace-equation-iterative-method-lecture-68-uCRp3
