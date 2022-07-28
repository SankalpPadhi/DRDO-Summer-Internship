%% Constants
C = [486 ;638];
fps = 500;
n=24;
p1=2;
p2=0;
p3=0;
slno = [1:(n-2)];

%% Initializing x-coordinate vector, y-coordinate vector, theta vector and omega vector
x = [447;377;313;268;238;223;233;256;303;363;430;504;576;644;697;734;753;751;730;689;632;566;490;418];
y = [375;396;437;492;558;627;701;769;829;868;896;902;888;855;802;742;668;593;521;463;412;383;373;381];
theta=zeros((n-1),1);
omega= zeros((n-2),1);

%% Computation of theta vector 
for i =1:(n-1)
    theta(i)=(180/pi)*(atan((y(i)-C(2))/(x(i)-C(1))));
    disp(['The value of angle in degrees is : ', num2str(theta(i))])
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


