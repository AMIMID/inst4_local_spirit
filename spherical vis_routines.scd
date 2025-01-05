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
	sph1=Spherical(1,(az1.degrad),(el1.degrad).theta.round(0.00001);
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
	sph2=Spherical(1,(az2.degrad),(el2.degrad)).phi.round(0.00001);
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
	sph3=Spherical(1,(az3.degrad),(el3.degrad));	 mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

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
	sph4=Spherical(1,(az4.degrad),(el4.degrad));
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
		sph5=Spherical(1,(az5.degrad),(el5.degrad));

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




////////////////////////////////////////////static visualizer (rotated fixed pitches via golden ratio quaternion)
	xyz=Spherical(1,sphere.theta,sphere.phi);


v=Quaternion(0, xyz.x, xyz.y, xyz.z);

rotatio1=((axis*exp(Complex(0,1)*angle.degrad).imag)+exp(Complex(0,1)*angle.degrad).real);
v1=rotatio1*sph1_v1*rotatio1.conjugate;


(
{
var  sph1,sph2,sph3,sph4,sph5,m_x=2,m_y=1,m_z=3;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;
var angle1=0,angle2=0,angle3=0,angle4=0,angle5=0;
var azimuth,elevation,magnitudex,magnitudey,magnitudez;


~az=[0];~el=[0];~magx=[0];~magy=[0];~magz=[0];

		360.do{
azimuth=(12).collect{

		/*az1 = (az1 + 3);  // Increment azimuth
        if (az1 > 180) { az1 = az1 - 360 };  // Wrap to [-180, 180)
        if (az1 <= -180) { az1 = az1 + 360 };  // Wrap to [-180, 180)

        el1 = (el1 + 3);  // Increment elevation
        if (el1 > 90) { el1 = el1 - 180 };  // Wrap to [-90, 90)
        if (el1 <= -90) { el1 = el1 + 180 };  // Wrap to [-90, 90)*/


		az1 = angle1+(360*2.pow(pl1/12)).wrap(180.neg,180);  // Increment azimuth
		el1 = (360*2.pow(pl1/12)).wrap(90.neg,90);
		pl1=(pl1+1).mod(12);

		sph1=Spherical(1,(az1.degrad),(el1.degrad)).theta.round(0.00001);

	};angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);~az=~az++azimuth};

 360.do{
elevation=(12).collect{

		/*	az2 = (az2 + 3);  // Increment azimuth
        if (az2 > 180) { az2 = az2 - 360 };  // Wrap to [-180, 180)
        if (az2 <= -180) { az2 = az2 + 360 };  // Wrap to [-180, 180)

        el2 = (el2 + 3);  // Increment elevation
        if (el2 > 90) { el2 = el2 - 180 };  // Wrap to [-90, 90)
        if (el2 <= -90) { el2 = el2 + 180 };  // Wrap to [-90, 90)*/

		az2 = angle2+(360*2.pow(pl2/12)).wrap(180.neg,180);  // Increment azimuth
		el2 = (360*2.pow(pl2/12)).wrap(90.neg,90);
		pl2=(pl2+1).mod(12);

		sph2=Spherical(1,(az2.degrad),(el2.degrad)).phi.round(0.00001);

	};angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);~el=~el++elevation};

 360.do{
magnitudex=(12).collect{
		/*az3 = (az3 + 3);  // Increment azimuth
        if (az3 > 180) { az3 = az3 - 360 };  // Wrap to [-180, 180)
        if (az3 <= -180) { az3 = az3 + 360 };  // Wrap to [-180, 180)

        el3 = (el3 + 3);  // Increment elevation
        if (el3 > 90) { el3 = el3 - 180 };  // Wrap to [-90, 90)
        if (el3 <= -90) { el3 = el3 + 180 };  // Wrap to [-90, 90)*/

		az3 = angle3+(360*2.pow(pl3/12)).wrap(180.neg,180);  // Increment azimuth
		el3 = (360*2.pow(pl3/12)).wrap(90.neg,90);
		pl3=(pl3+1).mod(12);

	sph3=Spherical(1,(az3.degrad),(el3.degrad));
	 mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

		/* mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
			cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
		 	2).neg,(pi/2)))).rho*
		 Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;*/

};angle3=(angle3+(360-(360/1.6180339887499))).wrap(0,360);~magx=~magx++magnitudex};

 360.do{
magnitudey=(12).collect{
		/*az4 = (az4 + 3);  // Increment azimuth
        if (az4 > 180) { az4 = az4 - 360 };  // Wrap to [-180, 180)
        if (az4 <= -180) { az4 = az4 + 360 };  // Wrap to [-180, 180)

        el4 = (el4 + 3);  // Increment elevation
        if (el4 > 90) { el4 = el4 - 180 };  // Wrap to [-90, 90)
        if (el4 <= -90) { el4 = el4 + 180 };  // Wrap to [-90, 90)
*/

		az4 = angle4+(360*2.pow(pl4/12)).wrap(180.neg,180);  // Increment azimuth
		el4 = (360*2.pow(pl4/12)).wrap(90.neg,90);
		pl4=(pl4+1).mod(12);

	sph4=Spherical(1,(az4.degrad),(el4.degrad));

	mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph4.rho;
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
};angle4=(angle4+(360-(360/1.6180339887499))).wrap(0,360);~magy=~magy++magnitudey};

 360.do{
magnitudez=(12).collect{
		/*az5 = (az5 + 3);  // Increment azimuth
        if (az5 > 180) { az5 = az5 - 360 };  // Wrap to [-180, 180)
        if (az5 <= -180) { az5 = az5 + 360 };  // Wrap to [-180, 180)

        el5 = (el5 + 3);  // Increment elevation
        if (el5 > 90) { el5 = el5 - 180 };  // Wrap to [-90, 90)
        if (el5 <= -90) { el5 = el5 + 180 };  // Wrap to [-90, 90)*/

		az5 = angle5+(360*2.pow(pl5/12)).wrap(180.neg,180);  // Increment azimuth
		el5 = (360*2.pow(pl5/12)).wrap(90.neg,90);
		pl5=(pl5+1).mod(12);

		sph5=Spherical(1,(az5.degrad),(el5.degrad));

if(
m_z.even,
mag_z=Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho,
mag_z=Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
};angle5=(angle5+(360-(360/1.6180339887499))).wrap(0,360);~magz=~magz++magnitudez};
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
var az=0,el=0,az_rot;
var m=600,sph,az1,el1,pl=0,daz,del,harm,mag,r=1.neg;
var r1,harm1,r2,harm2,rad,call;


data=(360*12).collect{

	az=~az.[pl].round(0.000001);
	el=~el.[pl].round(0.000001);
	//mag=~magz.[pl];
	mag=Cartesian(~magx.[pl].round(0.000001),~magy.[pl].round(0.000001),~magz.[pl].round(0.000001)).rho/(2.sqrt);
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

data = (360*12).collect{

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
///////////////////////////////////////////rotation via quaternion

	xyz=Spherical(1,sphere.theta,sphere.phi);


v=Quaternion(0, xyz.x, xyz.y, xyz.z);

rotatio1=((axis*exp(Complex(0,1)*angle.degrad).imag)+exp(Complex(0,1)*angle.degrad).real);
v1=rotatio1*v1*rotatio1.conjugate;

(
{
var  sph1,sph2,sph3,sph4,sph5,m_x=2,m_y=1,m_z=3;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;
var angle1=0,angle2=0,angle3=0,angle4=0,angle5=0;
var azimuth,elevation,magnitudex,magnitudey,magnitudez;
var axis=Quaternion(0,0.57735026918963,0.57735026918963,0.57735026918963);
var angle=0
var v1,v2,v3,v4,v5,rotation1,rotation2,rotation3,rotation4,rotation5
var c1,c2,c3,c4,c5;

~az=[0];~el=[0];~magx=[0];~magy=[0];~magz=[0];

 360.do{
		sph1=Spherical(1,(az1.degrad),(el1.degrad));
		v1=Quaternion(0, sph1.x, sph1.y, sph1.z);
		rotation1=((axis*exp(Complex(0,1)*angle.degrad).imag)+exp(Complex(0,1)*angle.degrad).real);
		v1=rotatio1*v1*rotatio1.conjugate;
		az1=Cartesian(v1.b,v1.c,v1.d).theta.round(0.000001);
		el1=Cartesian(v1.b,v1.c,v1.d).phi.round(0.000001);
azimuth=(12).collect{

		/*az1 = (az1 + 3);  // Increment azimuth
        if (az1 > 180) { az1 = az1 - 360 };  // Wrap to [-180, 180)
        if (az1 <= -180) { az1 = az1 + 360 };  // Wrap to [-180, 180)

        el1 = (el1 + 3);  // Increment elevation
        if (el1 > 90) { el1 = el1 - 180 };  // Wrap to [-90, 90)
        if (el1 <= -90) { el1 = el1 + 180 };  // Wrap to [-90, 90)*/

		az1 = az1+(2pi*2.pow(pl1/12)).wrap(pi.neg,pi);  // Increment azimuth
		el1 = el1+(2pi*2.pow(pl1/12)).wrap((pi/2).neg,(pi/2));
		pl1=(pl1+1).mod(12);

		    angle=(360-(360/1.6180339887499))/2;
			c1=Spherical(1,az1,el1).theta.round(0.000001);

	}~az=~az++azimuth};

 360.do{
elevation=(12).collect{

		/*	az2 = (az2 + 3);  // Increment azimuth
        if (az2 > 180) { az2 = az2 - 360 };  // Wrap to [-180, 180)
        if (az2 <= -180) { az2 = az2 + 360 };  // Wrap to [-180, 180)

        el2 = (el2 + 3);  // Increment elevation
        if (el2 > 90) { el2 = el2 - 180 };  // Wrap to [-90, 90)
        if (el2 <= -90) { el2 = el2 + 180 };  // Wrap to [-90, 90)*/

		sph2=Spherical(1,(az1.degrad),(el1.degrad));
		v2=Quaternion(0, sph2.x, sph2.y, sph2.z);
		rotation2=((axis*exp(Complex(0,1)*angle.degrad).imag)+exp(Complex(0,1)*angle.degrad).real);
		v2=rotation2*v2*rotation2.conjugate;
		az2=Cartesian(v2.b,v2.c,v2.d).theta.round(0.000001);
		el2=Cartesian(v2.b,v2.c,v2.d).phi.round(0.000001);

		az2 = az2+(2pi*2.pow(pl1/12)).wrap(pi.neg,pi);  // Increment azimuth
		el2 = el2+(2pi*2.pow(pl1/12)).wrap((pi/2).neg,(pi/2));
		pl2=(pl2+1).mod(12);

		 angle=(360-(360/1.6180339887499))/2;
			c2=Spherical(1,az2,el2).theta.round(0.000001);


	};angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);~el=~el++elevation};

 360.do{
magnitudex=(12).collect{
		/*az3 = (az3 + 3);  // Increment azimuth
        if (az3 > 180) { az3 = az3 - 360 };  // Wrap to [-180, 180)
        if (az3 <= -180) { az3 = az3 + 360 };  // Wrap to [-180, 180)

        el3 = (el3 + 3);  // Increment elevation
        if (el3 > 90) { el3 = el3 - 180 };  // Wrap to [-90, 90)
        if (el3 <= -90) { el3 = el3 + 180 };  // Wrap to [-90, 90)*/

		az3 = angle3+(2pi*2.pow(pl1/12)).wrap(pi.neg,pi);  // Increment azimuth
		el3 =(2pi*2.pow(pl1/12)).wrap((pi/2).neg,(pi/2));
		pl3=(pl3+1).mod(12);

	sph3=Spherical(1,(az3.degrad),(el3.degrad));
	 mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;

////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

		/* mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
			cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
		 	2).neg,(pi/2)))).rho*
		 Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;*/

};angle3=(angle3+(360-(360/1.6180339887499))).wrap(0,360);~magx=~magx++magnitudex};

 360.do{
magnitudey=(12).collect{
		/*az4 = (az4 + 3);  // Increment azimuth
        if (az4 > 180) { az4 = az4 - 360 };  // Wrap to [-180, 180)
        if (az4 <= -180) { az4 = az4 + 360 };  // Wrap to [-180, 180)

        el4 = (el4 + 3);  // Increment elevation
        if (el4 > 90) { el4 = el4 - 180 };  // Wrap to [-90, 90)
        if (el4 <= -90) { el4 = el4 + 180 };  // Wrap to [-90, 90)
*/

		az4 = angle4+(2pi*2.pow(pl1/12)).wrap(pi.neg,pi);   // Increment azimuth
		el4 = (2pi*2.pow(pl1/12)).wrap((pi/2).neg,(pi/2));
		pl4=(pl4+1).mod(12);

	sph4=Spherical(1,(az4.degrad),(el4.degrad));

	mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph4.rho;
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
};angle4=(angle4+(360-(360/1.6180339887499))).wrap(0,360);~magy=~magy++magnitudey};

 360.do{
magnitudez=(12).collect{
		/*az5 = (az5 + 3);  // Increment azimuth
        if (az5 > 180) { az5 = az5 - 360 };  // Wrap to [-180, 180)
        if (az5 <= -180) { az5 = az5 + 360 };  // Wrap to [-180, 180)

        el5 = (el5 + 3);  // Increment elevation
        if (el5 > 90) { el5 = el5 - 180 };  // Wrap to [-90, 90)
        if (el5 <= -90) { el5 = el5 + 180 };  // Wrap to [-90, 90)*/

		az5 = angle5+(2pi*2.pow(pl1/12)).wrap(pi.neg,pi);   // Increment azimuth
		el5 = (2pi*2.pow(pl1/12)).wrap((pi/2).neg,(pi/2));
		pl5=(pl5+1).mod(12);

		sph5=Spherical(1,(az5.degrad),(el5.degrad));

if(
m_z.even,
mag_z=Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho,
mag_z=Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
};angle5=(angle5+(360-(360/1.6180339887499))).wrap(0,360);~magz=~magz++magnitudez};
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
var az=0,el=0,az_rot;
var m=600,sph,az1,el1,pl=0,daz,del,harm,mag,r=1.neg;
var r1,harm1,r2,harm2,rad,call;


data=(360*12).collect{

	az=~az.[pl].round(0.000001);
	el=~el.[pl].round(0.000001);
	//mag=~magz.[pl];
	mag=Cartesian(~magx.[pl].round(0.000001),~magy.[pl].round(0.000001),~magz.[pl].round(0.000001)).rho/(2.sqrt);
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

data = (360*12).collect{

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
