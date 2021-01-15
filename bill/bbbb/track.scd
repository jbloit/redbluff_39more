TempoClock.tempo = 1;


(
	Pdef(\kick,
		Pbind(\instrument, \kick,
			\dur, Pseq([1], inf),
			\isRest, Pseq([1, 1, 1, 1, 1, 1, 1, 1], inf).coin.not,
			\amp, Pseq([0.8], inf),
		)
	).play;

TempoClock.sched(1, {Ndef(\p1).play});


// SynthDef(\lo, {|freq = 40, amp=0.1, modBus, out=0, modLag=0, modMul = 1|
~lo = Synth(\lo, [\freq,  50, \modBus, ~k2, \modMul, 0.4 ]);

)

~lo.set(\modMul, 0.6)
~lo.set(\freq, 30)
~lo.set(\amp, 0.7)
~lo.set(\modLag, 0);

Ndef(\p1).set(\freq, 1000, \detune,0.3, \f0,8, \f1,3, \w0,0.98, \phasing,0, \legato,0.5, \amp,0.1).play;
Ndef(\roof).set(\x, 0.1, \y, 0.5, \amp, 0.2).play;
Ndef(\roof).set(\x, 0.1, \y, 0.5, \amp, ~k1.asMap).play;
Ndef(\roof).map(\x, Ndef(\lfo));



// How to modulate lfo freq with kick?



Ndef(\lfo, {LFTri.ar(40,mul:0.5, add:0.5)}).play(0,4);

Ndef(\roof).stop
Ndef(\lfo).stop

)