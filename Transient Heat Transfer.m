%group 32
Ti=200;%initial teperature in C
Tinf=25;%Ambient temperature in C
L=0.16;%Length of steel rod in m
D=10e-3;%diameter of steel rod in m
h=30;%coefficient of convection in W/m^2 K
k=14.8;%Heat transfer coefficient of AISI 316 stainless steel in W/m K
alpha=3.63e-6;%Thermal diffusivity of AISI 316 stainless steel in m^2/s
t=0;
deltax=0.016;
deltat=10;%suitable value from stability check
Fo=alpha*deltat/(deltax^2); %Fourier Number for finite difference method
Bi=(h*deltax/k); %Biot Number for finite difference method
%Both constants defined in methodology
x=Ti*ones(11,1);%setting initial temperature
z=x;
%Part (a)
while(x(6)-100>0.00001)
  for i=2:10 
    x(i)=z(i)*(1-2*Fo-(4*alpha*deltat*h)/(k*D))+Fo*(z(i+1)+z(i-1))+((4*alpha*deltat*h)/(k*D))*Tinf;%from eq 1
  end

  x(11)=z(11)*(1-2*Fo-2*Bi*Fo)+2*Fo*(z(10)+Bi*Tinf);%from eq 2
  z=x;
  t=t+deltat;
end 
s = sprintf('100%c', char(176));
fprintf('Time required for the midlength of the rod to reach ');
fprintf(s);
fprintf('C is %f', t);
disp(' s')


%Part (b)
t1=0;
x1=Ti*ones(11,1);%setting initial temperature
z1=x1;
Y1=x1;

while(x1(6)-50 >1e-5)
  for i=2:10
    x1(i)=z1(i)*(1-2*Fo-(4*alpha*deltat*h)/(k*D))+Fo*(z1(i+1)+z1(i-1))+((4*alpha*deltat*h)/(k*D))*Tinf;%from eq 1
  end 
  x1(11)=z1(11)*(1-2*Fo-2*Bi*Fo)+2*Fo*(z1(10)+Bi*Tinf);%from eq 2
  z1=x1;
  t1=t1+deltat;
  if(t1==200)
    Y2=z1;
  end
  if(t1==400)
    Y3=z1;
  end
end 
%Output
s1 = sprintf('50%c', char(176));
fprintf('Time required for the midlength of the rod to reach ');
fprintf(s1);
fprintf('C (t1) is %f', t1);
disp(' s')
disp(z1)
Y4=z1;

%plotting
finl=(0:deltax*1000:L*1000)';
plot(finl,Y1,finl,Y2,finl,Y3,finl,Y4);
title('Temperature Distribution');
xlabel('Fin Location (mm)');
ylabel('Temperature (^{o}C)');
legend({'t = 0s','t = 200s','t = 400s','t = 970s'},'Location','southwest');%970s from part (a)
ylim([20 225]);
xlim([0 160]);
xticks([0 20 40 60 80 100 120 140 160]);
hold off;

print('Plot','-dpng');