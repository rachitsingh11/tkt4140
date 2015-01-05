function [ker,kei ] = kerkei(x)
%=======================================================
% The function kerkei computes the Kelvin functions
% ker(x) and kei(x) for all values of x > 0.
% -------------- Reference -----------------------------
%  Y. L. Luke : "Mathematical Functions and 
%                their Approximations ",
%                Academic Press 1975, pp. 337 - 341
%-------------------------------------------------------
% Author : Jan B. Aarseth, NTNU
%=======================================================
%
persistent a b e f Irn Ipn Rrn Rpn eulc;
if x <= 0
    error('Non-positive argument in function kerkei !')
    return
end
if isempty(a)
    eulc = 0.57721566490153286; % Euler's constant

    % Coefficients for x <= 8.0 
    a(1)  =  4.51042309655904780; b(1)  = -29.3494910970212692;
    a(2)  = 10.84058017381306820; b(2)  =  -8.9886887413382025;
    a(3)  =  8.71271741018667555; b(3)  =   3.4669009758415113;
    a(4)  = -0.85344636969505222; b(4)  =  -0.1473580153212092;
    a(5)  =  0.01904826393473439; b(5)  =   0.0019221031542680;
    a(6)  = -0.00015599761595617; b(6)  =  -0.0000104178992770;
    a(7)  =  0.00000058296292395; b(7)  =   0.0000000277431802;
    a(8)  = -0.00000000113693089; b(8)  =  -0.0000000000405491;
    a(9)  =  0.00000000000127022; b(9)  =   0.0000000000000352;
    a(10) = -0.00000000000000087;
    
    e(1)  =  10.0749826558804862; f(1)  = -68.2262975848289816;  
    e(2)  = -82.1336254977304657; f(2)  = -33.3742603178965968;
    e(3)  =   8.6176065894624417; f(3)  =  15.9610466759839899;
    e(4)  =  -0.2094320427436054; f(4)  =  -0.7668842692524508;
    e(5)  =   0.0018372709078126; f(5)  =   0.0108943699358667;
    e(6)  =  -0.0000072563871421; f(6)  =  -0.0000629825208809;
    e(7)  =   0.0000000148110828; f(7)  =   0.0000001765552629;
    e(8)  =  -0.0000000000171943; f(8)  =  -0.0000000002692000;
                                  f(9)  =   0.0000000000002424;
                                  f(10) =  -0.0000000000000001;
    
    % Coefficients for x > 8.0 
    Irn(1)  = - 0.020003304876677665; Irn(14) =   0.000000000000112491; 
    Irn(2)  = - 0.010403419875862282; Irn(15) = - 0.000000000000143887;
    Irn(3)  = - 0.000408198835331063; Irn(16) =   0.000000000000014630; 
    Irn(4)  = - 0.000004680927085129; Irn(17) =   0.000000000000007964;
    Irn(5)  =   0.000001952536816306; Irn(18) = - 0.000000000000002698;
    Irn(6)  =   0.000000185859426183; Irn(19) = - 0.000000000000000079;
    Irn(7)  = - 0.000000021516287693; Irn(20) =   0.000000000000000253;
    Irn(8)  = - 0.000000004937472783; Irn(21) = - 0.000000000000000056;
    Irn(9)  =   0.000000000558401439; Irn(22) = - 0.000000000000000009;
    Irn(10) =   0.000000000164741320; Irn(23) =   0.000000000000000008;
    Irn(11) = - 0.000000000029146349; Irn(24) = - 0.000000000000000001;
    Irn(12) = - 0.000000000005854280; 
    Irn(13) =   0.000000000002039936; 
    
    Ipn(1)  = - 0.015813113722412005; 
    Ipn(2)  = - 0.007615211106332591; 
    Ipn(3)  =   0.000280142853466023; Ipn(11) = - 0.000000000000376173; 
    Ipn(4)  = - 0.000010867991455739; Ipn(12) = - 0.000000000000005445;
    Ipn(5)  =   0.000000343071791356; Ipn(13) =   0.000000000000009399;
    Ipn(6)  =   0.000000004778727857; Ipn(14) = - 0.000000000000002530;
    Ipn(7)  = - 0.000000002877466567; Ipn(15) =   0.000000000000000508;
    Ipn(8)  =   0.000000000446278055; Ipn(16) = - 0.000000000000000086;
    Ipn(9)  = - 0.000000000053663295; Ipn(17) =   0.000000000000000012;
    Ipn(10) =   0.000000000005345743; Ipn(18) = - 0.000000000000000001;
    
    Rrn(1)  =   2.0173070773794631; 
    Rrn(2)  =   0.0085553633966894; Rrn(11) =   0.0000000000314142; 
    Rrn(3)  = - 0.0001220782590922; Rrn(12) = - 0.0000000000075947;
    Rrn(4)  = - 0.0000252264018204; Rrn(13) = - 0.0000000000009813;
    Rrn(5)  = - 0.0000011699683310; Rrn(14) =   0.0000000000005485; 
    Rrn(6)  =   0.0000001850464323; Rrn(15) = - 0.0000000000000112;
    Rrn(7)  =   0.0000000294311444; Rrn(16) = - 0.0000000000000357;
    Rrn(8)  = - 0.0000000031114010; Rrn(17) =   0.0000000000000070;
    Rrn(9)  = - 0.0000000008810982; Rrn(18) =   0.0000000000000013;
    Rrn(10) =   0.0000000001199625; Rrn(19) = - 0.0000000000000008;
            
    Rpn(1)  =   1.9825055180275154; Rpn(8)  =   0.0000000001804058;
    Rpn(2)  = - 0.0087045775922486; Rpn(9)  =   0.0000000000074093; 
    Rpn(3)  =   0.0000488558002791; Rpn(10) = - 0.0000000000040044;
    Rpn(4)  =   0.0000054968427975; Rpn(11) =   0.0000000000008070;
    Rpn(5)  = - 0.0000006378028577; Rpn(12) = - 0.0000000000001269;
    Rpn(6)  =   0.0000000537889252; Rpn(13) =   0.0000000000000167;
    Rpn(7)  = - 0.0000000038036653; Rpn(14) = - 0.0000000000000017;
    
end
% ======= ker(x)and kei(x) for x <= 8.0 ====
if x <= 8.0
    x0 = (x/8)^2;
    xf = 2*(x0)^2 - 1;
    select = 1;
    ber  = cheby(a,xf,select);
    tker = x0^2*cheby(e,xf,select);
    tkei = x0*cheby(f,xf,select);
    select = 0;
    bei  = x0*cheby(b,xf,select);
    tc = eulc + log(x/2);
    ker = - tc*ber + (pi/4)*bei- tker;
    kei = - tc*bei - (pi/4)*ber + tkei; 
    return
end
% ======= ker(x)and kei(x) for x > 8.0 ====
x0 = 5/x;
xf = 2*x0 - 1;
select = 1;
SIrn = cheby(Irn,xf,select);
SRrn = cheby(Rrn,xf,select);
SIpn = cheby(Ipn,xf,select);
SRpn = cheby(Rpn,xf,select);
u = x/sqrt(2.0); fac = exp(-u)*sqrt(pi*0.5/x);
fac1 = cos(3*pi/8 + u); fac2 = sin(3*pi/8 + u);
fac3 = cos(pi/8 + u); fac4 = sin(pi/8 + u);
temp1 = fac3*SRpn - fac4*SIpn;
ker = fac*temp1;
temp2 = fac3*SIpn + fac4*SRpn;
kei  = - fac*temp2;
% =============== CHEBY =================
function value = cheby(coeff,xf,select)
n = length(coeff);
x = 2*xf;
b1 = 0; b0 = coeff(n);
for k = n-1:-1:1
    b2 = b1;
    b1 = b0;
    b0 = coeff(k) - b2 + x*b1;
end
if select < 0.5
    value = b0 - b1;
else
    value = (b0 - b2)*0.5;
end
