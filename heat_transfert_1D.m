clc;
clear;

% Defining the problem
a = 97;                % Thermal diffusivity
length = 50;            % Length of the rod (m)
time = 1;               % Total simulation time (s)
nodes = 150;             % Number of spatial nodes

% Initialization
dx = length / nodes;    % Spatial step size
dt = 0.5 * dx^2 / a;    % Time step size (for stability)
t_nodes = time / dt;    % Number of time steps

% Initial temperature distribution
u = 20 * ones(1, nodes); % Plate is initially at 20°C

% Boundary conditions
u(1) = 100;             % Left boundary condition
u(end) = 50;            % Right boundary condition

% Plot initialization
% Plot initialization (1D line plot)
figure(1);
plot(u, 'LineWidth', 2);
ylim([0 100]);
title('Initial Temperature Distribution');

% Simulation
counter = 0;            % Initialize time counter
while counter < time
    w = u;              % Copy current temperature distribution

    % Update temperature at interior nodes
    for i = 2:nodes-1
        u(i) = dt * a * (w(i-1) - 2*w(i) + w(i+1)) / dx^2 + w(i);
    end

    counter = counter + dt; % Increment time

    % Display current time and average temperature
    fprintf('t: %.3f (s), Average temperature: %.3f\n', counter, mean(u));

    % Update the plot
    plot(u, 'LineWidth', 2);
    ylim([0 100]);
    title(sprintf('Distribution at t: %.3f [s]', counter));
    xlabel('Position');
    ylabel('Temperature');
    grid minor
    drawnow;
    pause(0.01);        % Pause for visualization
    
end




% Initialisation de la figure
% Figure for the initial temperature distribution
figure(2);
imagesc(u);                     % Display the initial temperature distribution
colormap(jet);                  % Use the "jet" color map
cb = colorbar;                  % Add a colorbar (legend for colors)
cb.Label.String = 'Temperature (°C)';  % Label the colorbar
caxis([0 100]);                 % Set the color limits from 0 to 100
title('Initial Temperature Distribution');
xlabel('Position');
ylabel('Temperature');

% Simulation loop
counter = 0;                    % Initialize the time counter
while counter < time
    w = u;                      % Copy the current temperature distribution
    
    % Update the temperature for interior nodes
    for i = 2:nodes-1
        u(i) = dt * a * (w(i-1) - 2*w(i) + w(i+1)) / dx^2 + w(i);
    end
    
    counter = counter + dt;     % Increment the time
    
    % Display the current time and average temperature in the console
    fprintf('t: %.3f (s), Mean Temperature: %.3f\n', counter, mean(u));
    
    % Update the visualization
    imagesc(u);                 % Update the image with the new temperature distribution
    colormap(jet);              % Apply the "jet" colormap
    cb = colorbar;              % Update the colorbar
    cb.Label.String = 'Temperature (°C)';  % Update the colorbar label
    clim([0 100]);             % Keep the same color limits
    title(sprintf('Temperature Distribution at t: %.3f [s]', counter));
    xlabel('Position');
    ylabel('Temperature');
    drawnow;                    % Update the figure
    pause(0.01);                % Pause briefly for visualization
end
