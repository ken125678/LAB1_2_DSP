// Shared plotting helper. Run in Scilab with graphics enabled.
function drawseq(n,x,ttl)
    plot2d3(n,x);
    title(ttl); xlabel("n (sample index)"); ylabel("Amplitude");
    xgrid();
endfunction

// CHAPTER 1, EX 1.1: conceptual illustrations only, not measured data.
m=0:5; price=[10,10.2,10.1,10.4,10.3,10.5];
weight=[3.2,4.1,5.0,5.7,6.2,6.7]; height=[50,54,58,61,64,66];
scf(301); clf();
subplot(3,1,1); drawseq(m,price,"1.1a: illustrative daily stock price"); xlabel("Day");
subplot(3,1,2); drawseq(m,weight,"1.1e: illustrative monthly weight"); xlabel("Month"); ylabel("kg");
subplot(3,1,3); drawseq(m,height,"1.1e: illustrative monthly height"); xlabel("Month"); ylabel("cm");
mprintf("1.1b: color movie I(x,y,k) with RGB channels.\n");
mprintf("1.1c: steering angle theta(t); 1.1d: ground position [X(t),Y(t),Z(t)].\n");

// EX 1.3: plots illustrate; irrationality proves nonperiodicity.
t=linspace(0,4*%pi/5,1001); n=0:63;
a=3*cos(5*t+%pi/6); b=3*cos(5*n+%pi/6);
c=2*exp(%i*(n/6-%pi)); d=cos(n/8).*cos(%pi*n/8);
e=cos(%pi*n/2)-sin(%pi*n/8)+3*cos(%pi*n/4+%pi/3);
scf(303); clf();
subplot(3,2,1); plot(t,a); title("1.3a: T0=2*pi/5 s"); xlabel("t (s)"); ylabel("Amplitude");
subplot(3,2,2); drawseq(n,b,"1.3b: nonperiodic");
subplot(3,2,3); drawseq(n,real(c),"1.3c: real part, nonperiodic");
subplot(3,2,4); drawseq(n,imag(c),"1.3c: imaginary part");
subplot(3,2,5); drawseq(n,d,"1.3d: nonperiodic");
subplot(3,2,6); drawseq(n,e,"1.3e: fundamental N0=16");
mprintf("1.3e: period-16 residual = %.3e\n",max(abs(e(1:48)-e(17:64))));

// EX 1.6: rational and irrational sampling ratios.
n=0:39; xr=cos(2*%pi*(2/5)*n); xi=cos(2*%pi*(sqrt(2)/10)*n);
scf(306); clf();
subplot(2,1,1); drawseq(n,xr,"1.6: T/Tp=2/5, N0=5");
subplot(2,1,2); drawseq(n,xi,"1.6: T/Tp=sqrt(2)/10, nonperiodic");
mprintf("1.6 rational case: period-5 residual = %.3e\n",max(abs(xr(1:35)-xr(6:40))));

// EX 1.7: sine representatives preserve alias phase/sign.
Fs=8000; n=0:24;
s5=sin(2*%pi*5000*n/Fs); a5=-sin(2*%pi*3000*n/Fs);
s9=sin(2*%pi*9000*n/Fs); a9=sin(2*%pi*1000*n/Fs);
scf(307); clf();
subplot(2,2,1); drawseq(n,s5,"1.7b: sampled 5 kHz sine");
subplot(2,2,2); drawseq(n,a5,"1.7b: -sin at 3 kHz");
subplot(2,2,3); drawseq(n,s9,"1.7c: sampled 9 kHz sine");
subplot(2,2,4); drawseq(n,a9,"1.7c: +sin at 1 kHz");
mprintf("1.7 alias residuals: %.3e, %.3e\n",max(abs(s5-a5)),max(abs(s9-a9)));

// EX 1.9: two components collapse with opposite sine signs.
Fs=600; n=0:24; t=linspace(0,0.04,2001);
x=sin(0.8*%pi*n)+3*sin(1.2*%pi*n);
y=-2*sin(0.8*%pi*n);
scf(309); clf();
subplot(3,1,1); plot(t,sin(480*%pi*t)+3*sin(720*%pi*t));
title("1.9: original analog signal"); xlabel("t (s)"); ylabel("Amplitude");
subplot(3,1,2); drawseq(n,x,"1.9: samples, Fs=600 Hz");
subplot(3,1,3); plot(t,-2*sin(480*%pi*t));
title("1.9: ideal reconstructed -2sin(480*pi*t)"); xlabel("t (s)"); ylabel("Amplitude");
mprintf("1.9 alias identity residual = %.3e\n",max(abs(x-y)));

// EX 1.10: 1024 endpoint-inclusive levels on [-5,5].
Rb=10000; L=1024; bits=10; Fs=Rb/bits; Ffold=Fs/2;
xmin=-5; xmax=5; Delta=(xmax-xmin)/(L-1);
n=0:49; x=3*cos(0.6*%pi*n)+2*cos(1.8*%pi*n);
y=3*cos(0.6*%pi*n)+2*cos(0.2*%pi*n);
qindex=round((x-xmin)/Delta);
qindex(find(qindex<0))=0; qindex(find(qindex>L-1))=L-1;
xq=xmin+Delta*qindex;
scf(310); clf();
subplot(3,1,1); drawseq(n,x,"1.10: sampled signal");
subplot(3,1,2); drawseq(n,y,"1.10: equivalent 300 Hz + 100 Hz");
subplot(3,1,3); drawseq(n,xq,"1.10: optional rounded 1024-level quantization");
mprintf("1.10: bits=%g, Fs=%g Hz, folding=%g Hz, Nyquist=1800 Hz\n",bits,Fs,Ffold);
mprintf("Delta=10/1023=%.10f V; alias residual=%.3e\n",Delta,max(abs(x-y)));
