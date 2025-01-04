(
~controlBus1 = Bus.control(s, 1);
~controlBus2 = Bus.control(s, 1);
~controlBus3 = Bus.control(s, 1);
~controlBus4 = Bus.control(s, 1);
)
(360-(360/1.6180339887499))
(

 // Initialize angle
var angle = 0, value1, value2,tone1,tone2,mult=2,n=0,pos1,pos2;
~tempo=0.1;
~angleRoutine = Routine({
    loop {

		angle = (pi/2)*2.pow(n/12);  // Increment azimuth
		n=(n+1).mod(25);
		angle.postln;
		value1=exp(Complex(0,1)*angle).imag.abs.linlin(0,1,1,4);
		value2=exp(Complex(0,1)*angle).real.abs.linlin(0,1,1,4);
		pos1=exp(Complex(0,1)*angle).imag;
		pos2=exp(Complex(0,1)*angle).real;
		"tone1".postln;
		value1.postln;
		"tone2".postln;
	   value2.postln;
		~controlBus1.set(value1);
		~controlBus2.set(value2);
		~controlBus3.set(pos1);
		~controlBus4.set(pos2);
		~tempo.wait;
    }
});
)

//) Start the routine and get values
~angleRoutine.play; // Get the first 10 values

(
~angleRoutine.play;
{
	Out.ar(0,Pan2.ar(SinOsc.ar(220*In.kr(~controlBus1),mul:In.kr(~controlBus1).reciprocal),pos:In.kr(~controlBus3)));
	Out.ar(0,Pan2.ar(SinOsc.ar(220*In.kr(~controlBus2),mul:In.kr(~controlBus2).reciprocal),pos:In.kr(~controlBus4)));
}
.play
)
