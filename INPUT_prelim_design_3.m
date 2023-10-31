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

X = [0 5.5 11 13.293 20 21.303 29.215 34];

Y = [0 5.823 0 7.675 0 7.675 6.424 0];

L = zeros(2*joints,1);
L(joints+5) = 32;