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
	bits = tone.linlin(0, 1, 0, 23).postln;
	sig = SoundIn.ar(in!2)*amp;
	mask = MantissaMask.ar(sig, bits);
	sig = XFade2.ar(sig, mask, mix);
	Out.ar(out, sig);
}).add;
// x = Synth(\mantissa, [\amp, 0.1, \tone, 0.9]);

SynthDef.new(\sawvolve, {|out=0, in=0, freq=300, amp=0.1, gate=1, mix=0.5, tone=0.1|
	var sig, kernel, conv, env;
	env = Env.asr(0.01, 1, 0.1);
	kernel = Mix.ar(LFSaw.ar([freq,freq*1.2,freq*3,freq*4] * tone));
	sig = sig = SoundIn.ar(in!2)*amp;
	conv = Convolution.ar(sig,kernel, 1024, 0.5);
	sig = XFade2.ar(sig, conv, mix);
	Out.ar(out, sig * EnvGen.ar(env, gate, amp, doneAction:2));
}).add;
// x = Synth(\sawvolve, [\amp, 0.1, \tone, 0.7]);

