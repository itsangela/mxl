%% Antenna Coverage Map

%% Define Transmitter 
% Start with transmitter
fq = 437e6; % 437 MHz
txlocation = []; %% Somewhat above FXB for now
txantenna = design(monopole, fq);
tx = txsite("Name","MathWorks", ...
    "Latitude",42.2936, ...
    "Longitude",-83, ...
    "Antenna",txantenna, ...
    "AntennaHeight",787000, ...        % Units: meters
    "TransmitterFrequency",fq, ... % Units: Hz
    "TransmitterPower", 10^0.3);        % Units: Watts

%% Define receiver sites
% Define receiver sites in several surrounding towns and cities
rxNames = [...
   "Ann Arbor, MI"];

rxLocations = [...
   42.294, -83.712];    % FXB in Ann Arbor

% Run turnstile antenna script
turnstile_antenna;
rxAntenna = turnstile;

% Define receiver sensitivity. Sensitivity is the minimum signal strength in
% power that is necessary for the receiver to accurately detect the signal.
rxSensitivity = -100; % Units: dBm

rxs = rxsite("Name",rxNames, ...
    "Latitude",rxLocations(:,1), ...
    "Longitude",rxLocations(:,2), ...
    "Antenna",rxAntenna, ...
    "ReceiverSensitivity",rxSensitivity); % Units: dBm

%% Show Sites on a Map
viewer = siteviewer;
show(tx)
show(rxs)

%% Display Idealized coverage map using Dipole Antenna
coverage(tx,"freespace", ...
    "SignalStrengths",rxSensitivity, ...
    "ReceiverGain", 25)

%% Plot Communication Links using Antenna
sc = [0 0.3 0];
link(rxs,tx,"freespace","SuccessColor",sc)
