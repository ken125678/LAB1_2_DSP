// Shared plotting helper. Run in Scilab with graphics enabled.
function drawseq(n,x,ttl)
    plot2d3(n,x);
    title(ttl); xlabel("n (sample index)"); ylabel("Amplitude");
    xgrid();
endfunction

// EX 1: investigate all nine requested functions.
n=-2:2; v=[2,-1,4,0,3];
disp(min(v),"min(v) ="); disp(max(v),"max(v) =");
disp(bool2s(n>=0),"bool2s(n>=0) =");
deff("y=square_signal(t)","y=t.^2");
disp(square_signal(n),"square_signal(n) =");
scf(201); clf();
subplot(2,1,1); plot2d3(n,v); title("EX1: plot2d3"); xlabel("n"); ylabel("v(n)");
subplot(2,1,2); drawseq(n,square_signal(n),"EX1: deff, y=n^2");

// EX 2, 3, 4
n=-5:5;
scf(202); clf(); drawseq(n,bool2s(n>=0),"EX2: unit step u(n)");
scf(203); clf(); drawseq(n,bool2s(n==0),"EX3: unit impulse delta(n)");
scf(204); clf(); drawseq(n,n.*bool2s(n>=0),"EX4: unit ramp ur(n)");
disp([n;bool2s(n>=0);bool2s(n==0);n.*bool2s(n>=0)],"Rows: n, step, impulse, ramp");

// EX 5: x(-1)=1, x(0)=3, x(1)=-2, zero elsewhere.
n=-3:3;
x=bool2s(n==-1)+3*bool2s(n==0)-2*bool2s(n==1);
xrev=bool2s(-n==-1)+3*bool2s(-n==0)-2*bool2s(-n==1);
xe=(x+xrev)/2; xo=(x-xrev)/2;
scf(205); clf();
subplot(3,1,1); drawseq(n,x,"EX5: x(n)");
subplot(3,1,2); drawseq(n,xo,"EX5: odd component xo(n)");
subplot(3,1,3); drawseq(n,xe,"EX5: even component xe(n)");
disp([n;x;xo;xe],"Rows: n, x, xo, xe");
if max(abs(x-xe-xo))>1d-12 then error("Even/odd reconstruction failed"); end

// EX 6 and 7: align sample indices before arithmetic.
n=-1:3; x1=[0,0,1,3,-2]; x2=[0,1,2,3,0];
ysum=x1+x2; yprod=x1.*x2;
scf(206); clf();
subplot(3,1,1); drawseq(n,x1,"EX6: x1(n)");
subplot(3,1,2); drawseq(n,x2,"EX6: x2(n)");
subplot(3,1,3); drawseq(n,ysum,"EX6: x1(n)+x2(n)");
scf(207); clf();
subplot(3,1,1); drawseq(n,x1,"EX7: x1(n)");
subplot(3,1,2); drawseq(n,x2,"EX7: x2(n)");
subplot(3,1,3); drawseq(n,yprod,"EX7: x1(n).*x2(n)");
disp([n;x1;x2;ysum;yprod],"Rows: n, x1, x2, sum, product");

// EX 8: represent the signal as shifted impulses for safe indexing.
function y=original(k)
    y=bool2s(k==-2)-2*bool2s(k==-1)+3*bool2s(k==0)+6*bool2s(k==1);
endfunction
n=-6:4; x=original(n);
y1=original(-n); y2=original(n+3); y3=2*original(-n-2);
scf(208); clf();
subplot(2,1,1); drawseq(n,x,"EX8a: original x(n)");
subplot(2,1,2); drawseq(n,y1,"EX8a: y1(n)=x(-n)");
scf(209); clf();
subplot(2,1,1); drawseq(n,x,"EX8b: original x(n)");
subplot(2,1,2); drawseq(n,y2,"EX8b: y2(n)=x(n+3)");
scf(210); clf();
subplot(2,1,1); drawseq(n,x,"EX8c: original x(n)");
subplot(2,1,2); drawseq(n,y3,"EX8c: y3(n)=2x(-n-2)");
disp([n;x;y1;y2;y3],"Rows: n, x, y1, y2, y3");
