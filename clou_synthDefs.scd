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


