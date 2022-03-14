%% Antenna Coverage Map

%% Define Transmitter 
% Start with transmitter
fq = 6e9; % 6 GHz
antenna = design(dipole, fq);
tx = txsite("Name","MathWorks", ...
    "Latitude",42.3001, ...
    "Longitude",-71.3504, ...
    "Antenna",antenna, ...
    "AntennaHeight",60, ...        % Units: meters
    "TransmitterFrequency",fq, ... % Units: Hz
    "TransmitterPower",15);        % Units: Watts

%% Define receiver sites
% Define receiver sites in several surrounding towns and cities
rxNames = [...
   "Boston, MA","Lexington, MA","Concord, MA","Marlborough, MA", ...
   "Hopkinton, MA","Holliston, MA","Foxborough, MA","Quincy, MA"];

rxLocations = [...
   42.3601 -71.0589; ... % Boston
   42.4430 -71.2290; ... % Lexington
   42.4604 -71.3489; ... % Concord
   42.3459 -71.5523; ... % Marlborough
   42.2287 -71.5226; ... % Hopkinton
   42.2001 -71.4245; ... % Holliston
   42.0654 -71.2478; ... % Foxborough
   42.2529 -71.0023];    % Quincy

% Define receiver sensitivity. Sensitivity is the minimum signal strength in
% power that is necessary for the receiver to accurately detect the signal.
rxSensitivity = -90; % Units: dBm

rxs = rxsite("Name",rxNames, ...
    "Latitude",rxLocations(:,1), ...
    "Longitude",rxLocations(:,2), ...
    "Antenna",design(dipole,tx.TransmitterFrequency), ...
    "ReceiverSensitivity",rxSensitivity); % Units: dBm

%% Show Sites on a Map
viewer = siteviewer;
show(tx)
show(rxs)

viewer.Basemap = "openstreetmap";

%% Display Idealized coverage map using Dipole Antenna
coverage(tx,"freespace", ...
    "SignalStrengths",rxSensitivity)

%% Plot Communication Links using Antenna
sc = [0 0.3 0];
link(rxs,tx,"freespace","SuccessColor",sc)
