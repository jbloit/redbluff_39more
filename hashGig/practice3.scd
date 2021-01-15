// hash practice 2

(
Server.default = s = Server("belaServer", NetAddr("192.168.7.2", 57110));
s.initTree;
s.startAliveThread;
)


(
SynthDef(\dc, {|val=0, out=2|
	AnalogOut.ar(out, SinOsc.ar(0, add:val));
}).add;
)

(
~b1 = Bus.control(s, 1);
~b2 = Bus.control(s, 1);
~b3 = Bus.control(s, 1);
~b4 = Bus.control(s, 1);
)

(
Ndef(\p1, {|freq=7000, detune=0.3, f0=9, f1=2.7, w0=0.98, phasing=0, legato=0.5|
	var sig, env, env2, trig, sig2,outSig, rel;
	trig = Pulse.ar(f0, w0);
	Out.kr(~b2, Amplitude.kr(trig));
	rel = SinOsc.ar(f1, 0, 1, legato);
	Out.kr(~b1, Amplitude.kr(rel));
	env = EnvGen.ar(Env.adsr(releaseTime:rel), trig);
	sig = LFPar.ar(freq, mul:0.5);
	outSig = sig * env;
});
)


(
Ndef(\p2, {|freq=8000, detune=0.3, f0=9, f1=2.7, w0=0.8, phasing=0.1, legato=0.1|
	var sig, env, env2, trig, sig2,outSig;
	trig = Pulse.ar(f0, w0);
	env = EnvGen.ar(Env.adsr(releaseTime:SinOsc.ar(f1, 0, 1, legato)), trig);
	sig = LFPar.ar(freq, mul:0.5);

	Out.kr(~b3, Amplitude.kr(trig));

	Out.kr(~b4, Amplitude.kr(rel));

	outSig = sig * env;
});

)

(
~o1 = Synth(\dc, [\out, 2]);
~o2 = Synth(\dc, [\out, 3]);
~o3 = Synth(\dc, [\out, 4]);
~o4 = Synth(\dc, [\out, 5]);
)


~o2.map(\val, ~b1);
~o1.map(\val, ~b1);
~o2.map(\val, ~b2);
~o2.set(\val, 0.02);
~o2.map(\val, {SinOsc.kr(1)});

Ndef(\lfo, {SinOsc.ar(1, 0, 0.5, 1)};

~o3.map(\val, ~b3);
~o3.map(\val, ~b3);
~o3.map(\val, ~b3);
~o4.map(\val, ~b3);



(
Ndef(\p1).stop;
Ndef(\p2).stop;
)


(
Ndef(\p1).play(0, 1);
Ndef(\p2).play(1, 1);
)

	Ndef(\p1).set(\freq, 7000, \f0, 9, \f1, 2.8);
	Ndef(\p1).set(\freq, 7000, \f0, 9, \f1, 2.8);
	//

	Ndef(\p1).copy(\p3);

	Ndef(\p3).play(2,1);

	Ndef(\p3).stop
	Ndef(\p3).clear

	Ndef(\p3).set(\freq, 200, \f0, 0.3, \f1, 30, \w0, 0.4, \legato, 0.1);

(
Ndef(\p1).set(\freq, 400, \f0, 9, \f1, 2.8, \w0, 0.9);
)

	Ndef(\p1).stop
	Ndef(\p1).play

s.freeAll
