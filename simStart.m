function data = simStart(graphics)

global world;

data = zeros([world.maxIter,size(world.sensors{1}.taxels,1)]);

world.video = VideoWriter('data/drillvideo.avi');
world.video.FrameRate = 10;
open(world.video);

for currentStep = 1:world.maxIter;
    disp(currentStep*world.stepSize);
    updateObjects(currentStep);
    updateSensors;
    
    %this currently only handles one sensor
    data(currentStep,:) = readSensors;
    
    if graphics
        updateGraphics;
    end
end

close(world.video);
end

function loadSim

%display('This function should load simulation parameters');
global world;
world.maxIter = 100;
world.stepSize = 1;

world.sensors = [];
world.objects = [];
%world.addSensor(initRectangularSensor(10,10,1,0,2));
addObject(initSphereObject(10));

world.scene = figure('units','normalized','outerposition',[0 0 1 1]);

world.gravity = [0;0;-9.8];

end

function updateObjects(currentStep)

%display('This function should update object position');
global world;

for obj = 1:length(world.objects)
    world.objects{obj} = updateObject(world.objects{obj},world.stepSize,currentStep);
end

end

function updateSensors

%display('This function should update sensor values');
global world;

for sen = 1:length(world.sensors);
    world.sensors{sen} = resetSensorValues(world.sensors{sen});
    for obj = 1:length(world.objects)
        world.sensors{sen} = updateTaxels(world.sensors{sen},world.objects{obj});
    end
end

end

function data = readSensors
%this currently only reads the first sensor, need to fix
data = [];

%display('This function should update sensor values');
global world;

for sen = 1:1 %length(world.sensors)
    data = [data; readSensor(world.sensors{sen})];
end

end

%TODO: make it easy to pick with style graphics I want
%TODO: make it easier to draw sensor readings (i.e., different shapes)
function updateGraphics

%display('This function should update graphics');
global world;

%access correct figure;
if isempty(world.scene)
    world.scene = figure('units','normalized','outerposition',[0 0 1 1]);
    view([0,1,0]);
end
figure(world.scene);
%clear figure
cla;

% subh1 = subplot(1,2,1); title('Geometric view');
cla;
hold on;
%draw object
for obj = 1:length(world.objects);
    drawObject(world.objects{obj});
end

%draw sensors
for sen = 1:length(world.sensors);
    drawSensor(world.sensors{sen});
end

view([0,-1,0]);

% subh2 = subplot(1,2,2);
% cla;
% pcolor(reshape(readSensors,[64,64])); title('Ground Truth Signal'); caxis([0,.02]);
% axis equal;

%update figure;
drawnow limitrate;


%uncomment to make video
% frame = getframe(world.scene);
% writeVideo(world.video,frame);

end