// Shared plotting helper. Run in Scilab with graphics enabled.
function drawseq(n,x,ttl)
    plot2d3(n,x);
    title(ttl); xlabel("n (sample index)"); ylabel("Amplitude");
    xgrid();
endfunction

// EX 1.1
x=1:4; y=5:8;
a=x+1; b=x.*y;
z=linspace(0,%pi,10); c=sin(z);
disp(a,"x+1 ="); disp(b,"x.*y ="); disp(c,"sin(z) =");

// EX 1.2: 5 periods, N0=6 samples. Endpoint n=30 closes the plot.
Fs=300; F0=50; Ts=1/Fs; T0=1/F0; N0=6; Delta=0.1;
t=linspace(0,5*T0,3001); xa=3*sin(100*%pi*t);
n=0:5*N0; x=3*sin(%pi*n/3);
// Snap only near-integer quantizer coordinates to suppress roundoff.
r=x/Delta; k=find(abs(r-round(r))<1d-10); r(k)=round(r(k));
xq=Delta*floor(r);
scf(101); clf();
subplot(3,1,1); plot(t,xa); title("Analog xa(t): five periods");
xlabel("t (s)"); ylabel("Amplitude"); xgrid();
subplot(3,1,2); drawseq(n,x,"Sampled x(n), Fs=300 Hz, N0=6");
subplot(3,1,3); drawseq(n,xq,"Quantized xq(n), floor, Delta=0.1");
disp([n(1:6);x(1:6);xq(1:6)],"Rows: n, x(n), xq(n); one period");
mprintf("F0=%g Hz, T0=%g s, f0=1/6 cycles/sample, omega0=pi/3 rad/sample\n",F0,T0);
mprintf("N0=%d samples, quantization error range: [%g,%g]\n",N0,min(xq-x),max(xq-x));
if max(abs(x(1:6)-x(7:12)))>1d-10 then error("Period check failed"); end
if min(x-xq)<-1d-10 | max(x-xq)>=Delta+1d-10 then error("Quantizer check failed"); end
