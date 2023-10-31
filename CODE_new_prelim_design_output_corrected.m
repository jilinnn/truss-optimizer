% load the input file with variables C, Sx, Sy, X, Y, L
load("prelimDesign4_50oz.mat")

appliedLoad = max(L);
sizes = size(C);
joints = sizes(1);
members = sizes(2);

% lengths of each member
lengths = zeros(1,members);

Mx = zeros(joints, members);
for ii = 1:members
    firstJoint = -1;
    secondJoint = -1;
    for jj = 1:joints
        if(C(jj,ii) == 1 && firstJoint == -1)
            firstJoint = jj;
        elseif (C(jj,ii) == 1 && secondJoint == -1)
            secondJoint = jj;
        end
    end
    lengths(1,ii) = distance(X(firstJoint),X(secondJoint),Y(firstJoint),Y(secondJoint));
    hold on
    plot([X(firstJoint) X(secondJoint)],[Y(firstJoint) Y(secondJoint)])
    Mx(firstJoint, ii) = (X(secondJoint)-X(firstJoint))/lengths(1,ii);
    Mx(secondJoint, ii) = -1 * Mx(firstJoint,ii);
end

My = zeros(sizes(1), sizes(2));
for ii = 1:members
    firstJoint = -1;
    secondJoint = -1;
    for jj = 1:joints
        if(C(jj,ii) == 1 && firstJoint == -1)
            firstJoint = jj;
        elseif (C(jj,ii) == 1 && secondJoint == -1)
            secondJoint = jj;
        end
    end
    My(firstJoint, ii) = (Y(secondJoint)-Y(firstJoint))/lengths(1,ii);
    My(secondJoint, ii) = -1 * My(firstJoint,ii);
end

A = [Mx Sx;
     My Sy];
T = inv(A)*L;
Torig = T;

% hard stuff :( - finding critical member and the max force it can support
condition = true;
critMember = 0;
for ii = 1:length(L)
    if L(ii) > 0
        L(ii) = 1;
    end
end
while (condition)
    for ii = 1:length(L)
        if L(ii) > 0
            failureLoad = L(ii);
            L(ii) = L(ii) + 0.001;
        end
    end
    T = inv(A)*L;
    for ii = 1:members
        firstJoint = -1;
        secondJoint = -1;
        for jj = 1:joints
            if(C(jj,ii) == 1 && firstJoint == -1)
                firstJoint = jj;
            elseif (C(jj,ii) == 1 && secondJoint == -1)
                secondJoint = jj;
            end
        end
        % exits loop when a member is found to buckle
        if (T(ii) < 0)
            maxLoad = 4338 * lengths(ii)^-2.125;
            if (-1*T(ii) > maxLoad)
                condition = false;
                critMember = ii;
                fprintf("Critical member: %d\n",critMember)
            end
        end
        % breaks out of loop if the truss is a-okay!
        if (ii == members)
            break;
        end
    end
end

% critical member and maximum load
Rm = T/max(L);
Tc = -1*T(critMember);
Wfailure = T(critMember)/Rm(critMember);
fprintf("Theoretical max load is: %f\n",Wfailure)

% plot truss
clf
for ii = 1:members
    firstJoint = -1;
    secondJoint = -1;
    for jj = 1:joints
        if(C(jj,ii) == 1 && firstJoint == -1)
            firstJoint = jj;
        elseif (C(jj,ii) == 1 && secondJoint == -1)
            secondJoint = jj;
        end
    end
    hold on
    color = "black";
    criticalMember = 1;
    if (T(ii) > 0)
        color = "green";
    elseif (T(ii) < 0)
        maxLoad = 4338 * lengths(ii)^-2.125;
        if (-1*T(ii) > maxLoad)
            color = "red";
        else
            color = [-1*T(ii)/maxLoad 0 1];
            %color = [0 0 1];
        end
    end
    plot([X(firstJoint) X(secondJoint)],[Y(firstJoint) Y(secondJoint)], 'color', color)
end

cost = 10 * joints + sum(lengths);
% formatted output
format short
units = "oz";
disp("\% EK301, Section A1, Group 1: Aadarsh A., Peter Z., Jilin Z. 4/7/2023.")
fprintf("Load: %i oz\n", appliedLoad)
fprintf("Member forces in %s: \n",units)
for ii = 1:members
    tension = 'T';
    if (Torig(ii) < 0)
        tension = 'C';
        Torig(ii) = -1*Torig(ii);
    end
    fprintf("m%d: %f (%c)\n", ii, Torig(ii), tension)
end
fprintf("Reaction forces in %s:\n",units)
fprintf("Sx1: %f\n",Torig(length(Torig)-2))
fprintf("Sy1: %f\n",Torig(length(Torig)-1))
fprintf("Sy2: %f\n",Torig(length(Torig)))
fprintf("Cost of truss: $%.2f\n",cost)
fprintf("Theoretical max load/cost ratio in %s/$: %f\n\n",units,failureLoad/cost)
for ii = 1:members
    fprintf("Length of member %d: %f\n", ii,lengths(ii))
end

%% Uncertainty

Ufit = 2.1;
disp("")

% STRONG CASE
condition = true;
critMember = 0;
for ii = 1:length(L)
    if L(ii) > 0
        L(ii) = 1;
    end
end
while (condition)
    for ii = 1:length(L)
        if L(ii) > 0
            failureLoad = L(ii);
            L(ii) = L(ii) + 0.001;
        end
    end
    T = inv(A)*L;
    for ii = 1:members
        firstJoint = -1;
        secondJoint = -1;
        for jj = 1:joints
            if(C(jj,ii) == 1 && firstJoint == -1)
                firstJoint = jj;
            elseif (C(jj,ii) == 1 && secondJoint == -1)
                secondJoint = jj;
            end
        end
        % exits loop when a member is found to buckle
        if (T(ii) < 0)
            maxLoad = 4338 * lengths(ii)^-2.125 + Ufit;
            if (-1*T(ii) > maxLoad)
                condition = false;
                critMember = ii;
                fprintf("Critical member: %d\n",critMember)
            end
        end
        % breaks out of loop if the truss is a-okay!
        if (ii == members)
            break;
        end
    end
end

% critical member and maximum load
Rm = T/max(L);
Tc = -1*T(critMember);
Wfailure = T(critMember)/Rm(critMember);
fprintf("Theoretical max STRONG load is: %f\n",Wfailure)

% WEAK CASE
condition = true;
critMember = 0;
for ii = 1:length(L)
    if L(ii) > 0
        L(ii) = 1;
    end
end
while (condition)
    for ii = 1:length(L)
        if L(ii) > 0
            failureLoad = L(ii);
            L(ii) = L(ii) + 0.001;
        end
    end
    T = inv(A)*L;
    for ii = 1:members
        firstJoint = -1;
        secondJoint = -1;
        for jj = 1:joints
            if(C(jj,ii) == 1 && firstJoint == -1)
                firstJoint = jj;
            elseif (C(jj,ii) == 1 && secondJoint == -1)
                secondJoint = jj;
            end
        end
        % exits loop when a member is found to buckle
        if (T(ii) < 0)
            maxLoad = 4338 * lengths(ii)^-2.125 - Ufit;
            if (-1*T(ii) > maxLoad)
                condition = false;
                critMember = ii;
                fprintf("Critical member: %d\n",critMember)
            end
        end
        % breaks out of loop if the truss is a-okay!
        if (ii == members)
            break;
        end
    end
end

% critical member and maximum load
Rm = T/max(L);
Tc = -1*T(critMember);
Wfailure = T(critMember)/Rm(critMember);
fprintf("Theoretical max WEAK load is: %f\n",Wfailure)
%% Function(s)
function r = distance(x1,x2,y1,y2)
    r = sqrt((x2-x1)^2 + (y2-y1)^2);
end