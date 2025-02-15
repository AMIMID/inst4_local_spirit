
(
{
var  sph1,sph2,sph3,sph4,sph5,m_x=2,m_y=1,m_z=3;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0,spha,sphb,sphc,sphd,sphe;
var angle=0,sph;
var  seed1 = 123,seed2=123,seed3=123,seed4=123,seed5=123,seed=123;
var azimuth,elevation,magnitudex,magnitudey,magnitudez,magg;
	var xyz1,xyz2,xyz3,xyz4,xyz5;



	~az=[];~el=[];~magx=[];~magy=[];~magz=[];~mag=[];
360.do{

azimuth=(13).collect{
thisThread.randSeed = seed1;
			seed1=seed1+1;

		xyz1=[2.pow(12.rand2/12),2.pow(12.rand2/12),2.pow(12.rand2/12)].normalizeSum.sqrt;

		spha=Cartesian(xyz1.[0]*([1.neg,1].choose),xyz1.[1]*([1.neg,1].choose),xyz1.[2]*([1.neg,1].choose));
			az1=(angle.degrad+spha.theta).wrap(pi.neg,pi);
			el1=(angle.degrad+spha.phi).wrap((pi/2).neg,(pi/2));
		sph1=Spherical(1,(az1),(el1)).theta.round(0.00001);
	};

elevation=(13).collect{
thisThread.randSeed = seed2;

			seed2=seed2+1;

			xyz2=[2.pow(12.rand2/12),2.pow(12.rand2/12),2.pow(12.rand2/12)].normalizeSum.sqrt;

		sphb=Cartesian(xyz2.[0]*([1.neg,1].choose),xyz2.[1]*([1.neg,1].choose),xyz2.[2]*([1.neg,1].choose));
az2=(angle.degrad+sphb.theta).wrap(pi.neg,pi);
			el2=(angle.degrad+sphb.phi).wrap((pi/2).neg,(pi/2));
		sph2=Spherical(1,(az2),(el2)).phi.round(0.00001);

	};

magnitudex=(13).collect{
thisThread.randSeed = seed3;

			seed3=seed3+1;

			xyz3=[2.pow(12.rand2/12),2.pow(12.rand2/12),2.pow(12.rand2/12)].normalizeSum.sqrt;

		sphc=Cartesian(xyz3.[0]*([1.neg,1].choose),xyz3.[1]*([1.neg,1].choose),xyz3.[2]*([1.neg,1].choose));
			az3=(angle.degrad+sphc.theta).wrap(pi.neg,pi);
			el3=(angle.degrad+sphc.phi).wrap((pi/2).neg,(pi/2));
		sph3=Spherical(1,(az3),(el3));

	 /*mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;
*/
////for in-between harmonics multiply sin(phi) after cos, when m is 2 then harm 3/2 is formed in oder 3, when m is 3 harm 4/3 is formed in oder 4 and when m is 3 for theta and 2 for phi harm 4/2 is formed for order4//////same for y axis

		mag_x=(Complex(cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi)),
			cos((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).rho*
		 	Complex(sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2))),sin((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/
		 	2).neg,(pi/2)))).rho*
		 Complex(cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph3.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph3.rho;
};

magnitudey=(13).collect{
					thisThread.randSeed = seed4;

			seed4=seed4+1;

			xyz4=[2.pow(12.rand2/12),2.pow(12.rand2/12),2.pow(12.rand2/12)].normalizeSum.sqrt;

		sphd=Cartesian(xyz4.[0]*([1.neg,1].choose),xyz4.[1]*([1.neg,1].choose),xyz4.[2]*([1.neg,1].choose));
			az4=(angle.degrad+sphd.theta).wrap(pi.neg,pi);
			el4=(angle.degrad+sphd.phi).wrap((pi/2).neg,(pi/2));
	sph4=Spherical(1,(az4),(el4));

	mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),
		sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
		Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/
		2)))).rho)*sph4.rho;
//		mag_y=(Complex(sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi)),sin((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).rho*
//Complex(sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2))),sin((sph4.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).rho*
//Complex(cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2))),cos((sph4.phi.round(0.00001)).wrap((pi/2).neg,(pi/2)))).rho)*sph4.rho;
};

magnitudez=(13).collect{
					thisThread.randSeed = seed5;

			seed5=seed5+1;

			xyz5=[2.pow(12.rand2/12),2.pow(12.rand2/12),2.pow(12.rand2/12)].normalizeSum.sqrt;

		sphe=Cartesian(xyz5.[0]*([1.neg,1].choose),xyz5.[1]*([1.neg,1].choose),xyz5.[2]*([1.neg,1].choose));
			az5=(angle.degrad+sphe.theta).wrap(pi.neg,pi);
			el5=(angle.degrad+sphe.phi).wrap((pi/2).neg,(pi/2));
	sph5=Spherical(1,(az5),(el5));
if(
m_z.even,
mag_z=Complex(cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),cos((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho,
mag_z=Complex(sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2))),sin((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
};angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);~az=~az++azimuth;~el=~el++elevation;~magx=~magx++magnitudex;~magy=~magy++magnitudey;~magz=~magz++magnitudez;~mag=~mag++mag};
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


data=(360*13).collect{

	az=~az.[pl].round(0.000001);
	el=~el.[pl].round(0.000001);
	//mag=~magz.[pl];
	//mag=Cartesian(~magx.[pl],~magy.[pl],~magz.[pl]).rho/(2.sqrt);
	pl=pl+1;
		sph=Spherical(1*600,az,el).asCartesian.asArray;
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

data = (360*13).collect{

	az=~az.[pl];
	el=~el.[pl];
	//mag=~magz.[pl];
	mag=Cartesian(~magx.[pl],~magy.[pl],~magz.[pl]).rho/(2.sqrt);
	pl=pl+1;

	sph=Spherical(1*600,az,el).asCartesian.asArray;


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