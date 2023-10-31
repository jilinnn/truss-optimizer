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

X = [0 7.313 11 15.895 22 23.857 30.309 34];

Y = [0 7.111 0 10.977 0 11.855 7.109 0];

L = zeros(2*joints,1);
L(joints+5) = 32;