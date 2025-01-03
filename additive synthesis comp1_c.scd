(
Server.default = s = Server.local;
////server setup
(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=6;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(0.5);
s.options.memSize = 8192*128*2;
s.options.blockSize = 64*1;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 44100;
);

s.waitForBoot{
/////wavetables
Buffer.freeAll;
(
~controlBus_az = Bus.control(s, 1);
~controlBus_el = Bus.control(s, 1);
~controlBus_magx = Bus.control(s, 1);
~controlBus_magy = Bus.control(s, 1);
~controlBus_magz = Bus.control(s, 1);
);


(
var  sph1,sph2,sph3,sph4,sph5,m_x=3,m_y=4,m_z=3;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;
var angle = 0;

~tempo=2;


~az =  Routine({
		loop{
		az1=(az1+(1)).wrap(180.neg,180);
	el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90);
	sph1=Spherical(1,(az1.degrad).wrap(pi.neg,pi),(el1.degrad).wrap((pi/2).neg,(pi/2))).theta.round(0.00001);
		"az".postln;
		sph1.postln;
		~controlBus_az.set(sph1);
	pl1=pl1+1;
	~tempo.wait;
}});

~el = Routine({
		loop{
		az2=(az2+(1)).wrap(180.neg,180);
	el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90);
	sph2=Spherical(1,(az2.degrad).wrap(pi.neg,pi),(el2.degrad).wrap((pi/2).neg,(pi/2))).phi.round(0.00001);
			"el".postln;
		sph2.postln;
		~controlBus_el.set(sph2);
		pl2=pl2+1;
		~tempo.wait;
}});

~magx = Routine({
		loop{
	az3=(az3+(1)).wrap(180.neg,180);
	el3=(el3+(360-(360/1.6180339887499))).wrap(90.neg,90);
	sph3=Spherical(1,(az3.degrad).wrap(pi.neg,pi),(el3.degrad).wrap((pi/2).neg,(pi/2)));	 mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

		/* mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
			cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
		 	2).neg,(pi/2)))).rho*
		 Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;*/
		mag_x=mag_x/(2.sqrt);
				"magx".postln;
		mag_x.postln;
		~controlBus_magx.set(mag_x);
		pl3=pl3+1;
		~tempo.wait;
}});

~magy = Routine({
		loop{
	az4=(az4+(1)).wrap(180.neg,180);
	el4=(el4+(360-(360/1.6180339887499))).wrap(90.neg,90);
	sph4=Spherical(1,(az4.degrad).wrap(pi.neg,pi),(el4.degrad).wrap((pi/2).neg,(pi/2)));
	mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph4.rho;
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
		mag_y=mag_y/(2.sqrt);
				"magy".postln;
		mag_y.postln;
		~controlBus_magy.set(mag_y);
			pl4=pl4+1;
		~tempo.wait;
}});

~magz = Routine({
		loop{
pl5=pl5+1;
	az5=(az5+(1)).wrap(180.neg,180);
	el5=(el5+(360-(360/1.6180339887499))).wrap(90.neg,90);
		sph5=Spherical(1,(az5.degrad).wrap(pi.neg,pi),(el5.degrad).wrap((pi/2).neg,(pi/2)));

if(
m_z.even,
mag_z=Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho,
mag_z=Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho
	);
		mag_z=mag_z/(2.sqrt);
				"magz".postln;
		mag_z.postln;
		~controlBus_magz.set(mag_z);
				pl5=pl5+1;
		~tempo.wait;
}});

)



(
	~a = VBAPSpeakerArray.new(3, [[0, 45], [180, 45], [90, 45.neg], [90.neg, 45.neg]]);
	 ~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
~t= Buffer.alloc(s,2048);
		{
var signal,wt,m=0,amp;

~level=90.collect{m=m+1;amp=m.reciprocal};
~phase=90.collect{pi};
signal=Signal.sineFill(1024,~level,~phase);

wt = signal.asWavetable;
~t.loadCollection(wt);
signal.plot;
		}.value;
);
(
~lag=0.05;
SynthDef.new(\ospace1, {
	var phase,osc1,osc2,osc3,sphere,mag_o,pl=1,octave=8,mult=24,xr=1,yr=1,zr=1;
	var tonx1,tonx2,tonx3,tony1,tony2,tony3,tonz1,tonz2,tonz3;
	var fundamental=55;
	var freq,m=1;
	var ampx1,ampx2,ampx3,ampy1,ampy2,ampy3,ampz1,ampz2,ampz3;
	var pitchx1,pitchx2,pitchx3,pitchy1,pitchy2,pitchy3,pitchz1,pitchz2,pitchz3;
	var v0,v,v6,q1,q2,q3,q4,q5,axis;
	var xyz,xyz_array;
	var nx1,nx2,nx3,ny1,ny2,ny3,nz1,nz2,nz3;
	var sphere1,sphere2,sphere3;
	var sph1,sph2,sph3;
	var angle,sph;

	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut3 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
var out1 = NamedControl.kr(\out1, [0, 1, 2, 3]);  // multiple buses!
//	var out2 = NamedControl.kr(\out2, [0, 1, 2, 3, 4, 5]);  // multiple buses!
//	var out3 = NamedControl.kr(\out3, [0, 1, 2, 3, 4, 5]);  // multiple buses!

freq=(fundamental*octave);

			mag_o=Cartesian(In.kr(~controlBus_magx).lag(~lag),In.kr(~controlBus_magy).lag(~lag),In.kr(~controlBus_magz).lag(~lag));

	sphere1=Spherical(mag_o.x,In.kr(~controlBus_az).lag(~lag),In.kr(~controlBus_el).lag(~lag));
	sphere2=Spherical(mag_o.y,In.kr(~controlBus_az).lag(~lag),In.kr(~controlBus_el).lag(~lag));
	sphere3=Spherical(mag_o.z,In.kr(~controlBus_az).lag(~lag),In.kr(~controlBus_el).lag(~lag));
	sphere=Spherical(mag_o.rho.round(0.00000001)/(2.sqrt),In.kr(~controlBus_az).lag(~lag),In.kr(~controlBus_el).lag(~lag));

			sph1=Spherical(sphere1.rho*mult,sphere.theta,sphere.phi);
			sph2=Spherical(sphere2.rho*mult,sphere.theta,sphere.phi);
			sph3=Spherical(sphere3.rho*mult,sphere.theta,sphere.phi);


	nx1=(sph1.x).round(0.00001); nx2=(sph1.y).round(0.00001); nx3=(sph1.z).round(0.00001);
	ny1=(sph2.x).round(0.00001); ny2=(sph2.y).round(0.00001); ny3=(sph2.z).round(0.00001);
	nz1=(sph3.x).round(0.00001); nz2=(sph3.y).round(0.00001); nz3=(sph3.z).round(0.00001);

tonx1=2.pow(nx1/(2*6));tonx2=2.pow(nx2/(2*6));tonx3=2.pow(nx3/(2*6));
tony1=2.pow(ny1/(2*6));tony2=2.pow(ny2/(2*6));tony3=2.pow(ny3/(2*6));
tonz1=2.pow(nz1/(2*6));tonz2=2.pow(nz2/(2*6));tonz3=2.pow(nz3/(2*6));


   ampx1=(tonx1.reciprocal*octave.reciprocal).round(0.00001);ampx2=(tonx2.reciprocal*octave.reciprocal).round(0.00001);ampx3=(tonx3.reciprocal*octave.reciprocal).round(0.00001);
   ampy1=(tony1.reciprocal*octave.reciprocal).round(0.00001);ampy2=(tony2.reciprocal*octave.reciprocal).round(0.00001);ampy3=(tony3.reciprocal*octave.reciprocal).round(0.00001);
   ampz1=(tonz1.reciprocal*octave.reciprocal).round(0.00001);ampz2=(tonz2.reciprocal*octave.reciprocal).round(0.00001);ampz3=(tonz3.reciprocal*octave.reciprocal).round(0.00001);

	pitchx1=(freq*tonx1).round(0.00001);pitchx2=(freq*tonx2).round(0.00001);pitchx3=(freq*tonx3).round(0.00001);
	pitchy1=(freq*tony1).round(0.00001);pitchy2=(freq*tony2).round(0.00001);pitchy3=(freq*tony3).round(0.00001);
	pitchz1=(freq*tonz1).round(0.00001);pitchz2=(freq*tonz2).round(0.00001);pitchz3=(freq*tonz3).round(0.00001);

				phase=Complex(exp(Complex(0,1)*(sphere.theta)).real.round(0.000001),exp(Complex(0,1)*(sphere.phi)).imag.round(0.000001)).theta;


osc1=VBAP.ar(4,
SinOsc.ar(pitchx1,mul:ampx1,phase:phase)+SinOsc.ar(pitchx2,mul:ampx2,phase:phase)+SinOsc.ar(ampx3,mul:ampx3,phase:phase),
~b.bufnum,
sphere.theta.raddeg,sphere.phi.raddeg
//Osc.ar(~t.bufnum,1,phase:sphere1.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
//Osc.ar(~t.bufnum,1,phase:sphere1.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

osc2=VBAP.ar(4,
SinOsc.ar(pitchy1,mul:ampy1,phase:phase)+SinOsc.ar(pitchy2,mul:ampy2,phase:phase)+SinOsc.ar(ampy3,mul:ampy3,phase:phase),
~b.bufnum,
sphere.theta.raddeg,sphere.phi.raddeg
//Osc.ar(~t.bufnum,1,phase:sphere2.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
//Osc.ar(~t.bufnum,1,phase:sphere2.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

osc3=VBAP.ar(4,
SinOsc.ar(pitchz1,mul:ampz1,phase:phase)+SinOsc.ar(pitchz2,mul:ampz2,phase:phase)+SinOsc.ar(ampz3,mul:ampz3,phase:phase),
~b.bufnum,
sphere.theta.raddeg,sphere.phi.raddeg
//Osc.ar(~t.bufnum,1,phase:sphere3.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
//Osc.ar(~t.bufnum,1,phase:sphere3.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

	//wrappedOut3.value(out1,LeakDC.ar(osc3,mul:env));
					Out.ar(0,LeakDC.ar(LeakDC.ar(osc3,mul:1)));

	//	wrappedOut2.value(out1,LeakDC.ar(osc2,mul:env));
					Out.ar(0,LeakDC.ar(LeakDC.ar(osc2,mul:1)));

		//wrappedOut1.value(out1,LeakDC.ar(osc1,mul:env));
					Out.ar(0,LeakDC.ar(LeakDC.ar(osc1,mul:1)));

}).add;
);
}
)


(
~az.play;
~el.play;
~magx.play;
~magy.play;
~magz.play;
Synth(\ospace1);
//s.record(numChannels:4)
)