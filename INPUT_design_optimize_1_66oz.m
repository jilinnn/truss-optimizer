joints = 8;
members = 13;

pinJoint = 1;
rollerJoint = 8;

C = [1 0 0, 0 0 0, 0 1 0, 0 0 0, 0;
     1 1 0, 0 0 0, 0 0 0, 0 1 0, 0;
     0 1 1, 0 0 0, 0 1 1, 0 0 0, 0;
     0 0 1, 1 0 0, 0 0 0, 0 1 1, 0;
     0 0 0, 1 1 1, 0 0 1, 1 0 0, 0;
     0 0 0, 0 1 0, 0 0 0, 0 0 1, 1;
     0 0 0, 0 0 1, 1 0 0, 0 0 0, 1;
     0 0 0, 0 0 0, 1 0 0, 1 0 0, 0;
     ];

% always put pin @ first joint & roller @ last joint
Sx = zeros(joints,3);
Sx(pinJoint,1) = 1;

Sy = zeros(joints,3);
Sy(pinJoint,2) = 1;
Sy(rollerJoint, 3) = 1;

X = [0 6.949 11 15.531 22 23.46 29.449 34];

Y = [0 6.91 0 10.778 0 11.911 6.592 0];

L = zeros(2*joints,1);
L(joints+5) = 32;