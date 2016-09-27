function senh = drawSensor(sensor,detail)

if nargin < 2
    detail = 20;
end

[spherex,spherey,spherez] = sphere(detail);

t = ones(size(spherex));

centers = (sensor.orientation*sensor.taxels'+kron(sensor.position,ones(1,size(sensor.taxels,1))))';

x = kron(centers(:,1),t);
y = kron(centers(:,2),t);
z = kron(centers(:,3),t);

spherex = repmat(sensor.RADIUS*spherex,size(sensor.taxels,1),1);
spherey = repmat(sensor.RADIUS*spherey,size(sensor.taxels,1),1);
spherez = repmat(sensor.RADIUS*spherez,size(sensor.taxels,1),1);

gx = spherex+x;
gy = spherey+y;
gz = spherez+z;

senh = surf(gx,gy,gz,'EdgeColor','none','LineStyle','none','FaceColor',[.6,0,0],'FaceLighting','phong');
light('Position',[-1 -1 1],'Style','local')
% view([1,-1,1]);
% set(senh,'FaceColor',[1,0,0]);
axis equal;

end

