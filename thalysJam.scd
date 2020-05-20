(
Buffer.freeAll;
~linnDir = "/home/julien/Dropbox/sounds/LinnDrum LM-2/Normalized";
~bufs = Array.newClear;

// ~bufs = ~bufs.add(Buffer.read(s, ~linnDir+/+"HatClosed1.aif"));

~bufs = ~bufs.add(Buffer.read(s, "/home/julien/Dropbox/sounds/Surachai Modular Kit Preview/Drum One Shots/Hi Hats/Hi Hat 0002.aif"));

// ~bufs = ~bufs.add(Buffer.read(s, ~linnDir+/+"Kick.aif"));


~bufs = ~bufs.add(Buffer.read(s,"/home/julien/Dropbox/sounds/Surachai Modular Kit Preview/Drum One Shots/Kicks/Kick 0027.aif" ));


// ~bufs = ~bufs.add(Buffer.read(s, ~linnDir+/+"HatOpen.aif"));
~bufs = ~bufs.add(Buffer.read(s,  "/home/julien/Dropbox/sounds/Surachai Modular Kit Preview/Drum One Shots/Percussion/Percussion 0037.aif"));


~bufs = ~bufs.add(Buffer.read(s, "/home/julien/Dropbox/sounds/DataBending/david_these_v5_2.wav"));

~bufs = ~bufs.add(Buffer.read(s,"/home/julien/Dropbox/sounds/DataBending/blipGlitch_comic_book.wav"));


~bufs = ~bufs.add(Buffer.read(s,"/home/julien/Dropbox/sounds/Surachai Modular Kit Preview/Single Note Synths/Synth Shot 0010.aif"));

~bufs = ~bufs.add(Buffer.read(s,"/home/julien/Dropbox/sounds/Surachai Modular Kit Preview/Pads/Pad 120 BPM 0007.aif"));



~bufs.size;

)


(
SynthDef(\sampler, {
	|out=0, bufnum=0, amp=0.3, rate=1, pan=0|
	var sig;
	sig = PlayBuf.ar(1, bufnum, rate * BufRateScale.kr(bufnum), doneAction:2);
	Out.ar(out, Pan2.ar( sig*amp, pan));
}).add;
)


a = Synth(\sampler, [\bufnum, ~bufs[0].bufnum, \amp, 0.1]);
b = Synth(\sampler, [\bufnum, ~bufs[1].bufnum]);
c = Synth(\sampler, [\bufnum, ~bufs[2].bufnum]);
d = Synth(\sampler, [\bufnum, ~bufs[3].bufnum]);
d = Synth(\sampler, [\bufnum, ~bufs[4].bufnum]);
d = Synth(\sampler, [\bufnum, ~bufs[5].bufnum]);
d = Synth(\sampler, [\bufnum, ~bufs[6].bufnum]);

(
Pdef(\t1,
	Pbind(\instrument, \sampler,
		\bufnum, ~bufs[0].bufnum,
		\dur, Pseq([1/8], inf),
		\isRest, Pseq([1, 1 , 1, 0, 0, 1,1, 0, 0, 0, 0, 1, 1, 0, 1,0], inf).coin.not,
		\amp, Pseq([0.3, 0.05], inf)
	)
).play;

)

(
Pdef(\t1,
	Pbind(\instrument, \sampler,
		\bufnum, ~bufs[0].bufnum,
		\dur, Pseq([1/8], inf),
		\isRest, Pseq([1, 1 , 1, 0, 0, 1,1, 0, 0, 0, 0, 1, 1, 0, 1,0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 0 , 0, 1, 1], inf).coin.not,
		\amp, Pseq([0.3, 0.05], inf)
	)
).play;

)

(
Pdef(\t1,
	Ppar([

	Pbind(\instrument, \sampler,
		\bufnum, ~bufs[0].bufnum,
			\dur, Pseq([1/8], inf),
		\isRest, Pseq([1, 1 , 1, 0, 0, 1,1, 0, 0, 0, 0, 1, 1, 0, 1,0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 0 , 0, 1, 1], inf).coin.not,
			\amp, Pseq([0.3, 0.05], inf)
	),

	Pbind(\instrument, \sampler,
			\bufnum, ~bufs[1].bufnum,
		\dur, Pseq([2], inf),
		\isRest, Pseq([1], inf).coin.not,
	)])
).play;

)




(
Pdef(\t1,
	Ppar([

	Pbind(\instrument, \sampler,
		\bufnum, ~bufs[0].bufnum,
			\dur, Pseq([1/8], inf),
		\isRest, Pseq([1, 1 , 1, 0, 0, 1,1, 0, 0, 0, 0, 1, 1, 0, 1,0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 0 , 0, 1, 1], inf).coin.not,
			\amp, Pseq([0.3, 0.05], inf)
	),

	Pbind(\instrument, \sampler,
			\bufnum, ~bufs[1].bufnum,
		\dur, Pseq([2], inf),
		\isRest, Pseq([1], inf).coin.not,
	),

	Pbind(\instrument, \sampler,
			\bufnum, ~bufs[2].bufnum,
			\dur, Pseq([3], inf),
		\amp, 0.05,
			\isRest, Pseq([1], inf).coin.not,
	),
	]
	)
).play;
)


(
Pdef(\t1,
	Ppar([

	Pbind(\instrument, \sampler,
		\bufnum, ~bufs[0].bufnum,
			\dur, Pseq([1/8], inf),
		\isRest, Pseq([1, 1 , 1, 0, 0, 1,1, 0, 0, 0, 0, 1, 1, 0, 1,0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 0 , 0, 1, 1], inf).coin.not,
			\amp, Pseq([0.1, 0.05], inf)
	),

	Pbind(\instrument, \sampler,
			\bufnum, ~bufs[1].bufnum,
		\dur, Pseq([2], inf),
		\isRest, Pseq([1], inf).coin.not,
	),

	Pbind(\instrument, \sampler,
			\bufnum, ~bufs[2].bufnum,
			\dur, Pseq([3], inf),
		\amp, 0.05,
			\isRest, Pseq([1], inf).coin.not,
	),

		Pbind(\instrument, \sampler,
			\bufnum, ~bufs[3].bufnum,
			\dur, Pseq([1], inf),
		\amp, 0.05,
			\isRest, Pseq([1], inf).coin.not,
	),
	]
	)
).play;
)

(
Pdef(\t1,
	Ppar([

	Pbind(\instrument, \sampler,
		\bufnum, ~bufs[0].bufnum,
			\dur, Pseq([1/8], inf),
		\isRest, Pseq([1, 1 , 1, 0, 0, 1,1, 0, 0, 0, 0, 1, 1, 0, 1,0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 0 , 0, 1, 1], inf).coin.not,
			\amp, Pseq([0.1, 0.05], inf)
	),

	Pbind(\instrument, \sampler,
			\bufnum, ~bufs[1].bufnum,
		\dur, Pseq([2], inf),
		\isRest, Pseq([1], inf).coin.not,
	),

	Pbind(\instrument, \sampler,
			\bufnum, ~bufs[2].bufnum,
			\dur, Pseq([3], inf),
		\amp, 0.05,
			\isRest, Pseq([1], inf).coin.not,
	),

		Pbind(\instrument, \sampler,
			\bufnum, ~bufs[3].bufnum,
			\dur, Pseq([1], inf),
		\amp, 0.05,
			\isRest, Pseq([1], inf).coin.not,
	),

		Pbind(\instrument, \sampler,
			\bufnum, ~bufs[4].bufnum,
			\dur, Pseq([1/8, Rest(2)], inf),
		\amp, 0.05
	),
	]
	)
).play;
)
(
Pdef(\t1,
	Ppar([

	Pbind(\instrument, \sampler,
		\bufnum, ~bufs[0].bufnum,
			\dur, Pseq([1/8], inf),
		\isRest, Pseq([1, 1 , 1, 0, 0, 1,1, 0, 0, 0, 0, 1, 1, 0, 1,0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 0 , 0, 1, 1], inf).coin.not,
			\amp, Pseq([0.1, 0.05], inf),
			\pan, Pseq([-0.5, 0.5], inf),
	),

	Pbind(\instrument, \sampler,
			\bufnum, ~bufs[1].bufnum,
		\dur, Pseq([2], inf),
		\isRest, Pseq([1], inf).coin.not,
	),

	Pbind(\instrument, \sampler,
			\bufnum, ~bufs[2].bufnum,
			\dur, Pseq([3], inf),
		\amp, 0.05,
			\isRest, Pseq([1], inf).coin.not,
	),

		Pbind(\instrument, \sampler,
			\bufnum, ~bufs[3].bufnum,
			\dur, Pseq([1], inf),
		\amp, 0.05,
			\isRest, Pseq([1], inf).coin.not,
	),

		Pbind(\instrument, \sampler,
			\bufnum, ~bufs[4].bufnum,
			\dur, Pseq([1/8, Rest(2)], inf),
		\amp, 0.05
	),
	]
	)
).play;
)
(
Pdef(\t1,
	Ppar([

	Pbind(\instrument, \sampler,
		\bufnum, ~bufs[0].bufnum,
			\dur, Pseq([1/8], inf),
		\isRest, Pseq([1, 1 , 1, 0, 0, 1,1, 0, 0, 0, 0, 1, 1, 0, 1,0, 1, 0, 0, 0, 1, 0, 1, 1, 0, 0 , 0, 1, 1], inf).coin.not,
			\amp, Pseq([0.1, 0.05], inf),
			\pan, Pseq([-0.5, 0.5], inf),
	),

	Pbind(\instrument, \sampler,
			\bufnum, ~bufs[1].bufnum,
		\dur, Pseq([1/3], inf),
		\isRest, Pseq([1, 0, 1], inf).coin.not,
	),

	Pbind(\instrument, \sampler,
			\bufnum, ~bufs[2].bufnum,
			\dur, Pseq([3], inf),
		\amp, 0.05,
			\isRest, Pseq([1], inf).coin.not,
	),

		Pbind(\instrument, \sampler,
			\bufnum, ~bufs[3].bufnum,
			\dur, Pseq([1], inf),
		\amp, 0.05,
			\isRest, Pseq([1], inf).coin.not,
	),

		Pbind(\instrument, \sampler,
			\bufnum, ~bufs[4].bufnum,
			\dur, Pseq([1/8, Rest(2)], inf),
		\amp, 0.05
	),

		Pbind(\instrument, \sampler,
			\bufnum, ~bufs[6].bufnum,
			\dur, Pseq([4, Rest(4)], inf),
		\amp, 0.05
	),
	]
	)
).play;
)




Pdef(\t1).stop