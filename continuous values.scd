({
		var angle=0;
		~angle=(720).collect{
		angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
		}
		}.value;
	)

///////////////////////////////////////////routine sending to control bus


~controlBus.free
(
~controlBus1 = Bus.control(s, 1);
~controlBus2 = Bus.control(s, 1);
)

(
 // Initialize angle
var angle = 0, value1, value2,tone1,tone2,mult=12;
~angleRoutine = Routine({
    loop {
        // Calculate the next angle
      angle = (angle + (360 - (360 / 1.6180339887499))).wrap(0, 360);
	//angle = (angle + 1).wrap(0, 360);
       // angle.yield; // Yield the value to the routine
		value1=exp(Complex(0,1)*angle.degrad).imag*mult;
		value2=exp(Complex(0,1)*angle.degrad).real*mult;
		tone1=2.pow(value1/12);
		tone2=2.pow(value2/12);
		"tone1".postln;
		tone1.postln;
		"tone2".postln;
		tone2.postln;
		~controlBus1.set(tone1);
		~controlBus2.set(tone2);
		0.1.wait;
    }
});
)

//) Start the routine and get values
~angleRoutine.play; // Get the first 10 values

(
{
		Out.ar(0,SinOsc.ar(220*In.kr(~controlBus2),mul:In.kr(~controlBus1).reciprocal));
	    Out.ar(1,SinOsc.ar(22*In.kr(~controlBus2),phase:90.degrad,mul:In.kr(~controlBus2).reciprocal));
}
.play
)


({
var n=10;
1000.do{
	Out.ar(0,SinOsc.ar((110+n),mul:In.kr(~controlBus1).reciprocal));
	Out.ar(1,SinOsc.ar((110+n),phase:90.degrad,mul:In.kr(~controlBus2).reciprocal));
	n=n+10;
}}
.play
)




/////////////////////////////////////////////

