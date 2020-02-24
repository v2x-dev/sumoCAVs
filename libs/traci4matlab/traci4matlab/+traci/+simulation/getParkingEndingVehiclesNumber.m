function parkingEndingNumber = getParkingEndingVehiclesNumber()
%getParkingEndingVehiclesNumber
%   parkingEndingNumber = getParkingEndingVehiclesNumber()

%   Copyright 2019 Universidad Nacional de Colombia,
%   Politecnico Jaime Isaza Cadavid.
%   Authors: Andres Acosta, Jairo Espinosa, Jorge Espinosa.
%   $Id: getParkingEndingVehiclesNumber.m 54 2019-01-03 15:41:54Z afacostag $

import traci.constants
parkingEndingNumber = traci.simulation.getUniversal(constants.VAR_PARKING_ENDING_VEHICLES_NUMBER);
