
(


SynthDef(\sampler, {
	|out=0, bufnum=0, amp=0.3, rate=1, timbre=1, pan=0.5, gate=1|
	var sig, sigfilt, env;
	sig = PlayBuf.ar(1, bufnum, rate * BufRateScale.kr(bufnum));
	env = EnvGen.ar(Env.adsr, gate, doneAction:2);
	sig = sig * env;
	sigfilt = BPF.ar(sig, timbre.clip(0,1).linexp(0, 1, 100, 10000), 0.3);
	sig = Mix.ar([sig*0.5, sigfilt*0.9]);
	sig = Pan2.ar(sig*amp, pan.linlin(0.0, 1.0, -1.0, 1.0));
	Out.ar(out, sig);
}).add;

// LOAD SAMPLES

~samplesDir = thisProcess.nowExecutingPath.dirname +/+"RedBluffAcousticDrums";
~kickBuffers= Array.newClear(3);
~kickBuffers[0] = Buffer.read(s, ~samplesDir +/+ "kick_brush.wav" );
~kickBuffers[1] = Buffer.read(s, ~samplesDir +/+ "kick_mallet.wav" );
~kickBuffers[2] = Buffer.read(s, ~samplesDir +/+ "kick_rim.wav" );

~snareBuffers= Array.newClear(3);
~snareBuffers[0] = Buffer.read(s, ~samplesDir +/+ "snare_rods.wav" );
~snareBuffers[1] = Buffer.read(s, ~samplesDir +/+ "snare_dry.wav" );
~snareBuffers[2] = Buffer.read(s, ~samplesDir +/+ "snare_crush.wav" );

~hatBuffers= Array.newClear(3);
~hatBuffers[0] = Buffer.read(s, ~samplesDir +/+ "hat_spanky.wav" );
~hatBuffers[1] = Buffer.read(s, ~samplesDir +/+ "hat_spanky_rez.wav" );
~hatBuffers[2] = Buffer.read(s, ~samplesDir +/+ "hat_crashcourse.wav" );

~tomBuffers= Array.newClear(3);
~tomBuffers[0] = Buffer.read(s, ~samplesDir +/+ "tom_stick.wav" );
~tomBuffers[1] = Buffer.read(s, ~samplesDir +/+ "tom_mallet.wav" );
~tomBuffers[2] = Buffer.read(s, ~samplesDir +/+ "tom_mallet_rez.wav" );
)


(
Tdef(\arrangement,{





	TempoClock.tempo=1;




	Ndef(\pulse, {Out.ar(0, Impulse.ar(1!2))});




	Ndef(\arp3, {|out=0, freq=55, detune=0.3, f0=8, f1=2.7, w0=0.95, phasing=0, legato=0.5, amp=0.5,rel=0.1,lpf=1000|
		var sig, env, env2, trig, sig2;
		trig = Pulse.ar(f0, w0);

		env = EnvGen.ar(Env.adsr(releaseTime:rel),trig).lag(0.01);
		env2 = DelayC.ar(env, 1, phasing);

		// experiment replacing oscillators (LFPulse, LFCub, LFTri, LFSaw, etc)
		sig = LPF.ar(LFSaw.ar([freq, freq*2]*8, mul:0.5)+LFSaw.ar([freq, freq*2]*8+0.01, mul:0.5),lpf);
		sig2 = LFPulse.ar([freq, freq*2]*8 + detune.linlin(0, 1, 0, 100), mul:0.1);
		Out.ar(out, Splay.ar([sig * env*0.5, sig2 * env2]*amp*0.4));
	});


	Pdef(\piano,	Pbind(\dur, 1/2)).play;

	2.wait;

	Pdef(\piano, 	Pbind(\dur, 1/4, \note, 3)).play;

	2.wait;

	Pdef(\piano,	Pbind(\dur, 1/2)).play;

	(
		Pdef(\kick, Pbind(\instrument, \sampler,
			\dur, Prand([1/4], inf),
			\pan, Prand([0,1, 0.5], inf),
			\timbre, Pwhite(0.0, 1.0, inf),
			\bufnum, Prand((1,2..3), inf),
			\amp, Prand([0.3, 2, 4], inf))).play;
	)



}).play;
)