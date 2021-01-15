// hash practice

(
Server.default = s = Server("belaServer", NetAddr("192.168.7.2", 57110));
s.initTree;
s.startAliveThread;
)


s.freeAll;
Bus.clear;



// Ndef to Ndef
// pulse
// roofblow


s.freeAll

// Analog out
(
SynthDef(\dc, {|val=0, out=2|
	AnalogOut.ar(out, SinOsc.ar(0, add:val));
}).add;
)

(
~o1 = Synth(\dc, [\out, 2]);
~o2 = Synth(\dc, [\out, 3]);
~o3 = Synth(\dc, [\out, 4]);
~o4 = Synth(\dc, [\out, 5]);
)

// check analog outs
~o1.set(\val, 0.1)
~o1.set(\val, 0.3)

~o2.set(\val, 0.05)
~o2.set(\val, 0.15)
~o2.set(\val, 1)

~o3.set(\val, 0.8)
~o3.set(\val, 0.1)

~o4.set(\val, 0.1)
~o4.set(\val, 0.3)

// LFOs mapping
Ndef(\fo1, {|freq=10| LFSaw.ar(freq)});
~o1.map(\val, Ndef(\fo1))
Ndef(\fo1).play(4,1);

Ndef(\fo1).set( \freq, 900);
Ndef(\fo1).set( \freq, 100);
Ndef(\fo1).set( \freq, 200);
Ndef(\fo1).set( \freq, 1);



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
	Out.kr(~b1, Amplitude.kr(trig));
	rel = SinOsc.ar(f1, 0, 1, legato);
	Out.kr(~b2, Amplitude.kr(rel));
	env = EnvGen.ar(Env.adsr(releaseTime:rel), trig);
	sig = LFPar.ar(freq, mul:0.5);
	outSig = sig * env;
});
)


(
Ndef(\p2, {|freq=6000, detune=0.3, f0=9, f1=2.7, w0=0.8, phasing=0.1, legato=0.1|
	var sig, env, env2, trig, sig2,outSig, rel;
	trig = Pulse.ar(f0, w0);
	Out.kr(~b3, Amplitude.kr(trig));

	// other oscillators (LFPulse, LFCub, LFTri, LFSaw, etc)
	rel = SinOsc.ar(f1, 0, 1, legato);

	Out.kr(~b4, Amplitude.kr(rel));
	env = EnvGen.ar(Env.adsr(releaseTime:rel), trig);

	// other oscillators (LFPulse, LFCub, LFTri, LFSaw, etc)
	sig = LFPar.ar(freq, mul:0.5);

	outSig = sig * env;
});

)


Ndef(\p1).play(0,1);
Ndef(\p2).play(1,1);
Ndef(\p1).stop

~o1.map(\val, ~b1);
~o1.map(\val, ~b2);
~o1.map(\val, ~b3);
~o1.map(\val, ~b4);

~o2.map(\val, ~b2);
~o3.map(\val, ~b4);
~o4.map(\val, ~b4);



	(
		Ndef(\p1).stop;
		Ndef(\p2).stop;
	)


(
Ndef(\p1).play(0, 1);
Ndef(\p2).play(1, 1);
)

	Ndef(\p1).set(\freq, 7000, \f0, 9, \f1, 2.8);
		//


	// --------------------------------------  P3
	Ndef(\p1).copy(\p3);
	Ndef(\p3).play(2,1);
	Ndef(\p3).stop
	Ndef(\p3).clear
	Ndef(\p3).set(\freq, 200, \f0, 0.3, \f1, 30, \w0, 0.4, \legato, 0.1);



	// ---- LFO
	Ndef(\lf1,{SinOsc.ar(90) + LFTri.ar(0.4);}).play(2,1);

	Ndef(\p1).map(\w0, Ndef(\lf1));
	Ndef(\lf1).stop
	Ndef(\lf1).play



(
Ndef(\p1).set(\freq, 90, \f0, 9, \f1, 2.8, \w0, 0.9);
)




	Ndef(\p1).stop
	Ndef(\p1).play
s.freeAll