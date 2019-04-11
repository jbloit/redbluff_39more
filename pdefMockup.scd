/*
One FX per pedal slot, on piezzo (DAMPR)

[1] [2] [3] [4] [5  ]
||
v
fx switch

[6] [7] [8] [9] [10]
||
v
damper fx, cc controlled, sequence set
5 different fx, can be played in parallel

- play mode (foot is off, switch is on):
if onset, advance in param value array

- edit mode (foot is on, switch is on):
on foot down: erase sequence
on onset, save CC val in next array slot

- instant mode: (foot is on, switch is off)
play fx with CC value

LED CPU monitor? green 0->50, orange, 50->80, 80-100;

=============== Implementation:
start with instant mode, with mouseX as CC control
audio graph:

FX in =  ~fxBus;

[instantMode] FX synths = instantiated on ccOn, deleted on ccOff


*/


///////////////////////////////////////////////////////////////////////////// INIT SAMPLER FOR MOCKUP
(

t = TempoClock.tempo = 60/60;

~fxBus = Bus.audio(s, 2);

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



// Ndef(\fx).stop;


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






////////////////////////////////////////// 3 layers riffs for wenzhu



(

//////////////// 1

(
Pdef(\p1s1, Ppar(
	[
		// kick
		Pbind(\instrument, \sampler,
			\dur, Pseq([3/4, 6/4, 3/4, 3/4, 9/4]/2, inf),
			\pan, 1,
			\timbre, 0,
			\bufnum, 0,
			\amp, 3),

		// snare
		Pbind(\instrument, \sampler,
			\dur, Pseq([Rest(1.5),3, 1.5]/2, inf),
			\pan, 0,
			\timbre, 0,
			\bufnum, 3,
			\amp, 0;
		),

		//hat
		Pbind(\instrument, \sampler,
			\dur, 1/4,
			\pan, 0.5,
			\timbre, 0,
			\bufnum, Pseq([6,7], inf),
			\amp, 1;
		)
	]
));

);
/////////////////////// 2
(
Pdef(\p1s2, Ppar(
	[
		// kick
		Pbind(\instrument, \sampler,
			\dur, Pseq([3/4, 6/4, 3/4, 3/4, 9/4]/2, inf),
			\pan, 1,
			\timbre, 0,
			\bufnum, 0,
			\amp, 3),

		// snare
		Pbind(\instrument, \sampler,
			\dur, Pseq([Rest(1.5),3, 1.5]/2, inf),
			\pan, 0,
			\timbre, 0,
			\bufnum, 3,
			\amp, 3;
		),

		//hat
		Pbind(\instrument, \sampler,
			\dur, 1/4,
			\pan, 0.5,
			\timbre, 0,
			\bufnum, Pseq([6,7], inf),
			\amp, 1;
		)
	]
));
);



////////////////////////////////// 3
(
Pdef(\p1s3, Ppar(
	[
		// kick
		Pbind(\instrument, \sampler,
			\dur, Pseq([3/4, 6/4, 3/4, 3/4, 9/4]/2, inf),
			\pan, 1,
			\timbre, 0,
			\bufnum, 0,
			\amp, 3),

		// snare
		Pbind(\instrument, \sampler,
			\dur, Pseq([Rest(5/4),13/4, 6/4]/2, inf),
			\pan, 0,
			\timbre, 0,
			\bufnum, 3,
			\amp, 3;
		),

		//hat
		Pbind(\instrument, \sampler,
			\dur, 1/4,
			\pan, 0.5,
			\timbre, 0,
			\bufnum, Pseq([6,7], inf),
			\amp, 1;
		)
	]
));
);



////////////////////////////////// 4
(
Pdef(\p1s4, Ppar(
	[
		// kick
		Pbind(\instrument, \sampler,
			\dur, Pseq([3/4, 6/4, 3/4, 3/4, 9/4]/2, inf),
			\pan, 1,
			\timbre, 0,
			\bufnum, 0,
			\amp, 3),

		// snare
		Pbind(\instrument, \sampler,
			\dur, Pseq([Rest(5/4),13/4, 6/4]/2, inf),
			\pan, 0,
			\timbre, 0,
			\bufnum, 3,
			\amp, 3;
		),

		//hat
		Pbind(\instrument, \sampler,
			\dur, 1/4,
			\pan, 0.5,
			\timbre, 0,
			\bufnum, Pseq([6,7,8,7,6,7,6,7,6,7,6,7], inf),
			\amp, 1;
		)
	]
));
);

////////////////////////////////// 5
(
Pdef(\p1s5, Ppar(
	[
		// kick
		Pbind(\instrument, \sampler,
			\dur, Pseq([3/4, 6/4, 3/4, 3/4, 1/4]/2, inf),
			\pan, 1,
			\timbre, 0,
			\bufnum, 0,
			\amp, 3),

		// snare
		Pbind(\instrument, \sampler,
			\dur, Pseq([Rest(5/4),11/4]/2, inf),
			\pan, 0,
			\timbre, 0,
			\bufnum, 3,
			\amp, 3;
		),

		//hat
		Pbind(\instrument, \sampler,
			\dur, 1/4,
			\pan, 0.5,
			\timbre, 0,
			\bufnum, Pseq([6,7,8,7,6,7,6,7], inf),
			\amp, 1;
		)
	]
));
);


////////////////////////////////// 6
(
Pdef(\p1s6, Ppar(
	[
		// kick
		Pbind(\instrument, \sampler,
			\dur, Pseq([3/4, 6/4, 7/4]/2, inf),
			\pan, 1,
			\timbre, 0,
			\bufnum, 0,
			\amp, 3),

		// snare
		Pbind(\instrument, \sampler,
			\dur, Pseq([Rest(5/4),8/4, 3/4]/2, inf),
			\pan, 0,
			\timbre, 0,
			\bufnum, 3,
			\amp, 3;
		),

		//hat
		Pbind(\instrument, \sampler,
			\dur, 1/4,
			\pan, 0.5,
			\timbre, 0,
			\bufnum, Pseq([6,7,8,7,6,7,6,7], inf),
			\amp, 1;
		)
	]
));
);


////////////////////////////////// 7
(
Pdef(\p1s7, Ppar(
	[
		// kick
		Pbind(\instrument, \sampler,
			\dur, Pseq([3/4, 6/4, 7/4]/2, inf),
			\pan, 1,
			\timbre, 0,
			\bufnum, 0,
			\amp, 3),

		// snare
		Pbind(\instrument, \sampler,
			\dur, Pseq([Rest(5/4),2/4,6/4, 3/4]/2, inf),
			\pan, 0,
			\timbre, 0,
			\bufnum, 3,
			\amp, 3;
		),

		//hat
		Pbind(\instrument, \sampler,
			\dur, 1/4,
			\pan, 0.5,
			\timbre, 0,
			\bufnum, Pseq([6,7,8,7,6,7,6,7], inf),
			\amp, 1;
		)
	]
));
);

////////////////////////////////// 8
(
Pdef(\p1s8, Ppar(
	[
		// kick
		Pbind(\instrument, \sampler,
			\dur, Pseq([3/4, 1/4, 5/4, 7/4]/2, inf),
			\pan, 1,
			\timbre, 0,
			\bufnum, 0,
			\amp, 3),

		// snare
		Pbind(\instrument, \sampler,
			\dur, Pseq([Rest(5/4),2/4,6/4, 3/4]/2, inf),
			\pan, 0,
			\timbre, 0,
			\bufnum, 3,
			\amp, 3;
		),

		//hat
		Pbind(\instrument, \sampler,
			\dur, 1/4,
			\pan, 0.5,
			\timbre, 0,
			\bufnum, Pseq([6,7,8,7,6,7,6,7], inf),
			\amp, 1;
		)
	]
));
);

////////////////////////////////// 9
(
Pdef(\p1s9, Ppar(
	[
		// kick
		Pbind(\instrument, \sampler,
			\dur, Pseq([3/4, 1/4, 5/4, 1/4]/2, inf),
			\pan, 1,
			\timbre, 0,
			\bufnum, 0,
			\amp, 3),

		// snare
		Pbind(\instrument, \sampler,
			\dur, Pseq([Rest(5/4),2/4,3/4]/2, inf),
			\pan, 0,
			\timbre, 0,
			\bufnum, 3,
			\amp, 3;
		),

		//hat
		Pbind(\instrument, \sampler,
			\dur, 1/4,
			\pan, 0.5,
			\timbre, 0,
			\bufnum, Pseq([6,7,8,7,6], inf),
			\amp, 1;
s		)
	]
));
);


////////////////////////////////// 10
(
Pdef(\p1s10, Ppar(
	[
		// kick
		Pbind(\instrument, \sampler,
			\dur, Pseq([3/4, 1/4, 5/4, Rest(1/4)]/2, inf),
			\pan, 1,
			\timbre, 0,
			\bufnum, 0,
			\amp, 3),

		// snare
		Pbind(\instrument, \sampler,
			\dur, Pseq([Rest(5/4),2/4,2/4, 1/4]/2, inf),
			\pan, 0,
			\timbre, 0,
			\bufnum, 3,
			\amp, 3;
		),

		//hat
		Pbind(\instrument, \sampler,
			\dur, 1/4,
			\pan, 0.5,
			\timbre, 0,
			\bufnum, Pseq([6,7,8,7,6], inf),
			\amp, 1;
		)
	]
));
);

////////////////////////////////// 11
(
Pdef(\p1s11, Ppar(
	[
		// kick
		Pbind(\instrument, \sampler,
			\dur, Pseq([3/4, 1/4, 5/4, Rest(3/4)]/2, inf),
			\pan, 1,
			\timbre, 0,
			\bufnum, 0,
			\amp, 3),

		// snare
		Pbind(\instrument, \sampler,
			\dur, Pseq([Rest(5/4),2/4,2/4, 3/4]/2, inf),
			\pan, 0,
			\timbre, 0,
			\bufnum, 3,
			\amp, 3;
		),

		//hat
		Pbind(\instrument, \sampler,
			\dur, 1/4,
			\pan, 0.5,
			\timbre, 0,
			\bufnum, Pseq([6,7,8,7,6,7], inf),
			\amp, 1;
		)
	]
));
);

////////////////////////////////// 11
(
 Pdef(\p1s12, Ppar(
	[
		// kick
		Pbind(\instrument, \sampler,
			\dur, Pseq([3/4, 1/4, 5/4, Rest(3/4)]/2, inf),
			\pan, 1,
			\timbre, 0,
			\bufnum, 0,
			\amp, 3),

		// snare
		Pbind(\instrument, \sampler,
			\dur, Pseq([Rest(5/4),2/4,2/4, 3/4]/2, inf),
			\pan, 0,
			\timbre, 0,
			\bufnum, 3,
			\amp, 3;
		),

		//hat
		Pbind(\instrument, \sampler,
			\dur, 1/4,
			\pan, 0.5,
			\timbre, 0,
			\bufnum, Pseq([6,7,8,7,6,7], inf),
			\amp, 1;
		)
	]
));
);

)



//////////////////////////////////////////////////////////////////////////////////////////////////////////////

////////   EXPERIMENTS


/*

(
Pdef(\kick, Pbind(\instrument, \sampler,
	\dur, Prand([1/4], 4),
	\pan, Prand([0,1, 0.5], inf),
	\timbre, Pwhite(0.0, 1.0, inf),
	\bufnum, 0,
	\amp, Prand([0.3, 2, 4], inf))).play;
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


Pdef(\kick).stop;
(
Pdef(\kick1, Pbind(\instrument, \sampler,
	\dur, Prand([1/4], inf),
	\pan, Prand([0, 1, 0.5], inf),
	\timbre, Pwhite(0.0, 1.0, inf),
	\bufnum, 1,
	\amp, Prand([0.3, 2, 4], inf))).play
)


Pdef(\kick).stop;
Pdef(\kick1).stop;,
Pdef(\snare).stop;

(
Pdef(\kick, Pbind(\instrument, \sampler,
	\dur, Prand([1/4], inf),
	\pan, Prand([0.5,0.5, 0.5], inf),
	\timbre, Pwhite(1.0, 1.0, inf),
	\bufnum, Prand([4], inf),
	\amp, Prand([0.3], inf))).play;
)

*/

