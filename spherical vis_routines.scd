(
~controlBus_az = Bus.control(s, 1);
~controlBus_el = Bus.control(s, 1);
~controlBus_magx = Bus.control(s, 1);
~controlBus_magy = Bus.control(s, 1);
~controlBus_magz = Bus.control(s, 1);
)
(
var  sph1,sph2,sph3,sph4,sph5,m_x=2,m_y=2,m_z=2;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;
var angle = 0;

~tempoaz=0.1;
~tempoel=0.1;
~tempox=0.1;
~tempoy=0.1;
~tempoz=0.1;


~az =  Routine({
		loop{
		az1=(az1+(360-(360/1.6180339887499))).wrap(180.neg,180);
	el1=(el1+(1)).wrap(90.neg,90);
	sph1=Spherical(1,(az1.degrad).wrap(pi.neg,pi),(el1.degrad).wrap((pi/2).neg,(pi/2))).theta.round(0.00001);
	//	"az".postln;
	//	sph1.postln;
		~controlBus_az.set(sph1);
	pl1=pl1+1;
	~tempoaz.wait;
}});

~el = Routine({
		loop{
		az2=(az2+(360-(360/1.6180339887499))).wrap(180.neg,180);
	el2=(el2+(1)).wrap(90.neg,90);
	sph2=Spherical(1,(az2.degrad).wrap(pi.neg,pi),(el2.degrad).wrap((pi/2).neg,(pi/2))).phi.round(0.00001);
		//	"el".postln;
	//	sph2.postln;
		~controlBus_el.set(sph2);
		pl2=pl2+1;
		~tempoel.wait;
}});

~magx = Routine({
		loop{
	az3=(az3+(360-(360/1.6180339887499))).wrap(180.neg,180);
	el3=(el3+(1)).wrap(90.neg,90);
	sph3=Spherical(1,(az3.degrad).wrap(pi.neg,pi),(el3.degrad).wrap((pi/2).neg,(pi/2)));	 mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

		/* mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
			cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
		 	2).neg,(pi/2)))).rho*
		 Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;*/
		mag_x=mag_x/(2.sqrt);
	//			"magx".postln;
	//	mag_x.postln;
		~controlBus_magx.set(mag_x);
		pl3=pl3+1;
		~tempox.wait;
}});

~magy = Routine({
		loop{
	az4=(az4+(360-(360/1.6180339887499))).wrap(180.neg,180);
	el4=(el4+(1)).wrap(90.neg,90);
	sph4=Spherical(1,(az4.degrad).wrap(pi.neg,pi),(el4.degrad).wrap((pi/2).neg,(pi/2)));
	mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph4.rho;
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
		mag_y=mag_y/(2.sqrt);
		//		"magy".postln;
	//	mag_y.postln;
		~controlBus_magy.set(mag_y);
			pl4=pl4+1;
		~tempoy.wait;
}});

~magz = Routine({
		loop{
pl5=pl5+1;
	az5=(az5+(360-(360/1.6180339887499))).wrap(180.neg,180);
	el5=(el5+(1)).wrap(90.neg,90);
		sph5=Spherical(1,(az5.degrad).wrap(pi.neg,pi),(el5.degrad).wrap((pi/2).neg,(pi/2)));

if(
m_z.even,
mag_z=Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho,
mag_z=Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho
	);
		mag_z=mag_z/(2.sqrt);
	//			"magz".postln;
	//	mag_z.postln;
		~controlBus_magz.set(mag_z);
				pl5=pl5+1;
		~tempoz.wait;
}});

)

(
~az.play;
~el.play;
~magx.play;
~magy.play;
~magz.play;
);

(
var data;
var az=0,el=0;
var m=600,sph,mag;
var run = true;
 var magX, magY ,magZ;
var generateData;
var r;
var ot=0.degrad;



generateData =[[0,0,0]];

 w = Window.new("3D Scatterplot", Rect(40,40, 1000, 800)).front;

 ~v = UserView.new(w,Rect(0,0,800,800)).background_(Color.black);
 a = ScatterView3d(~v, Rect(0,0, 800,800), data, [-1000, 1000].asSpec,[-1000, 1000].asSpec,[-1000, 1000].asSpec);
 a.drawMethod = \fillRect;
 a.symbolSize = 1;
 a.symbolColor = Color.white;
 a.background = Color.black;

// Y Slider
Slider(w, Rect(820, 10, 10, 450)).action_{|me|
    a.rotY = me.value * 2pi;
    w.refresh;
};
// X Slider
Slider(w, Rect(870, 10, 10, 450)).action_{|me|
    a.rotX = me.value * 2pi;
    w.refresh;
};
// Z Slider
Slider(w, Rect(920, 10, 10, 450)).action_{|me|
    a.rotZ = me.value * 2pi;
    w.refresh;
};
  r= Routine({loop{

	      az = ~controlBus_az.getSynchronous;    // Read from control buses
         el =  ~controlBus_el.getSynchronous;
mag=Cartesian(~controlBus_magx.getSynchronous, ~controlBus_magy.getSynchronous,~controlBus_magz.getSynchronous).rho/(2.sqrt);

	generateData =generateData++[ Spherical(mag*600,az,el).asCartesian.asArray];
	data = generateData.value; // Regenerate data
	data.postln;
 	a.data = data;            // Update ScatterView3d
0.1.wait
}});
r.play;

 ~v.animate;
 ~v.drawFunc ={
 	Pen.translate(400,400);
          // Update ScatterView3d
		a.rot(ot,ot,ot);
    ~v.refresh;

		ot=ot+1.degrad;
 };
 { while { run } {~v.refresh; (0.1).wait } }.fork(AppClock);

)




////////////////////////////////////////////static visualizer
(
{
var  sph1,sph2,sph3,sph4,sph5,m_x=2,m_y=2,m_z=3;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=1.neg,pl2=1.neg,pl3=1.neg,pl4=1.neg,pl5=1.neg;

~az = (360*100).collect{
	pl1=pl1+1;

		az1=(az1+(2.pow(pl1/12))).wrap(180.neg,180);
		//az1=(az1 + (45*(2.pow(1/12)-1))).wrap(180.neg,180);

	el1=(el1+((2.pow(pl1/12)))).wrap(90.neg,90);
		//el1=(el1 + (45*(2.pow(1/12)-1))).wrap(90.neg,90);

		sph1=Spherical(1,(az1.degrad).wrap(pi.neg,pi),(el1.degrad).wrap((pi/2).neg,(pi/2))).theta.round(0.00001);

	};

~el = (360*100).collect{
	pl2=pl2+1;

		az2=(az2+(2.pow(pl2/12))).wrap(180.neg,180);
		//az2=(az2 + (45*(2.pow(1/12)-1))).wrap(180.neg,180);

	el2=(el2+((2.pow(pl2/12)))).wrap(90.neg,90);
		//el2=(el2 + (45*(2.pow(1/12)-1))).wrap(90.neg,90);

	sph2=Spherical(1,(az2.degrad).wrap(pi.neg,pi),(el2.degrad).wrap((pi/2).neg,(pi/2))).phi.round(0.00001);

	};

~magx = (360*100).collect{
pl3=pl3+1;
	az3=(az3+(2.pow(pl3/12))).wrap(180.neg,180);
		//az3=(az3 + (45*(2.pow(1/12)-1))).wrap(180.neg,180);

	el3=(el3+((2.pow(pl3/12)))).wrap(90.neg,90);
	//	el3=(el3 + (45*(2.pow(1/12)-1))).wrap(90.neg,90);

	sph3=Spherical(1,(az3.degrad).wrap(pi.neg,pi),(el3.degrad).wrap((pi/2).neg,(pi/2)));
	 mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

		/* mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
			cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
		 	2).neg,(pi/2)))).rho*
		 Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;*/

};

~magy = (360*100).collect{
pl4=pl4+1;
	az4=(az4+(2.pow(pl4/12))).wrap(180.neg,180);
		//az4=(az4 + (45*(2.pow(1/12)-1))).wrap(180.neg,180);

	el4=(el4+((2.pow(pl4/12)))).wrap(90.neg,90);
	//	el4=(el4 + (45*(2.pow(1/12)-1))).wrap(90.neg,90);

	sph4=Spherical(1,(az4.degrad).wrap(pi.neg,pi),(el4.degrad).wrap((pi/2).neg,(pi/2)));

	mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph4.rho;
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
};

~magz = (360*100).collect{
pl5=pl5+1;
	az5=(az5+((2.pow(pl5/12)))).wrap(180.neg,180);
	//az5=(az5 + (45*(2.pow(1/12)-1))).wrap(180.neg,180);

	el5=(el5+((2.pow(pl5/12)))).wrap(90.neg,90);
		//el5=(el5 + (45*(2.pow(1/12)-1))).wrap(90.neg,90);

		sph5=Spherical(1,(az5.degrad).wrap(pi.neg,pi),(el5.degrad).wrap((pi/2).neg,(pi/2)));

if(
m_z.even,
mag_z=Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho,
mag_z=Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
	};
}.value;
(
~magx=~magx/(2.sqrt);
~magy=~magy/(2.sqrt);
~magz=~magz/(2.sqrt);
 );
)

/////////////////////////////////visualizer
(
var data;
var az=0,el=0;
var m=600,sph,az1,el1,pl=0,daz,del,harm,mag,r;
var r1,harm1,r2,harm2,rad;

data = (360*64).collect{

	az=~az.[pl];
	el=~el.[pl];
	//mag=~magz.[pl];
	mag=Cartesian(~magx.[pl],~magy.[pl],~magz.[pl]).rho/(2.sqrt);
	pl=pl+1;

	sph=Spherical(mag*600,az,el).asCartesian.asArray;


};
data.postln;

w = Window.new("3D Scatterplot", Rect(40,40, 1000, 800)).front;
a = ScatterView3d(w, Rect(0,0, 800,800), data, [-1000, 1000].asSpec,[-1000, 1000].asSpec,[-1000, 1000].asSpec);
a.drawMethod = \fillRect;
a.symbolSize = 1;
a.symbolColor = Color.white;
a.background = Color.black;

// Y Slider
Slider(w, Rect(820, 10, 10, 450)).action_{|me|
    a.rotY = me.value * 2pi;
    w.refresh;
};
// X Slider
Slider(w, Rect(870, 10, 10, 450)).action_{|me|
    a.rotX = me.value * 2pi;
    w.refresh;
};
// Z Slider
Slider(w, Rect(920, 10, 10, 450)).action_{|me|
    a.rotZ = me.value * 2pi;
    w.refresh;
};
)





//////////////////////////////////////////////////////////////////////animation

(
var data;
var az=0,el=0;
var m=600,sph,az1,el1,pl=0,daz,del,harm,mag,r;
var r1,harm1,r2,harm2,rad;
var run = true;
var ot=0.degrad;

data = (360*16).collect{

	az=~az.[pl];
	el=~el.[pl];
	//mag=~magz.[pl];
	mag=Cartesian(~magx.[pl],~magy.[pl],~magz.[pl]).rho/(2.sqrt);
	pl=pl+1;

	sph=Spherical(mag*600,az,el).asCartesian.asArray;


};

w = Window.new("3D Scatterplot", Rect(40,40, 800, 800)).front;

~v = UserView.new(w,Rect(0,0,800,800)).background_(Color.black);
a = ScatterView3d(~v, Rect(0,0, 800,800), data, [-1000, 1000].asSpec,[-1000, 1000].asSpec,[-1000, 1000].asSpec);
a.drawMethod = \fillRect;
a.symbolSize = 1;
a.symbolColor = Color.white;
a.background = Color.black;

~v.animate;
~v.drawFunc ={
Pen.translate(400,400);

		a.rot(ot,ot,ot);
    ~v.refresh;

		ot=ot+1.degrad;

};
{ while { run } {~v.background_(Color.black); ~v.refresh; (1/1000).wait } }.fork(AppClock);

)
/////////////disorder
