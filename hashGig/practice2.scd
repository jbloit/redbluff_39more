// hash practice 2

(
Server.default = s = Server("belaServer", NetAddr("192.168.7.2", 57110));
s.initTree;
s.startAliveThread;
)


// Conduite:
// 1 avoir des synths de base (en version Ndef !!!) en debut de fichier et les dupliquer. je ne peux pas coder en live. mais je peux
// hacker en live. ca suffira pour un debut.
// commencer avec des sons aigus
// 2. le dupliquer
// 3. rajouter des bus
// 4. mapper vers Ocoast, pour ajouter des basses
// ajouter une nappe et un bus disto
// avoir des Ndef de LFO
// articuler nappes et beat et silence, en cut.

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
Ndef(\p1, {|out=0, freq=7000, detune=0.3, f0=9, f1=2.7, w0=0.98, phasing=0, legato=0.5|
	var sig, env, env2, trig, sig2,outSig, rel;
	trig = Pulse.ar(f0, w0);
	Out.kr(~b2, Amplitude.kr(trig));
	rel = SinOsc.ar(f1, 0, 1, legato);
	Out.kr(~b1, Amplitude.kr(rel));
	env = EnvGen.ar(Env.adsr(releaseTime:rel), trig);
	env2 = DelayC.ar(env, 0.2, phasing);
	sig = LFPar.ar([freq, freq*2], mul:0.5);
	sig2 = LFPar.ar([freq, freq*2] + detune.linlin(0, 1, 0, 3), mul:0.6);
	outSig = sig * env;
	Out.ar(out, outSig );
});

Ndef(\p2, {|out=1, freq=8000, detune=0.3, f0=9, f1=2.7, w0=0.8, phasing=0.1, legato=0.1|
	var sig, env, env2, trig, sig2,outSig;
	trig = Pulse.ar(f0, w0);
	env = EnvGen.ar(Env.adsr(releaseTime:SinOsc.ar(f1, 0, 1, legato)), trig);
	env2 = DelayC.ar(env, 0.2, phasing);
	sig = LFPar.ar([freq, freq*2], mul:0.5);
	sig2 = LFPar.ar([freq, freq*2] + detune.linlin(0, 1, 0, 3), mul:0.6);
	outSig = sig * env;
	Out.ar(out, outSig );
});

)

(
~o1 = Synth(\dc, [\out, 2]);
~o2 = Synth(\dc, [\out, 3]);
~o3 = Synth(\dc, [\out, 4]);
~o4 = Synth(\dc, [\out, 5]);
)


~o1.map(\val, ~b1);
~o2.map(\val, ~b2);


Ndef(\p2).stop;
Ndef(\p1).play;
Ndef(\p1).set(\freq, 7000, \f0, 8, \f1, 2.8);
(
Ndef(\p1).set(\freq, 70, \f0, 8, \f1, 2.8);
Ndef(\p2).set(\freq, 60, \f0, 8, \f1, 3.8);
)


s.freeAll

