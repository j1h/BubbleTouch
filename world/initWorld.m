function initWorld(maxIter,stepSize)

global world;
world.maxIter = maxIter;
world.stepSize = stepSize;

world.sensors = [];
world.objects = [];
%world.addSensor(initRectangularSensor(10,10,1,0,2));
%addObject(initSphereObject(10));

world.scene = [];

%quasi-static variables
world.gravity = [0;0;-9.8];

end