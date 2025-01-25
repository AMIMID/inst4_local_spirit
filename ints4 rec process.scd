(
s.options.numBuffers=1024*2;
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=8;
s.options.numInputBusChannels=2;
s.options.memSize = 8192*128*2;
s.options.blockSize = 64;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 44100;
s.options.maxSynthDefs=1024*8;
s.waitForBoot;
)
////////////////////////////////////////////////////////////inst4 nest rec1
(
~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/SC_250122_172029.wav",channels:0 );
~c2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/SC_250122_172029.wav",channels:1 );
~c3 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/SC_250122_172029.wav",channels:2 );
~c4 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/SC_250122_172029.wav",channels:3 );
)
Buffer.freeAll

~dur=(~c1.numFrames/44100)

(
SynthDef.new(\nest,{
	var amp=1;

Out.ar(4,PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum),startPos:0, loop: 1, doneAction:2)*amp);
Out.ar(5,PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2.bufnum),startPos:0, loop: 1, doneAction:2)*amp);
Out.ar(6,PlayBuf.ar(1, ~c3.bufnum, BufRateScale.kr(~c3.bufnum),startPos:0, loop: 1, doneAction:2)*amp);
Out.ar(7,PlayBuf.ar(1, ~c4.bufnum, BufRateScale.kr(~c4.bufnum),startPos:0, loop: 1, doneAction:2)*amp);
}).add;
)

~nest=Synth.new(\nest);



({
		var n=1.neg;
	~k=(256).collect{
		n=n+1;
		}
		}.value
	)

~seed = 12345.rand;
(
//~d=Pxrand(~k,512).asStream;
thisThread.randSeed = ~seed;~d=~k.scramble;
256.do{
	|i|
(
		SynthDef.new(\obin_++i, {

    var b=0;
    var chain1,chain2,chain3,chain4;
	var sig1,sig2,sig3,sig4;
	var in1, in2,in3,in4;
	var bank,frames=1024/2;
	var samplerate=44100;
	var env;

env=EnvGen.ar(Env([0,1,1,0],[0,~dur,0]));
			in1 = InFeedback.ar(4);
			in2 = InFeedback.ar(5);
			in3 = InFeedback.ar(6);
			in4 = InFeedback.ar(7);


	chain1 = FFT(LocalBuf(frames), in1);
	chain2 = FFT(LocalBuf(frames), in2);
	chain3 = FFT(LocalBuf(frames), in3);
	chain4 = FFT(LocalBuf(frames), in4);

			b=~d.[i].postln;

sig1 = chain1.pvcollect(frames, {|magnitude, phase, bin|
		[magnitude,phase]

}, frombin: b, tobin: b, zeroothers: 1);

sig2 = chain2.pvcollect(frames, {|magnitude, phase, bin|

		[magnitude,phase]

}, frombin: b, tobin: b, zeroothers: 1);

sig3 = chain3.pvcollect(frames, {|magnitude, phase, bin|

		[magnitude,phase]

}, frombin: b, tobin: b, zeroothers: 1);

sig4 = chain4.pvcollect(frames, {|magnitude, phase, bin|

		[magnitude,phase]

}, frombin: b, tobin: b, zeroothers: 1);

		Out.ar(0,IFFT(sig1)*env);
		Out.ar(1,IFFT(sig2)*env);
		Out.ar(2,IFFT(sig3)*env);
		Out.ar(3,IFFT(sig4)*env);
			chain1.clear;
			chain2.clear;
			chain3.clear;
			chain4.clear;

}).add;
);
}
)

~m=Pseq(~k,256).asStream;
Synth(\obin_++(~m.next))

//////////////////////////////////////////////buffer rec2

(
(
~a = VBAPSpeakerArray.new(3, [[0, 45], [180, 45], [90, 45.neg], [90.neg, 45.neg]]);
	 ~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
);

//////////////////////////////////////////////////basis
{
var m_x=2,m_y=4,m_z=3,az=0,el=0,sph_axis;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;
var azimuth,elevation,magnitudex,magnitudey,magnitudez;
var axis=Quaternion(0,0,0,1);
var angle=(360-(360/1.6180339887499))/2;
var sph1,sph2,sph3,sph4,sph5,sph;
var rotation,v,v1,v2,v3,v4,v5;
var rotation1,rotation2,rotation3,rotation4,rotation5;

~az=[0];~el=[0];~magx=[0];~magy=[0];~magz=[0];

 360.do{
		sph=Spherical(1,(az),(el));
			v=Quaternion(0, sph.x.round(0.000001), sph.y.round(0.000001), sph.z.round(0.000001));
		rotation=((axis*exp(Complex(0,1)*angle.degrad).imag)+exp(Complex(0,1)*angle.degrad).real);
		v=rotation*v*rotation.conjugate;
		az=Cartesian(v.b,v.c,v.d).theta.round(0.000001);
		el=Cartesian(v.b,v.c,v.d).phi.round(0.000001);
		sph_axis=Quaternion(0,v.b,v.c,v.d);
		angle=(360-(360/1.6180339887499))/2;

azimuth=(12).collect{

			sph1=Cartesian(0,0,1);
			v1=Quaternion(0, sph1.x, sph1.y, sph1.z);
			rotation1=((sph_axis*exp(Complex(0,1)*((pi/2)*2.pow(pl1/12)).mod(2pi)).imag)+exp(Complex(0,1)*((pi/2)*2.pow(pl1/12)).mod(2pi)).real);
			v1=rotation1*v1*rotation1.conjugate;
			az1 = Cartesian(v1.b,v1.c,v1.d).theta.round(0.000001);
			el1 =Cartesian(v1.b,v1.c,v1.d).phi.round(0.000001);
		pl1=(pl1+1).mod(13);
			sph1=Spherical(1,az1,el1).theta.round(0.000001);
	};

elevation=(12).collect{

		sph2=Cartesian(0,0,1);
			v2=Quaternion(0, sph2.x, sph2.y, sph2.z);
			rotation2=((sph_axis*exp(Complex(0,1)*((pi/2)*2.pow(pl2/12)).mod(2pi)).imag)+exp(Complex(0,1)*((pi/2)*2.pow(pl2/12)).mod(2pi)).real);
			v2=rotation2*v2*rotation2.conjugate;
			az2 = Cartesian(v2.b,v2.c,v2.d).theta.round(0.000001);
			el2 =Cartesian(v2.b,v2.c,v2.d).phi.round(0.000001);
		pl2=(pl2+1).mod(13);
			sph2=Spherical(1,az2,el2).phi.round(0.000001);
	};

magnitudex=(12).collect{

			sph3=Cartesian(0,0,1);
			v3=Quaternion(0, sph3.x, sph3.y, sph3.z);
			rotation3=((sph_axis*exp(Complex(0,1)*((pi/2)*2.pow(pl3/12)).mod(2pi)).imag)+exp(Complex(0,1)*((pi/2)*2.pow(pl3/12)).mod(2pi)).real);
			v3=rotation3*v3*rotation3.conjugate;
			az3 = Cartesian(v3.b,v3.c,v3.d).theta.round(0.000001);
			el3 =Cartesian(v3.b,v3.c,v3.d).phi.round(0.000001);
		pl3=(pl3+1).mod(13);
			sph3=Spherical(1,az3,el3);
	 mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

		/* mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
			cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
		 	2).neg,(pi/2)))).rho*
		 Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;*/
};
magnitudey=(12).collect{

			sph4=Cartesian(0,0,1);
			v4=Quaternion(0, sph4.x, sph4.y, sph4.z);
			rotation4=((sph_axis*exp(Complex(0,1)*((pi/2)*2.pow(pl4/12)).mod(2pi)).imag)+exp(Complex(0,1)*((pi/2)*2.pow(pl4/12)).mod(2pi)).real);
			v4=rotation4*v4*rotation4.conjugate;
			az4 = Cartesian(v4.b,v4.c,v4.d).theta.round(0.000001);
			el4 =Cartesian(v4.b,v4.c,v4.d).phi.round(0.000001);
		pl4=(pl4+1).mod(13);
			sph4=Spherical(1,az4,el4);

	mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph4.rho;
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
};
magnitudez=(12).collect{

			sph5=Cartesian(0,0,1);
			v5=Quaternion(0, sph5.x, sph5.y, sph5.z);
			rotation5=((sph_axis*exp(Complex(0,1)*((pi/2)*2.pow(pl5/12)).mod(2pi)).imag)+exp(Complex(0,1)*((pi/2)*2.pow(pl5/12)).mod(2pi)).real);
			v5=rotation5*v5*rotation5.conjugate;
			az5 = Cartesian(v5.b,v5.c,v5.d).theta.round(0.000001);
			el5 =Cartesian(v5.b,v5.c,v5.d).phi.round(0.000001);
		pl5=(pl5+1).mod(13);
			sph5=Spherical(1,az5,el5);

if(
m_z.even,
mag_z=Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho,
mag_z=Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
};
		~az=~az++azimuth;~el=~el++elevation;~magx=~magx++magnitudex;~magy=~magy++magnitudey;~magz=~magz++magnitudez
	};
}.value;
(
			~magx=(~magx).round(0.000000001)/(2.sqrt);
			~magy=(~magy).round(0.000000001)/(2.sqrt);
			~magz=(~magz).round(0.000000001)/(2.sqrt);
 );
)

Buffer.freeAll

~c1 = Buffer.readChannel(s,,channels:0 );

~dur=(~c1.numFrames/44100)

(
SynthDef.new(\buffer,{
	var amp=1;

Out.ar(4,PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum),startPos:0, loop: 1, doneAction:2)*amp);

}).add;
)

~nest=Synth.new(\buffer);


({
		var n=1.neg;
	~k=(512).collect{
		n=n+1;
		}
		}.value
	)


~seed = 12345.rand;
(
//~d=Pxrand(~k,512).asStream;
thisThread.randSeed = ~seed;~d=~k.scramble;
512.do{
	|i|
(
		SynthDef.new(\obin_++i, {

    var b=0;
    var in1,chainx;
	var chainxx;
	var bank,frames=1024;
	var samplerate=44100;
	var az,el,amp,sig;
	var env;

env=EnvGen.ar(Env([0,1,1,0],[0,~dur,0]));

			in1 = InFeedback.ar(4);
		az=~az.[i+1];
		el=~el.[i+1];

amp=Cartesian(~magx[i+1],~magy.[i+1],~magz.[i+1]);

	chainx = FFT(LocalBuf(frames), in1);
			b=~d.[i];

chainxx = chainx.pvcollect(frames, {|magnitude, phase, bin|
				[magnitude*(amp.rho/(2.sqrt)),phase]

}, frombin: b, tobin: b, zeroothers: 1);

			sig=IFFT(chainxx);

	Out.ar(0,VBAP.ar(4,sig,~b.bufnum,az.raddeg,el.raddeg)*env);
			chainx.clear;

}).add;
);
}
)

~m=Pseq(~k,512).asStream;
Synth(\obin_++(~m.next))

///////////////////////////////final mix (storyline)

s.record(numChannels:4);

///nest
(
~c1 = Buffer.readChannel(s,,channels:0 );
~c2 = Buffer.readChannel(s,,channels:1 );
~c3 = Buffer.readChannel(s,,channels:2 );
~c4 = Buffer.readChannel(s,,channels:3 );
)
(
{Out.ar(0,PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
{Out.ar(1,PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
{Out.ar(2,PlayBuf.ar(1, ~c3.bufnum, BufRateScale.kr(~c3.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
{Out.ar(3,PlayBuf.ar(1, ~c4.bufnum, BufRateScale.kr(~c4.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
)
////buffer1
(
~c5 = Buffer.readChannel(s,,channels:0 );
~c6 = Buffer.readChannel(s,,channels:1 );
~c7 = Buffer.readChannel(s,,channels:2 );
~c8 = Buffer.readChannel(s,,channels:3 );
)
(
{Out.ar(0,PlayBuf.ar(1, ~c5.bufnum, BufRateScale.kr(~c5.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
{Out.ar(1,PlayBuf.ar(1, ~c6.bufnum, BufRateScale.kr(~c6.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
{Out.ar(2,PlayBuf.ar(1, ~c7.bufnum, BufRateScale.kr(~c7.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
{Out.ar(3,PlayBuf.ar(1, ~c8.bufnum, BufRateScale.kr(~c8.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
)
////buffer2
(
~c9 = Buffer.readChannel(s,,channels:0 );
~c10 = Buffer.readChannel(s,,channels:1 );
~c11 = Buffer.readChannel(s,,channels:2 );
~c12 = Buffer.readChannel(s,,channels:3 );
)
(
{Out.ar(0,PlayBuf.ar(1, ~c9.bufnum, BufRateScale.kr(~c9.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
{Out.ar(1,PlayBuf.ar(1, ~c10.bufnum, BufRateScale.kr(~c10.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
{Out.ar(2,PlayBuf.ar(1, ~c11.bufnum, BufRateScale.kr(~c11.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
{Out.ar(3,PlayBuf.ar(1, ~c12.bufnum, BufRateScale.kr(~c12.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
)
////buffer3
(
~c13 = Buffer.readChannel(s,,channels:0 );
~c14 = Buffer.readChannel(s,,channels:1 );
~c15 = Buffer.readChannel(s,,channels:2 );
~c16 = Buffer.readChannel(s,,channels:3 );
)
(
{Out.ar(0,PlayBuf.ar(1, ~c13.bufnum, BufRateScale.kr(~c13.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
{Out.ar(1,PlayBuf.ar(1, ~c14.bufnum, BufRateScale.kr(~c14.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
{Out.ar(2,PlayBuf.ar(1, ~c15.bufnum, BufRateScale.kr(~c15.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
{Out.ar(3,PlayBuf.ar(1, ~c16.bufnum, BufRateScale.kr(~c16.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
)
///////buffer4
(
~c17 = Buffer.readChannel(s,,channels:0 );
~c18 = Buffer.readChannel(s,,channels:1 );
~c19 = Buffer.readChannel(s,,channels:2 );
~c20 = Buffer.readChannel(s,,channels:3 );
)
(
{Out.ar(0,PlayBuf.ar(1, ~c17.bufnum, BufRateScale.kr(~c17.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
{Out.ar(1,PlayBuf.ar(1, ~c18.bufnum, BufRateScale.kr(~c18.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
{Out.ar(2,PlayBuf.ar(1, ~c19.bufnum, BufRateScale.kr(~c19.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
{Out.ar(3,PlayBuf.ar(1, ~c20.bufnum, BufRateScale.kr(~c20.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
)



Buffer.freeAll

