(
Tdef(\track1, {

	"::::p1".postln;
	Ndef(\roof).set(\x, 0.1, \y, 0.5, \amp, 0.1).play;

	Pdef(\kick,
		Pbind(\instrument, \kick,
			\dur, Pseq(1/(4,6..24), inf),
			\isRest, Pseq([1, 1, 1, 1, 1, 1, 1, 1], inf).coin.not,
			\amp, Pseq([0.4], inf),
		)
	).play;

	Pdef(\snare,
		Pbind(\instrument, \noise,
			\dur, Pseq([1/3], inf),
			\amp, Pseq([0.4], inf),
		)
	).play;


	Ndef(\p1).set(\freq, 4000, \detune,0, \f0,6.5, \f1,2.7, \w0, 0.9, \phasing,0, \legato,0.1, \amp,0.1).play(0,2);
	4.wait;

	"::::p2".postln;
	Pdef(\kick).stop;
	Ndef(\roof).set(\x, 0.1, \y, 0.5, \amp, ~b1.asMap).play;
	4.wait;

	"::::p3".postln;
	Pdef(\kick).stop;
	Ndef(\lfo, {LFTri.ar(50,mul:0.5, add:0.5)}).play(0,4);
	4.wait;

	Ndef(\p1).set(\freq, 4000, \detune,0, \f0,6.5, \f1,2.7, \w0, 0.9, \phasing,0, \legato,0.1, \amp,0.1).play(0,2);
	Ndef(\lfo, {LFTri.ar(30,mul:0.5, add:0.5)}).play(0,4);
	4.wait;


	"::::p4".postln;
	Ndef(\roof).set(\x, 0.1, \y, 0.5, \amp, ~b1.asMap).play;
	Ndef(\lfo).stop();
	Pdef(\kick).play;
	4.wait;



	Ndef(\p1).set(\freq, 2000, \detune,0, \f0,6.5, \f1,2.7, \w0, 0.1, \phasing,0, \legato,0.1, \amp,0.1).play(0,2);
	Ndef(\roof).set(\x, 0.1, \y, 0.5, \amp, ~b1.asMap).play;
	Ndef(\roof).map(\x, Ndef(\lfo));
	Ndef(\lfo, {LFTri.ar(50,mul:0.5, add:0.5)}).play(0,4);
	4.wait;

	Ndef(\lfo, {LFTri.ar(30,mul:0.9, add:0.5)}).play(4,4);
	Ndef(\p1).set(\freq, 4000, \detune,0, \f0,6.5, \f1,2.7, \w0, 0.9, \phasing,0, \legato,0.1, \amp,0.1).play(0,2);
	Ndef(\roof).set(\x, 0.1, \y, 0.5, \amp, ~b1.asMap).play;
	4.wait;


	Ndef(\p1).set(\freq, 2000, \detune,0, \f0,6.5, \f1,2.7, \w0, 0.1, \phasing,0, \legato,0.1, \amp,0.1).play(0,2);
	Ndef(\roof).set(\x, 0.1, \y, 0.5, \amp, ~b1.asMap).play;
	Ndef(\roof).map(\x, Ndef(\lfo));
	Ndef(\lfo, {LFTri.ar(50,mul:0.5, add:0.5)}).play(0,4);
	4.wait;


	Ndef(\lfo, {LFTri.ar(30,mul:0.9, add:0.5)}).play(4,4);
	Ndef(\p1).set(\freq, 4000, \detune,0, \f0,6.5, \f1,2.7, \w0, 0.9, \phasing,0, \legato,0.1, \amp,0.1).play(0,2);
	Ndef(\roof).set(\x, 0.1, \y, 0.5, \amp, ~b1.asMap).play;
	4.wait;


	Ndef(\p1).set(\freq, 2000, \detune,0, \f0,6.5, \f1,2.7, \w0, 0.1, \phasing,0, \legato,0.1, \amp,0.1).play(0,2);
	Ndef(\roof).set(\x, 0.1, \y, 0.5, \amp, ~b1.asMap).play;
	Ndef(\roof).map(\x, Ndef(\lfo));
	Ndef(\lfo, {LFTri.ar(50,mul:0.5, add:0.5)}).play(0,4);
	4.wait;

	Ndef(\lfo, {LFTri.ar(30,mul:0.9, add:0.5)}).play(4,4);
	Ndef(\p1).set(\freq, 4000, \detune,0, \f0,6.5, \f1,2.7, \w0, 0.9, \phasing,0, \legato,0.1, \amp,0.1).play(0,2);
	Ndef(\roof).set(\x, 0.1, \y, 0.5, \amp, ~b1.asMap).play;
	4.wait;


	Ndef(\p1).set(\freq, 2000, \detune,0, \f0,6.5, \f1,2.7, \w0, 0.1, \phasing,0, \legato,0.1, \amp,0.1).play(0,2);
	Ndef(\roof).set(\x, 0.1, \y, 0.5, \amp, ~b1.asMap).play;
	Ndef(\roof).map(\x, ~b2.asMap);
	Ndef(\lfo).stop();



	4.wait


}).play;
)


