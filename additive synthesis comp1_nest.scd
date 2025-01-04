(
Server.default = s = Server.local;
////server setup
(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(0.5);
s.options.memSize = 8192*128*2;
s.options.blockSize = 64*4;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 44100;
);

s.waitForBoot{
/////wavetables
Buffer.freeAll;

(
//~w1= Buffer.alloc(s,2048);
//~w2= Buffer.alloc(s,2048);
//~w3= Buffer.alloc(s,2048);
~t= Buffer.alloc(s,2048);
~controlBus_rotation = Bus.control(s, 1);
);

////////////////////////////////////speaker setup///other
/*(
// 3D///cube
~a = VBAPSpeakerArray.new(3, [[0, 45], [90, 45], [180, 45], [90.neg, 45],[0, 45.neg], [90, 45.neg], [180, 45.neg], [90.neg, 45.neg]]);
//0 up fl, 1 up bl, 2 up br, 3 up fr, 4 down fl, 5 down bl, 6 down br, 7 down fr
~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
///furhter on speaker setup can be geodesic octahedron 2nd order torus with 16 channels, and Rhombic triacontahedron with 32 vertices as 32 speaker channels
	// )*/
	~a = VBAPSpeakerArray.new(3, [[0, 45], [180, 45], [90, 45.neg], [90.neg, 45.neg]]);
	 ~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);

	/////octahedron
	/*~a = VBAPSpeakerArray.new(3, [[0, 0], [90, 0], [180, 0], [90.neg, 0],[0,90],[0,90.neg]]);
	~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);*/

// 16
	// ~a = VBAPSpeakerArray.new(3, [[0, 45], [90, 45], [180, 45], [90.neg, 45],
	// 	[0, 0], [45, 0], [90, 0], [135, 0],[180.neg,0], [135.neg, 0], [90.neg, 0],[45.neg, 0],
	// [0, 45.neg], [90, 45.neg], [180, 45.neg], [90.neg, 45.neg]]);
	// //0 up fl, 1 up bl, 2 up br, 3 up fr, 4 down fl, 5 down bl, 6 down br, 7 down fr
	// ~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
///furhter on speaker setup can be geodesic octahedron 2nd order torus with 16 channels, and Rhombic triacontahedron with 32 vertices as 32 speaker channels
//)

///////////////////////////////////////////////////////arrays
///////fractal
	(
		~time=16;
//////////////////////////////////////////////////basis
{
var  sph1,sph2,sph3,sph4,sph5,m_x=2,m_y=2,m_z=3;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0;

~az = (360*~time).collect{

		az1 = (az1 + 3);  // Increment azimuth
        if (az1 > 180) { az1 = az1 - 360 };  // Wrap to [-180, 180)
        if (az1 <= -180) { az1 = az1 + 360 };  // Wrap to [-180, 180)

        el1 = (el1 + 3);  // Increment elevation
        if (el1 > 90) { el1 = el1 - 180 };  // Wrap to [-90, 90)
        if (el1 <= -90) { el1 = el1 + 180 };  // Wrap to [-90, 90)

		sph1=Spherical(1,(az1.degrad),(el1.degrad)).theta.round(0.00001);

	};

~el = (360*~time).collect{

			az2 = (az2 + 3);  // Increment azimuth
        if (az2 > 180) { az2 = az2 - 360 };  // Wrap to [-180, 180)
        if (az2 <= -180) { az2 = az2 + 360 };  // Wrap to [-180, 180)

        el2 = (el2 + 3);  // Increment elevation
        if (el2 > 90) { el2 = el2 - 180 };  // Wrap to [-90, 90)
        if (el2 <= -90) { el2 = el2 + 180 };  // Wrap to [-90, 90)

		sph2=Spherical(1,(az2.degrad),(el2.degrad)).phi.round(0.00001);

	};

~magx = (360*~time).collect{

		az3 = (az3 + 3);  // Increment azimuth
        if (az3 > 180) { az3 = az3 - 360 };  // Wrap to [-180, 180)
        if (az3 <= -180) { az3 = az3 + 360 };  // Wrap to [-180, 180)

        el3 = (el3 + 3);  // Increment elevation
        if (el3 > 90) { el3 = el3 - 180 };  // Wrap to [-90, 90)
        if (el3 <= -90) { el3 = el3 + 180 };  // Wrap to [-90, 90)

	sph3=Spherical(1,(az3.degrad),(el3.degrad));
	 mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

		/* mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
			cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
		 	2).neg,(pi/2)))).rho*
		 Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;*/

};

~magy = (360*~time).collect{

		az4 = (az4 + 3);  // Increment azimuth
        if (az4 > 180) { az4 = az4 - 360 };  // Wrap to [-180, 180)
        if (az4 <= -180) { az4 = az4 + 360 };  // Wrap to [-180, 180)

        el4 = (el4 + 3);  // Increment elevation
        if (el4 > 90) { el4 = el4 - 180 };  // Wrap to [-90, 90)
        if (el4 <= -90) { el4 = el4 + 180 };  // Wrap to [-90, 90)

	sph4=Spherical(1,(az4.degrad),(el4.degrad));

	mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph4.rho;
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
};

~magz = (360*~time).collect{

		az5 = (az5 + 3);  // Increment azimuth
        if (az5 > 180) { az5 = az5 - 360 };  // Wrap to [-180, 180)
        if (az5 <= -180) { az5 = az5 + 360 };  // Wrap to [-180, 180)

        el5 = (el5 + 3);  // Increment elevation
        if (el5 > 90) { el5 = el5 - 180 };  // Wrap to [-90, 90)
        if (el5 <= -90) { el5 = el5 + 180 };  // Wrap to [-90, 90)

		sph5=Spherical(1,(az5.degrad),(el5.degrad));

if(
m_z.even,
mag_z=Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho,
mag_z=Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
	};
}.value;


////////////////////////////////////////////////////////notes and durs
{
var dur=2,ph1,ph2,ph3,ph4,ph5,ph6,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0,pl6=0;
var sph1,sph2,sph3,sph4,sph5,sph6,sph7,sph8,sph9;
var n1,n2,n3,n4,n5,n6,n7,n8,n9,mult=122;
var mag1,mag2,mag3,mag4,mag5,mag6,mag7,mag8,mag9,rythm;
var index1,index2,index3,index4,index5,index6,pl7=0,pl8=0,pl9=0,t1,t2,t3,t4,t5,t6;
var pl10=0,pl11=0,pl12=0,pl13=0,pl14=0,pl15=0;

///////////////////////L-system algae variable a,b rules:a=ab b=a , n3 for n0=a
rythm=[1,1/1,1,1,1/1];

~dur = (720*~time).collect{
			ph1=Cartesian(~magx.[pl1],~magy.[pl1],~magz.[pl1]).rho/(2.sqrt);
	index1=rythm.wrapAt(pl7);
	pl7=pl7+1;
	pl1=pl1+1;
	ph1=(ph1*dur).round(1/256);
	t1=ph1*index1;

	};

}.value;
		//////////////////////wavetable
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
		//////notes
	({
		var angle=0;
		~angle=(720*~time).collect{
		angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
		}
		}.value;
	~angle1=~angle/2;
	);


	(
var angle=0

~tempo=0.1;


~t =  Routine({
		loop{
		//az1=(az1 + (45*(2.pow(1/12)-1))).wrap(180.neg,180);
		//el1=(el1 + (45*(2.pow(1/12)-1))).wrap(90.neg,90);
		angle = (angle + (360-(360/1.6180339887499)));  // Increment azimuth
        if (angle > 360) { angle = angle - 360 };  // Wrap to [-180, 180)
       // if (az1 <= -180) { az1 = az1 + 360 };  // Wrap to [-180, 180)
		angle.postln;

		~controlBus_rotation.set(angle);
	~tempo.wait;
}});

)

/////synths////
(
SynthDef.new(\ospace1, {
	arg angle_rot1=0,angle_rot2=0,angle_rot3=0,angle_rot4=0,angle_rot5=0,mult=12,xr=1,yr=1,zr=1,gate=1,pl1=0,octave=1;
	var phase,osc1,osc2,osc3,sphere,mag_o,amp1,amp2,amp3,decay=0.04444,pl2=0,envp;
	var ton1,ton2,ton3,rq1=1,rq2=1,rq3=1,cutt_freq1=1,cutt_freq2=1,cutt_freq3=1;
	var fundamental=2000,fundamental1,fundamental2,fundamental3;
	var freq1,freq2,freq3,m=1,pitch1,pitch2,pitch3,env,cutt=440;
	var v0,v,v6,q1,q2,q3,q4,q5,axis;
	var pitch;
	var xyz,xyz_array;
	var n1,n2,n3;
	var sphere1,sphere2,sphere3;
	var env_mag,env_phase;

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

				env=EnvGen.ar(Env.adsr(0.1,0.5,0.5,8),gate:gate,doneAction:2,levelScale:0.1);

fundamental=(44100/1024);
fundamental1=fundamental;
fundamental2=fundamental;
fundamental3=fundamental;
freq1=(fundamental1*octave);
freq2=(fundamental2*octave);
freq3=(fundamental3*octave);


		mag_o=Cartesian(Select.kr(pl1,~magx), Select.kr(pl1,~magy),Select.kr(pl1,~magz));

	sphere1=Spherical(mag_o.x,Select.kr(pl1,~az),Select.kr(pl1,~el));
	sphere2=Spherical(mag_o.y,Select.kr(pl1,~az),Select.kr(pl1,~el));
	sphere3=Spherical(mag_o.z,Select.kr(pl1,~az),Select.kr(pl1,~el));
	sphere=Spherical(mag_o.rho.round(0.00000001)/(2.sqrt),Select.kr(pl1,~az),Select.kr(pl1,~el));

	xyz=Spherical(mult*mag_o.rho.round(0.00000001)/(2.sqrt),sphere.theta,sphere.phi);
	xyz_array=[xyz.x.round(0.000001),xyz.y.round(0.000001),xyz.z.round(0.000001)];

v6=Quaternion(0, xyz_array.[0], xyz_array.[1], xyz_array.[2]);
/*v0=Quaternion(0,0.57735026918963,0.57735026918963,0.57735026918963);

axis=[xr,yr,zr].normalizeSum.sqrt;
i=Quaternion(0, axis.[0], 0, 0);
j=Quaternion(0, 0,  axis.[1], 0);
k=Quaternion(0, 0, 0,  axis.[2]);
v=(i+j+k);

q5=((v*exp(Complex(0,1)*angle_rot5.degrad).imag)+exp(Complex(0,1)*angle_rot5.degrad).real);
v6=q5*v6*q5.conjugate;*/


	pitch=Cartesian(v6.b,v6.c,v6.d);

	n1=(pitch.x).round(0.00001); n2=(pitch.y).round(0.00001); n3=(pitch.z).round(0.00001);

ton1=2.pow(n1/(2*6));
ton2=2.pow(n2/(2*6));
ton3=2.pow(n3/(2*6));


	    amp1=(ton1.reciprocal*octave.reciprocal*sphere1.rho).round(0.0000000000001);
		amp2=(ton2.reciprocal*octave.reciprocal*sphere2.rho).round(0.0000000000001);
		amp3=(ton3.reciprocal*octave.reciprocal*sphere3.rho).round(0.0000000000001);

	pitch1=(freq1*ton1*sphere1.rho.reciprocal).round(0.0000000000001);
	pitch2=(freq2*ton2*sphere2.rho.reciprocal).round(0.0000000000001);
	pitch3=(freq3*ton3*sphere3.rho.reciprocal).round(0.0000000000001);

				phase=Complex(exp(Complex(0,1)*(sphere.theta)).real.round(0.000001),exp(Complex(0,1)*(sphere.phi)).imag.round(0.000001)).theta;

					///%2==0 simulates .even

					envp=EnvGen.ar(Env.adsr(0.1,0.5,1/2,8,1),gate:gate);


osc1=VBAP.ar(4,
				SinOsc.ar(pitch1,mul:amp1*env_mag,phase:env_phase),
~b.bufnum,
sphere1.theta.raddeg,sphere1.phi.raddeg
//Osc.ar(~t.bufnum,envp,phase:sphere1.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
//Osc.ar(~t.bufnum,envp,phase:sphere1.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

osc2=VBAP.ar(4,
						SinOsc.ar(pitch2,mul:amp2*env_mag,phase:env_phase),
~b.bufnum,
sphere2.theta.raddeg,sphere2.phi.raddeg
//Osc.ar(~t.bufnum,envp,phase:sphere2.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
//Osc.ar(~t.bufnum,envp,phase:sphere2.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

osc3=VBAP.ar(4,
						SinOsc.ar(pitch3,mul:amp3*env_mag,phase:env_phase),
~b.bufnum,
sphere3.theta.raddeg,sphere3.phi.raddeg
//Osc.ar(~t.bufnum,envp,phase:sphere3.theta.linlin(pi.neg,pi,2pi.neg,2pi),mul:180),
//Osc.ar(~t.bufnum,envp,phase:sphere3.phi.linlin((pi/2).neg,(pi/2),2pi.neg,2pi),mul:90)
		);

	//wrappedOut3.value(out1,LeakDC.ar(osc3,mul:env));
					Out.ar(0,LeakDC.ar(osc3,mul:env));

	//	wrappedOut2.value(out1,LeakDC.ar(osc2,mul:env));
					Out.ar(0,LeakDC.ar(osc2,mul:env));

		//wrappedOut1.value(out1,LeakDC.ar(osc1,mul:env));
					Out.ar(0,LeakDC.ar(osc1,mul:env));
							//	m=m+1;
					//pl1=pl1+1;

}).add;
);

////////////list
	({
		var n=1.neg;
		~list1=(720*~time).collect{
		n=n+1;
		}
		}.value
	);

	({
		var n=0;
		~list2=(45*~time).collect{
		n=n+1;
		}
		}.value
	);

//////////pattern for mobius strib of sequential or parallel play of directions
(
~aa=Pdef(\1, Pbind(\instrument, \ospace1,
	\dur,Pseq(~dur,1),
			\pl1,Pseq(~list1,inf),
		\out1,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
		//	\out2,Pn(Pshuf([0, 1, 2, 3, 4, 5], 1), inf).clump(6).collect([_]),
		//	\out3,Pn(Pshuf([0, 1, 2, 3, 4, 5], 1), inf).clump(6).collect([_]),
			\mult,Prand([12],inf),
			\gate,Pseq([1,0,1,1,0,1,0,1,1,0,1,1,1,0],inf),///l system
			\octav,Prand(~list2,inf),
		\xr,Pbrown(0,1,0.1,inf),
		\yr,Pbrown(0,1,0.1,inf),
		\zr,Pbrown(0,1,0.1,inf),
	\angle_rot1,Prand(~angle1,inf),
	\angle_rot2,Prand(~angle1,inf),
	\angle_rot3,Prand(~angle1,inf),
	\angle_rot4,Prand(~angle1,inf),
	\angle_rot5,Prand(~angle1,inf),
));
	);
	TempoClock.default.tempo_(32/1);

//s.record(numChannels:4);
	/////////////////////scales
//Scale.directory;

		//	s.record(numChannels:4);

	(
Tdef.new(\h,{
//loop({
			(1).wait;
//s.record(numChannels:4);
			(1).wait;
		//	s.record(numChannels:4);
~aa.play;
s.record(numChannels:4);
			(1).wait;
//s.stopRecording
//	})
})
);



//Tdef(\h).stop;
//Tdef(\h).play;
//Tdef(\h).clear;

}
)
