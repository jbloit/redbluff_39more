// Rythmic synth

(
Ndef(\noise, {|out=0, freq=55, detune=0.3, f0=6, f1=2.7, w0=0.98, phasing=0, legato=0.5|
	var sig, env, env2, trig, sig2;
	trig = Pulse.ar(f0, w0);
	env = EnvGen.ar(Env.adsr(releaseTime:SinOsc.ar(f1, 0, 1, legato)), trig);
	env2 = DelayC.ar(env, 0.2, phasing);
	sig = Saw.ar([freq, freq*2], mul:0.5);
	sig2 = Pulse.ar([freq, freq*2] + detune.linlin(0, 1, 0, 3), mul:0.6);
	Out.ar(out, Splay.ar([sig * env, sig2 * env2]));
});
)


Ndef(\noise).stop
Ndef(\noise).play


Ndef(\noise).set(\freq, 60, \legato, 0.1, \f1, 2.7)
Ndef(\noise).set(\freq, 63, \legato, 0.9, \f1, 2)
Ndef(\noise).set(\freq, 60, \legato, 0.1, \f1, 2.7)
Ndef(\noise).set(\freq, 63, \legato, 0.9, \f1, 2)
Ndef(\noise).set(\phasing, 1)
