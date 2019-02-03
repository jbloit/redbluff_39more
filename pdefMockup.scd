
///////////////////////////////////////////////////////////////////////////// INIT SAMPLER FOR MOCKUP
(
~samplesDir = thisProcess.nowExecutingPath.dirname +/+"RedBluffAcousticDrums";

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
/////////////////////////////////////////////////////////////////////////// MIDI IN

TempoClock.tempo = 90/60;


(
Pdef(\kick, Pbind(\instrument, \sampler,
	\dur, Prand([1/4], inf),
	\pan, Prand([0,1, 0.5], inf),
	\timbre, Pwhite(0.0, 1.0, inf),
	\bufnum, 0,
	\amp, Prand([0.3, 2, 4], inf))).play
)

(
Pdef(\kick, Pbind(\instrument, \sampler,
	\dur, Prand([1/4], inf),
	\pan, Prand([0,1, 0.5], inf),
	\timbre, Pwhite(0.0, 1.0, inf),
	\bufnum, Prand((1,2..3), inf),
	\amp, Prand([0.3, 2, 4], inf))).play
)

(
Pdef(\kick, Pbind(\instrument, \sampler,
	\dur, Prand([1/4, 1/8], inf),
	\pan, Prand([0,1, 0.5], inf),
	\timbre, Pwhite(0.0, 1.0, inf),
	\bufnum, Prand((1,2..3), inf),
	\amp, Prand([0.3, 2, 4], inf))).play
)

(
Pdef(\kick).stop
)




