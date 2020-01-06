// INSPIRATION : Marco Goecke


(
SynthDef(\kick, {|out=0, amp=1|
	var sig, envFreq, env;
	envFreq = EnvGen.kr(Env([1, 0.1, 0], [0.1, 0.3], -6), doneAction:2, levelScale:380, levelBias:10);
	env = EnvGen.kr(Env([1, 1, 0], [0.1, 0.3]), levelScale:0.4);
	sig = LFPar.ar(envFreq, mul:env) ;
	Out.ar(out, Splay.ar(sig));
}).add;



~b1 = Bus.control(s, 1);
~b2 = Bus.control(s, 1);

// PULSE
Ndef(\p1, {|freq=4000, detune=0.3, f0=6.5, f1=2.7, w0=0.98, phasing=0, legato=0.5, amp=0.1|
	var sig, env, env2, trig, sig2,outSig, rel;
	trig = Pulse.ar(f0, w0);
	Out.kr(~b1, Amplitude.k<r(trig));
	rel = SinOsc.ar(f1, 0, 1, legato);
	Out.kr(~b2, Amplitude.kr(rel));
	env = EnvGen.ar(Env.adsr(releaseTime:rel), trig);
	sig = LFPar.ar(freq, mul:0.5);
	outSig = sig * env * amp;
});

// ROOF DRONE
Ndef(\roof, {|x=0.3, y=0.4, amp=0.5|
	var sig;
	a=Saw;
	amp.poll;
	x = x.linlin(0, 1, 100, 400);
	y = y.linlin(0, 1, 100, 400);
	sig = Splay.ar(Formant.ar(a.ar((5,7..15)*19)*99+x, a.ar((1,3..13)*29)*199+x, a.ar((3,5..11)*a.ar(3,2,3))*299+y))/3;
	sig * amp;
});

Ndef(\lfo, {LFTri.ar(1.2,mul:0.5, add:0.1)}).play(4,0);
)

// Cues. Try to make them stateless.

(
Ndef(\p1).set(\freq, 4000, \detune,0.3, \f0,6.5, \f1,2.7, \w0,0.98, \phasing,0, \legato,0.5, \amp,0.1).play(0,2);
Ndef(\roof).set(\x, 0.1, \y, 0.5, \amp, ~b1.asMap).play;
Ndef(\lfo, {LFTri.ar(1.2,mul:0.5, add:0.1)}).play(4,0);
)

(
Ndef(\p1).set(\freq, 4000, \detune,0.3, \f0,6.5, \f1,2.7, \w0,0.98, \phasing,0, \legato,0.5, \amp,0.1).play(0,2);
Ndef(\roof).set(\x, 0.1, \y, 0.5, \amp, ~b1.asMap).play;
Ndef(\lfo, {LFTri.ar(1.2,mul:0.5, add:0.1)}).play(4,0);
Ndef(\roof).map(\x, Ndef(\lfo));
)

(
Ndef(\p1).set(\freq, 4000, \detune,0.3, \f0,6.5, \f1,2.7, \w0,0.98, \phasing,0, \legato,0.5, \amp,0.1).play(0,2);
Ndef(\roof).set(\x, 0.1, \y, 0.5, \amp, ~b1.asMap).play;
Ndef(\roof).map(\x, Ndef(\lfo));
Ndef(\lfo, {LFTri.ar(30,mul:0.5, add:0.5)}).play(0,0);
)

(
Ndef(\p1).set(\freq, 1000, \detune,0.3, \f0,6.5, \f1,2.7, \w0,0.98, \phasing,0, \legato,0.5, \amp,0.1).play(0,2);
Ndef(\roof).set(\x, 0.1, \y, 0.5, \amp, ~b1.asMap).play;
Ndef(\roof).map(\x, Ndef(\lfo));
Ndef(\lfo, {LFTri.ar(30,mul:0.5, add:0.5)}).play(0,4);
)

(
Ndef(\p1).set(\freq, 4000, \detune,0.3, \f0,6.5, \f1,2.7, \w0, 0.8, \phasing,0, \legato,0.1, \amp,0.1).play(0,2);
Ndef(\roof).set(\x, 0.1, \y, 0.5, \amp, ~b1.asMap).play;
Ndef(\roof).map(\x, Ndef(\lfo));
Ndef(\lfo, {LFTri.ar(30,mul:0.5, add:0.5)}).play(0,4);
)

(
Ndef(\p1).set(\freq, 1000, \detune,0, \f0,6.5, \f1,2.7, \w0, 0.1, \phasing,0, \legato,0.1, \amp,0.1).play(0,2);
Ndef(\roof).set(\x, 0.1, \y, 0.5, \amp, ~b1.asMap).play;
Ndef(\roof).map(\x, Ndef(\lfo));
Ndef(\lfo, {LFTri.ar(30,mul:0.5, add:0.5)}).play(0,4);
)

(
Ndef(\lfo, {LFTri.ar(30,mul:0.9, add:0.5)}).play(4,4);
Ndef(\p1).set(\freq, 4000, \detune,0, \f0,6.5, \f1,2.7, \w0, 0.9, \phasing,0, \legato,0.1, \amp,0.1).play(0,2);
Ndef(\roof).set(\x, 0.1, \y, 0.5, \amp, ~b1.asMap).play;
)

(
Ndef(\p1).set(\freq, 2000, \detune,0, \f0,6.5, \f1,2.7, \w0, 0.1, \phasing,0, \legato,0.1, \amp,0.1).play(0,2);
Ndef(\roof).set(\x, 0.1, \y, 0.5, \amp, ~b1.asMap).play;
Ndef(\roof).map(\x, Ndef(\lfo));
Ndef(\lfo, {LFTri.ar(50,mul:0.5, add:0.5)}).play(0,4);
)

(
Ndef(\lfo, {LFTri.ar(30,mul:0.9, add:0.5)}).play(0,4);
Ndef(\p1).set(\freq, 4000, \detune,0, \f0,6.5, \f1,2.7, \w0, 0.5, \phasing,0, \legato,0.1, \amp,0.2).play(0,2);
Ndef(\roof).set(\x, 0.01, \y, 0.01, \amp, ~b1.asMap).play;
)

(
Ndef(\lfo, {LFTri.ar(30,mul:0.9, add:0.5)}).play(4,4);
Ndef(\p1).set(\freq, 1000, \detune,0, \f0,6.5, \f1, 2.7, \w0, 0.5, \phasing,0, \legato,0.3, \amp,0.2).play(0,2);
Ndef(\roof).set(\x, 0.01, \y, 0.01, \amp, ~b1.asMap).play;
)

(
Ndef(\lfo, {LFTri.ar(30,mul:0.9, add:0.5)}).play(0,4);
Ndef(\p1).set(\freq, 4000, \detune,0, \f0,6.5, \f1,2.7, \w0, 0.6, \phasing,0, \legato,0.1, \amp,0.2).play(0,2);
Ndef(\roof).set(\x, 0.01, \y, 0.01, \amp, ~b1.asMap).play;
)

(
Ndef(\lfo, {LFTri.ar(30,mul:0.9, add:0.5)}).play(4,4);
Ndef(\p1).set(\freq, 1000, \detune,0, \f0,6.5, \f1, 2.7, \w0, 0.6, \phasing,0, \legato,0.3, \amp,0.2).play(0,2);
Ndef(\roof).set(\x, 0.01, \y, 0.01, \amp, ~b1.asMap).play;
)


(
Ndef(\lfo, {LFTri.ar(30,mul:0.9, add:0.5)}).play(0,4);
Ndef(\p1).set(\freq, 4000, \detune,0, \f0,6.5, \f1,2.7, \w0, 0.7, \phasing,0, \legato,0.1, \amp,0.2).play(0,2);
Ndef(\roof).set(\x, 0.01, \y, 0.01, \amp, ~b1.asMap).play;
)

(
Ndef(\lfo, {LFTri.ar(30,mul:0.9, add:0.5)}).play(0,4);
Ndef(\p1).set(\freq,  4000, \detune,0, \f0,6.5, \f1, 3.7, \w0, 0.7, \phasing,0, \legato,0.01, \amp,0.15).play(0,2);
Ndef(\roof).set(\x, 0.4, \y, 1, \amp, 0.4).play;
)

(
Ndef(\lfo, {LFTri.ar(60,mul:0.9, add:0.5)}).play(0,4);
Ndef(\p1).set(\freq, 4000, \detune,0, \f0,6.5, \f1,2.7, \w0, 0.7, \phasing,0, \legato,0.1, \amp,0.2).play(0,2);
Ndef(\roof).set(\x, 0.01, \y, 0.01, \amp, ~b1.asMap).play;
)

(
Ndef(\lfo, {LFTri.ar(30,mul:0.9, add:0.5)}).play(0,4);
Ndef(\p1).set(\freq,  4000, \detune,0, \f0,6.5, \f1, 3.7, \w0, 0.7, \phasing,0, \legato,0.01, \amp,0.15).play(0,2);
Ndef(\roof).set(\x, 0.4, \y, 1, \amp, 0.4).play;
)


(
Ndef(\lfo, {LFTri.ar(60,mul:0.9, add:0.5)}).play(0,4);
Ndef(\p1).set(\freq, 4000, \detune,0, \f0,6.5, \f1,2.7, \w0, 0.7, \phasing,0, \legato,0.1, \amp,0.2).play(0,2);
Ndef(\roof).set(\x, 0.01, \y, 0.01, \amp, ~b1.asMap).play;
)

(
Ndef(\lfo, {LFTri.ar(30,mul:0.9, add:0.5)}).play(0,4);
Ndef(\p1).set(\freq,  4000, \detune,0, \f0,6.5, \f1, 3.7, \w0, 0.9, \phasing,0, \legato,0.01, \amp,0.15).play(0,2);
Ndef(\roof).set(\x, 0.4, \y, 1, \amp, ~b1.asMap).play;
)


(
Ndef(\lfo, {LFTri.ar(60,mul:0.9, add:0.5)}).play(0,4);
Ndef(\p1).set(\freq, 4000, \detune,0, \f0,6.5, \f1,2.7, \w0, 0.7, \phasing,0, \legato,0.1, \amp,0.2).play(0,2);
Ndef(\roof).set(\x, 0.01, \y, 0.01, \amp, ~b1.asMap).play;
)

(
Ndef(\lfo, {LFTri.ar(60,mul:0.6, add:0.5)}).play(0,4);
Ndef(\p1).set(\freq,  4000, \detune,0, \f0,6.5, \f1, 3.7, \w0, 0.9, \phasing,0, \legato,0.01, \amp,0.15).play(0,2);
Ndef(\roof).set(\x, 0.4, \y, 0.1, \amp, ~b1.asMap).play;
)


(
Ndef(\lfo, {LFTri.ar(60,mul:0.6, add:0.5)}).play(0,4);
Ndef(\p1).set(\freq,  4000, \detune,0, \f0,6.5, \f1, 9.7, \w0, 0.1, \phasing,0, \legato,0.1, \amp,0.15).play(0,2);
Ndef(\roof).set(\x, 0.4, \y, 0.1, \amp, ~b1.asMap).play;
)

(
Ndef(\lfo, {LFTri.ar(30,mul:0.6, add:0.5)}).play(0,4);
Ndef(\p1).set(\freq,  1000, \detune,0, \f0,6.5, \f1, 0.1, \w0, 0.1, \phasing,0, \legato,0.1, \amp,0.15).play(0,2);
Ndef(\roof).set(\x, 0.1, \y, 0.1, \amp, ~b1.asMap).play;
)


(
Ndef(\lfo, {LFTri.ar(30,mul:0.6, add:0.5)}).play(0,1);
Ndef(\p1).set(\freq,  4000, \detune,0, \f0,6.5, \f1, 0.1, \w0, 0.89, \phasing,0, \legato,0.1, \amp,0.015).play(0,2);
Ndef(\roof).set(\x, 0.4, \y, ~b1.asMap, \amp, 0.3).play;
)

(
Ndef(\lfo, {LFTri.ar(60,mul:0.6, add:0.5)}).play(1,1);
Ndef(\p1).set(\freq,  4000, \detune,0, \f0,6.5, \f1, 0.1, \w0, 0.89, \phasing,0, \legato,0.1, \amp,0.015).play(0,2);
Ndef(\roof).set(\x, 0.4, \y, ~b1.asMap, \amp, 0.3).play;
)


(
Ndef(\lfo, {LFTri.ar(30,mul:0.6, add:0.5)}).play(0,1);
Ndef(\p1).set(\freq,  4000, \detune,0, \f0,6.5, \f1, 0.1, \w0, 0.89, \phasing,0, \legato,0.1, \amp,0.015).play(0,2);
Ndef(\roof).set(\x, 0.4, \y, ~b1.asMap, \amp, 0.3).play;
)

(
Ndef(\lfo, {LFTri.ar(3,mul:0.6, add:0.5)}).play(0,2);
Ndef(\p1).set(\freq,  4000, \detune,0, \f0,6.5, \f1, 0.1, \w0, 0.89, \phasing,0, \legato,Ndef(\lfo), \amp,0.015).play(0,2);
Ndef(\roof).set(\x, 0.4, \y, 0.1, \amp, 0.1).play;
)

(
Ndef(\lfo, {LFTri.ar(1,mul:0.6, add:0.5)}).play(0,2);
Ndef(\p1).set(\freq,  4000, \detune,0, \f0,6.5, \f1, 0.1, \w0, 0.5, \phasing,0, \legato,Ndef(\lfo), \amp,0.005).play(0,2);
Ndef(\roof).set(\x, 0.4, \y, 0.9, \amp, 0.1).play;
)

(
Ndef(\lfo, {LFTri.ar(0.8,mul:0.4, add:0.8)}).play(0,2);
Ndef(\p1).set(\freq,  4000, \detune,0, \f0,6.5, \f1, 0.1, \w0, 0.5, \phasing,0, \legato,Ndef(\lfo), \amp,0.005).play(0,2);
Ndef(\roof).set(\x, 0.8, \y, 0.9, \amp, 0.01).play;
)

(
Ndef(\lfo, {LFTri.ar(0.8,mul:0.4, add:0.8)}).play(0,2);
Ndef(\p1).set(\freq,  4000, \detune,0, \f0,6.5, \f1, 0.1, \w0, 0.5, \phasing,0, \legato,Ndef(\lfo), \amp,0.005).play(0,2);
Ndef(\roof).set(\x, 0.8, \y, 0.9, \amp, 0.01).play;
)

(
Ndef(\roof).set(\x, 1, \y, 0.9, \amp, 0.001).play;
Ndef(\lfo).stop;
Ndef(\p1).stop;
)


(
Ndef(\roof).stop;
Ndef(\lfo).stop;
Ndef(\p1).stop;
)
