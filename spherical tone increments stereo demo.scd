(
~controlBus1 = Bus.control(s, 1);
~controlBus2 = Bus.control(s, 1);
)
180*2.pow(1/12)
(

 // Initialize angle
var angle = 0, value1, value2,tone1,tone2,mult=2,n=0;
~tempo=1;
~angleRoutine = Routine({
    loop {
        // Calculate the next angle
		//angle = (angle + (45*(2.pow(1/12)-1))).wrap(0, 360);
		//angle=(angle+45);
	//	angle=(angle+3).wrap(0,360);

		//angle = (angle + 9);  // Increment azimuth
       // if (angle > 360) { angle = angle - 360 };
		angle = (pi/2)*2.pow(n/12);  // Increment azimuth
		n=(n+1).mod(25);


		//angle= (2.pow(n/12)).wrap(0,360);
		//n=(n+1).postln;
		//"angle".postln;
		angle.postln;
	//angle = (angle + 1).wrap(0, 360);
       // angle.yield; // Yield the value to the routine
		value1=exp(Complex(0,1)*angle).imag.abs.linlin(0,1,1,4);
		value2=exp(Complex(0,1)*angle).real.abs.linlin(0,1,1,4);
		"tone1".postln;
		value1.postln;
		"tone2".postln;
	   value2.postln;
		~controlBus1.set(value1);
		~controlBus2.set(value2);
		~tempo.wait;
    }
});
)

//) Start the routine and get values
~angleRoutine.play; // Get the first 10 values

(
~angleRoutine.play;
{
		Out.ar(0,SinOsc.ar(220*In.kr(~controlBus1),mul:In.kr(~controlBus1).reciprocal));
	    Out.ar(1,SinOsc.ar(220*In.kr(~controlBus2),mul:In.kr(~controlBus2).reciprocal));
}
.play
)
