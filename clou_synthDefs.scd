SynthDef.new(\pulse,{
	// hack from "https://sccode.org/1-Z"
	// removing layers
	|f1=8, f2=3, chaos=1, amp=0.0|

	var sig1, ampMap, chaosMap;
	ampMap = ControlSpec(0.0, 1.0);
	chaosMap = ControlSpec(0.1, 2.0); // restrict chaos range (see Crackle doc). Crashes above 2.
	amp = ampMap.map(amp);
	chaos = chaosMap.map(chaos);
	sig1 = tanh(Impulse.kr(f1).lag*Crackle.ar(LFSaw.kr(f2).abs.lag*chaos))*5;
	Out.ar(0, (sig1!2)*amp);
}).add;


SynthDef.new(\bass,{
	|amp=0.1, freq=200, out=0, gate=1|
	var sig, env;
	env = Env.asr(0.01, 1, 0.1);
	sig = Saw.ar(freq);
	sig = sig * EnvGen.ar(env, gate, amp, doneAction:2);
	Out.ar(out, sig!2);
}).add;


SynthDef.new(\mantissa, {|out=0, in=0, amp=0.1, mix=0.5, tone=0.1|
	var sig, mask, bits;
	bits = tone.linlin(0, 1, 0, 23);
	sig = SoundIn.ar(in!2)*amp;
	mask = MantissaMask.ar(sig, bits);
	sig = XFade2.ar(sig, mask, mix);
	Out.ar(out, sig);
}).add;

// x = Synth(\mantissa, [\amp, 0.1, \tone, 1, \mix, 1]);

SynthDef(\perc,
	{
		|amp=0.1, pan=0, freq=100|
		var sig;
		sig = SinOsc.ar(freq:freq, mul: EnvGen.ar(Env.perc(0.001, 0.3), doneAction:2));
		Out.ar(0, Pan2.ar(sig*amp, pan));
}).add;