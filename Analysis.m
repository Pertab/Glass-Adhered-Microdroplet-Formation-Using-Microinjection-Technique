clc
clear  
close all

T = 50; % Surface tension of oil-water interface

data = readtable('dd.xlsx'); % Diameter at all four pressure values

r800 =   (data.Var1/2);
r1000 =  (data.Var2/2);
r1200 =  (data.Var3/2);
r1500 =  (data.Var4/2);

r = [r800 r1000 r1200 r1500];


pin800 =  ((2*T)./r800);
pin1000 = ((2*T)./r1000);
pin1200 = ((2*T)./r1200);
pin1500 = ((2*T)./r1500);

p = [pin800 pin1000 pin1200 pin1500];


figure (1)
boxplot([data.Var1, data.Var2, data.Var3, data.Var4], 'Notch','on','Labels',{'800','1000', '1200', '1500'})
xlabel ("Injection Pressure in mbar");
ylabel ("Droplet diameter in micrometers um")
title ("Injection pressure vs droplet diameters")

figure (2)
scatter(r,p,'filled')
xlabel("Radius of microdroplets in micrometer um");
ylabel("inner pressure of droplets in mN/m^2")
title ("Relation between Radius of microdropets and Inner pressure")
grid on