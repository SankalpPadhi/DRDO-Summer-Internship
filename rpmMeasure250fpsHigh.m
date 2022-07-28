%% Constants
C = [486 ;638];
fps = 250;
n=20;
p1 =2.5;
p2 = 1.85;
p3=1.1;
slno = [1:(n-2)];

%% Initializing x-coordinate vector, y-coordinate vector, theta vector and omega vector
x = [654;523;381;268;225;256;355;494;629;724;753;699;586;439;316;235;229;301;430;572];
y = [430;375;396;488;625;763;868;902;861;757;611;478;389;375;437;560;701;826;896;892];
theta=zeros((n-1),1);
omega= zeros((n-2),1);

%% Computation of theta vector 
for i =1:1:(n-1)
    theta(i)= (180/pi)*(atan((y(i)-C(2))/(x(i)-C(1))));
    disp(['The value of angle in degrees is : ', num2str(theta(i))]);
end

%% Computation of omega vector
for i = 1:(n-2)
    if (theta(i) > theta(i+1))
        omega(i)=abs((60/(2*pi))*(((pi/180)*(theta(i+1)-theta(i)))/(1/fps)));
    else 
        if (abs(theta(i+1) + theta(i)) < 15)
            omega(i)=p1*(abs((60/(2*pi))*(((pi/180)*(theta(i+1)+theta(i)))/(1/fps))));
        elseif(abs(theta(i+1) + theta(i)) < 20 && abs(theta(i+1) + theta(i)) > 15)
            omega(i)=p2*(abs((60/(2*pi))*(((pi/180)*(theta(i+1)+theta(i)))/(1/fps))));
        else
            omega(i)=p3*(abs((60/(2*pi))*(((pi/180)*(theta(i+1)+theta(i)))/(1/fps))));
        end
    end

    disp(['The value of speed in rpm is : ',num2str(omega(i))]); 
end

%% Plot of omega vs slno and theta vs slno
plot(slno,omega,'--r');
xlabel('slno');
ylabel('Speed in rpm, Theta in degrees');
title('Graphs for speed and angle');
hold on
slno=[1:(n-1)];
plot(slno,theta,'-b');
legend('Speed','Angle');
shg

%% Calculation of average speed
avgSpeed = sum(omega)/(n-2);

%% Calculation of error
err = abs(omega-avgSpeed);

%% Calculation of mean & standard deviation of error
meanErr = sum(err)/(n-2);
VarianceErr = ((sum((err).^2))/(n-2)) -meanErr^2  ;
stndDevitnErr = sqrt(VarianceErr);

%% Display results

% disp(theta)
% disp(omega)
disp(avgSpeed);
disp(meanErr);
disp(stndDevitnErr);

