# Truss Optimizer

A truss optimization script written in MATLAB for the truss design final project of a statics class.

## Description

The scripts, prefixed "CODE", takes in .mat files generated by the .m script files with prefix "INPUT". Simply run the INPUT .m file and save the workspace variables into a .mat, then modify the argument for the load function in line 2 in whichever CODE_....m script selected. A number of sample "INPUT" and .mat files have been included in this repo. The "INPUT" files take in matrices of truss connections (C), reactions forces (Sx, Sy), lengths of each member (by x- and y- coordinates; X and Y), and where a particular load is placed (L).

When ran, the script will output the critical member of the truss design, the theoretical maximum load of the truss design, each truss member's length and load, reactions forces, cost of the truss design, and the theoretical maximum load-to-cost ratio of the design (the latter two being based on a given cost function for the project). Furthermore, the entire truss design is visualized in a plot.

A sample image of the output is below:
![image](https://github.com/jilinnn/truss-optimizer/assets/133818802/40050a38-ab23-4d16-a3d9-5cf0ec7951ec)
