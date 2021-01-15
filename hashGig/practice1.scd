// practice hash

(
// make a DC synth (the DC ugen doesn't allow modulation)
SynthDef(\dc, {|val=0, out=2|
	AnalogOut.ar(out, SinOsc.ar(0, add:val));
}).add;
)

(
~c1 = Bus.control(s, 1);
~c2 = Bus.control(s, 1);
~c3 = Bus.control(s, 1);
~c4 = Bus.control(s, 1);
~c5 = Bus.control(s, 1);

~o1 = Synth(\dc, [\out, 2]);
~o2 = Synth(\dc, [\out, 3]);
~o3 = Synth(\dc, [\out, 4]);
~o4 = Synth(\dc, [\out, 5]);
)

(

Ndef(\p1, {|out=0, freq=8000, detune=0.3, f0=6, f1=2.7, w0=0.98, phasing=0, legato=0.5|
	var sig, env, env2, trig, sig2,outSig;
	trig = Pulse.ar(f0, w0);
	env = EnvGen.ar(Env.adsr(releaseTime:SinOsc.ar(f1, 0, 1, legato)), trig);
	env2 = DelayC.ar(env, 0.2, phasing);

	sig = LFPar.ar([freq, freq*2], mul:0.5);
	Out.kr(~c1, Amplitude.kr(sig));
	sig2 = LFPar.ar([freq, freq*2] + detune.linlin(0, 1, 0, 3), mul:0.6);
	Out.kr(~c3, Amplitude.kr(sig2));
	outSig = Splay.ar([sig * env, sig2 * env2]);
	Out.ar(out, outSig );
	Out.kr(~c4, Amplitude.kr(outSig));
});

Ndef(\p2, {|out=0, freq=8000, detune=0.3, f0=6, f1=2.7, w0=0.98, phasing=0, legato=0.5|
	var sig, env, env2, trig, sig2,outSig;
	trig = Pulse.ar(f0, w0);
	env = EnvGen.ar(Env.adsr(releaseTime:SinOsc.ar(f1, 0, 1, legato)), trig);
	env2 = DelayC.ar(env, 0.2, phasing);
	Out.kr(~c1, Amplitude.kr(trig));
	sig = LFPar.ar([freq, freq*2], mul:0.5);
	Out.kr(~c2, Amplitude.kr(sig));
	sig2 = LFPar.ar([freq, freq*2] + detune.linlin(0, 1, 0, 3), mul:0.6);
	Out.kr(~c3, Amplitude.kr(sig2));
	outSig = Splay.ar([sig * env, sig2 * env2]);
	Out.ar(out, outSig );
	Out.kr(~c4, Amplitude.kr(outSig));
});


Ndef(\p1).set(\f0, 8);
Ndef(\p2).set(\f1, 7);

Ndef(\p1).set(\freq, 80);

Ndef(\p2).set(\freq, 700);
Ndef(\p2.set(\f0, 8);
Ndef(\p1).set(\f2, 3);


~o1.map(\val, ~c1.index);
~o2.map(\val, ~c2.index);
~o3.map(\val, ~c3.index);
~o4.map(\val, ~c1.index);
~o4.map(\val, ~c2.index);

Ndef(\lfo, {|out=0|
	Out.kr(~c5, LFTri.kr(2));
});

Ndef(\lfo

);

s.freeAll