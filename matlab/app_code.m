clear all;
close all;

g = -5;
ball_radius = 1.5;
delta_vx = 0.09;
xf = 20;

A = [0 0 1 0; 0 0 0 1; 0 0 0 0; 0 0 0 0];
B = [0; 0; 0; 1];
C = [0 1 0 0; 1 0 0 0];
D = [0; 0];

%First impact
floor_height = 1.2;
bottom_out = ball_radius + floor_height;

x0 = 0;
y0 = 10;
vx0 = 1.5;
vy0 = -5;
init_cond = [x0; y0; vx0; vy0];

sim('app3_simulink')

plot(output.Data(:, 2), output.Data(:, 1));
hold on
disp(output.Time(end));
%Ax = [output.Data(:, 2), output.Data(:, 1), output.Time()];
Ax = [output.Data(:, 2), output.Data(:, 1)];

%Second impact
floor_height = 1;
bottom_out = ball_radius + floor_height;

x0 = output.Data(end, 2);
y0 = output.Data(end, 1);
vx0 = vx0 - delta_vx;
vy0 = (output.Time(end)*g-5)*(-0.9);
init_cond = [x0; y0; vx0; vy0];

sim('app3_simulink')
plot(output.Data(:, 2), output.Data(:, 1));
disp(output.Time(end));
%Bx = [output.Data(:, 2), output.Data(:, 1), output.Time()];
Bx = [output.Data(:, 2), output.Data(:, 1)];

%Third impact
floor_height = 1.5;
bottom_out = ball_radius + floor_height;

x0 = output.Data(end, 2);
y0 = output.Data(end, 1);
vx0 = vx0 - delta_vx;
vy0 = (output.Time(end)/2*g)*(-0.8);
init_cond = [x0; y0; vx0; vy0];

sim('app3_simulink')
plot(output.Data(:, 2), output.Data(:, 1));
disp(output.Time(end));
%Cx = [output.Data(:, 2), output.Data(:, 1), output.Time()];
Cx = [output.Data(:, 2), output.Data(:, 1)];

%Fourth impact
floor_height = 1;
bottom_out = ball_radius + floor_height;

x0 = output.Data(end, 2);
y0 = output.Data(end, 1);
vx0 = vx0 - delta_vx;
vy0 = (output.Time(end)/2*g)*(-0.7);
init_cond = [x0; y0; vx0; vy0];

sim('app3_simulink')
plot(output.Data(:, 2), output.Data(:, 1));
disp(output.Time(end));
%Dx = [output.Data(:, 2), output.Data(:, 1), output.Time()];
Dx = [output.Data(:, 2), output.Data(:, 1)];

%Fifth impact
floor_height = 1;
bottom_out = ball_radius + floor_height;

x0 = output.Data(end, 2);
y0 = output.Data(end, 1);
xf = x0 + 0.75645;
x = x0:0.1:xf;
yf = 0*x + y0;

plot(x, yf);
Ex = [x; yf]';

%text_output = [Ax; Bx; Cx; Dx];
text_output = [Ax; Bx; Cx; Dx; Ex];
csvwrite('app3_blender.txt', text_output);
