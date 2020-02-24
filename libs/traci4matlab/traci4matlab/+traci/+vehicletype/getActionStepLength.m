function actionStepLength = getActionStepLength(typeID)
%getActionStepLength Action step length.
%   actionStepLength = getActionStepLength(TYPEID) Returns the action step
%   length for vehicles of this type.

%   Copyright 2019 Universidad Nacional de Colombia,
%   Politecnico Jaime Isaza Cadavid.
%   Authors: Andres Acosta, Jairo Espinosa, Jorge Espinosa.
%   $Id: getActionStepLength.m 54 2019-01-03 15:41:54Z afacostag $

import traci.constants
actionStepLength = traci.vehicletype.getUniversal(constants.VAR_ACTIONSTEPLENGTH, typeID);