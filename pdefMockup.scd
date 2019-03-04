

///////////////////////////////////////////////////////////////////////////// INIT SAMPLER FOR MOCKUP
(

~fxBus = Bus.audio(s, 1);

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
	Out.ar(~fxBus, sig);
}).add;



Ndef(\fx, {|freq=90|
	var in, kernel, freqd;
	in= In.ar(~fxBus, 1);
	freqd = Duty.kr(0.5, 0, Dseq([freq], inf));
	2*Amplitude.ar(in).lag(1)*LFPar.ar(	freqd );
}
);

Ndef(\fx).play;
Ndef(\fx).stop;


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

t = TempoClock.tempo = 60/60;


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
Pdef(\kick, Pbind(\instrument, \sampler,
	\dur, Prand([1/4, 1/8], inf),
	\pan, Prand([0,1, 0.5], inf),
	\timbre, Pwhite(0.0, 1.0, inf),
	\bufnum, Prand((1,2..3), inf),
	\amp, Prand([0.3, 2, 4], inf))).play
)

////////////////// GROOVE A
(
Pdef(\kick, Pbind(\instrument, \sampler,
	\dur, Prand([1/4, 1/8], inf),
	\pan, Prand([0,1, 0.5], inf),
	\timbre, Pwhite(0.0, 1.0, inf),
	\bufnum, Prand((1,2..3), inf),
	\amp, Prand([0.3, 2, 4], inf))).play;

Ndef(\fx).set(\freq, 100);
)

/////////////// RUBATO IMPRO
(
Pdef(\kick, Pbind(\instrument, \sampler,
	\dur, 1/ Pseq([
        Pseries({ rrand(2, 7) }, 1, { rrand(4, 8) }),    // up (step = 1)
        Pseries({ rrand(3, 7) }, 1, { rrand(4, 8) }),    // up (step = 1)
	    ], inf),
	\pan, Prand([0,1, 0.5], inf),
	\timbre, Pwhite(0.0, 1.0, inf),
	\bufnum, Prand((1,2..6), inf),
	\amp, Prand([0.3, 2, 4], inf))).play
)


////////// rand kick snare, pattern hat
(
Pdef(\kick, Pbind(\instrument, \sampler,
	\dur, Prand([1/4, 1/8], inf),
	\pan, Prand([0,1, 0.5], inf),
	\timbre, Pwhite(0.0, 1.0, inf),
	\bufnum, Prand((1,2..3), inf),
	\amp, Prand([0.3, 2, 4], inf))).play;

Pdef(\hat, Pbind(\instrument, \sampler,
	\dur, Pstutter(3, Pseq([1/2,1/8,1/4], inf)),
	\bufnum, Prand([1,2],inf),
	\amp, 0.6,)).play;

)


////////// rand kick snare, pattern hat
(
Pdef(\kick, Pbind(\instrument, \sampler,
	\dur, Prand([1/4, 1/8], inf),
	\pan, Prand([0,1, 0.5], inf),
	\timbre, Pwhite(0.0, 1.0, inf),
	\bufnum, Prand((1,2..3), inf),
	\amp, Prand([0.3, 2, 4], inf))).play;

Pdef(\hat, Pbind(\instrument, \sampler,
	\dur, Pstutter(3, Pseq([1/2], inf)),
	\bufnum, Prand([1,2],inf),
	\amp, 0.6,)).play;
)



////////// rand kick snare, pattern hat
(
Pdef(\kick, Pbind(\instrument, \sampler,
	\dur, Prand([1/4, 1/8], inf),
	\pan, Prand([0,1, 0.5], inf),
	\timbre, Pwhite(0.0, 1.0, inf),
	\bufnum, Prand((1,2..3), inf),
	\amp, Prand([0.3, 2, 4], inf))).play;

Pdef(\hat, Pbind(\instrument, \sampler,
	\dur, Pstutter(3, Pseq([1/2, 1/4, 1/8], inf)),
	\bufnum, Prand([6,7,8],inf),
	\amp, 0.6,)).play;
)


////////// rand kick snare, pattern hat
(
Pdef(\kick, Pbind(\instrument, \sampler,
	\dur, Pseq([1/4, 1/8, 1/8], inf),
	\pan, Prand([0,1, 0.5], inf),
	\timbre, Pwhite(0.9, 1.0, inf),
	\bufnum, Prand((1,2..3), inf),
	\amp, Prand([0.3, 2, 4], inf))).play;

Pdef(\hat, Pbind(\instrument, \sampler,
	\dur, Pstutter(3, Pseq([1/2, 1/4, 1/8], inf)),
	\bufnum, Prand([9, 10, 11],inf),
	\amp, 0.6,)).play;
)




////////// rand kick & hat, pattern for snare

(
Pdef(\kick, Pbind(\instrument, \sampler,
	\dur, Prand([1/4, 1/2], inf),
	\pan, Prand([0,1, 0.5], inf),
	\timbre, Pwhite(0.0, 1.0, inf),
	\bufnum, Prand((8, 9..11), inf),
	\amp, Prand([0.3, 2, 4], inf))).play;

Pdef(\snare, Pbind(\instrument, \sampler,
	\dur, Pstutter(3, Pseq([1/2,1/8,1/4], inf)),
	\bufnum, Prand([8],inf),
	\amp, 0.6,)).play;
Ndef(\fx).set(\freq, 100);
)

(
Pdef(\kick, Pbind(\instrument, \sampler,
	\dur, Prand([1/4, 1/8, 1/2], inf),
	\pan, Prand([0,1, 0.5], inf),
	\timbre, Pwhite(0.0, 1.0, inf),
	\bufnum, Prand((3,4..6), inf),
	\amp, Prand([0.3, 2, 4], inf))).play;

Pdef(\snare, Pbind(\instrument, \sampler,
	\dur, Pstutter(3, Pseq([1/2,1/8,1/4], inf)),
	\bufnum, Prand([8],inf),
	\amp, 0.6,)).play;
Ndef(\fx).set(\freq, 90);
)


// rolllll hat
(
Pdef(\kick, Pbind(\instrument, \sampler,
	\dur, Prand([1/4, 1/8, 1/2], inf),
	\pan, Prand([0,1, 0.5], inf),
	\timbre, Pwhite(0.0, 1.0, inf),
	\bufnum, Prand([5,10], inf),
	\amp, Prand([0.3, 2, 4], inf))).play;

Pdef(\snare, Pbind(\instrument, \sampler,
	\dur, Pstutter(3, Pseq([1/2,1/8, 1/16], inf)),
	\bufnum, Prand([7,8],inf),
	\amp, 0.6,)).play;
Ndef(\fx).set(\freq, 90);
)


// rollll groover
(
Pdef(\kick, Pbind(\instrument, \sampler,
	\dur, Prand([1/4, 1/8, 1/2], inf),
	\pan, Prand([0,1, 0.5], inf),
	\timbre, Pwhite(0.0, 1.0, inf),
	\bufnum, Prand([5,10], inf),
	\amp, Prand([0.3, 2, 4], inf))).play;

Pdef(\snare, Pbind(\instrument, \sampler,
	\dur, Pstutter(4, Pseq([1/8, 1/16], inf)),
	\bufnum, Prand([6, 7,8],inf),
	\amp, 0.6,)).play;
Ndef(\fx).set(\freq, 90);
)


// rollll groover,
(
Pdef(\kick, Pbind(\instrument, \sampler,
	\dur, Prand([1/4, 1/8, 1/2], inf),
	\pan, Prand([0,1, 0.5], inf),
	\timbre, Pwhite(0.0, 1.0, inf),
	\bufnum, Prand([5,10], inf),
	\amp, Prand([0.3, 2, 4], inf))).play;

Pdef(\snare, Pbind(\instrument, \sampler,
	\dur, Pstutter(4, Pseq([1/8, 1/16], inf)),
	\bufnum, Prand([6, 7,8],inf),
	\amp, 0.6,)).play;
Ndef(\fx).set(\freq, 90);
)






)

).play;


)


(
Pdef(\kick).stop
)

Pseg


(
Pdef(\kick1, Pbind(\instrument, \sampler,
	\dur, Prand([1/4], inf),
	\pan, Prand([0, 1, 0.5], inf),
	\timbre, Pwhite(0.0, 1.0, inf),
	\bufnum, 1,
	\amp, Prand([0.3, 2, 4], inf))).play
)

