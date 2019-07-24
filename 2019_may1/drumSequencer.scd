
s.latency = 0.8;
s.reboot;


///////////////////////////////////////////////////////////////////////////// INIT SAMPLER FOR MOCKUP
(

MIDIClient.init;
m = MIDIOut(1).latency = 0.8;


// for sequencing to a synth and to a midi device at the same time
Event.addEventType(\midisynth, { |server|
	Event.eventTypes[\note].value(server);
	Event.eventTypes[\midi].value(server);
});



t = TempoClock.tempo = 70/60;

~fxBus0 = Bus.audio(s, 1);
~fxBus1 = Bus.audio(s, 1);
~fxBus2 = Bus.audio(s, 1);


//~samplesDir = thisProcess.nowExecutingPath.dirname +/+"../RedBluffAcousticDrums";
~samplesDir = "/Users/bloit/repos/redbluff_39more/RedBluffAcousticDrums";
SynthDef(\sampler, {
	|out=0, bufnum=0, amp=0.3, rate=1, timbre=1, pan=0.5, gate=1|
	var sig, sigfilt, env;
	sig = PlayBuf.ar(1, bufnum, rate * BufRateScale.kr(bufnum));
	env = EnvGen.ar(Env.adsr, gate, doneAction:2);
	sig = sig * env * amp;
	sigfilt = BPF.ar(sig, timbre.clip(0,1).linexp(0, 1, 100, 10000), 0.3);
	sig = Mix.ar([sig*0.5, sigfilt*0.9]);
	// sig = Pan2.ar(sig*amp, pan.linlin(0.0, 1.0, -1.0, 1.0));


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


////////////////////////////////////  PATTERNS

(
// KICK
Pdef(\p,
	Pbind(
		\type, \midisynth,

		// synth
		\instrument, \sampler,
		\dur, Pseq([1], inf),
		\pan, 1,
		\timbre, 0,
		\bufnum, 2,
		\amp, 1,
		\out, 0,

		// midi
		\midicmd, \noteOn,
		\midiout, m,
		\chan, 0,
		\note, 0,
		\legato, Pwhite(0.1, 1),
		\octave, 1,
));
// SNARE
Pdef(\q,
	Pbind(
		\type, \midisynth,

		// synth
		\instrument, \sampler,
		\dur, Pseq([Rest(0.5), 2, 1/4], inf),
		\pan, 1,
		\timbre, 0,
		\bufnum, 4,
		\amp, 0.3,
		\out, 1,

		// midi
		\midicmd, \noteOn,
		\midiout, m,
		\chan, 1,
		\note, 0,
		\legato, Pwhite(0.1, 1),
		\octave, 1,
));
// HAT
Pdef(\r,
	Pbind(

		\type, \midisynth,

		// synth
		\instrument, \sampler,
		\dur, Pseq([1/8], inf),
		\pan, 0.5,
		// \timbre, Pseq([0,0.5, 0.8, 0.2, 1], inf),
		\bufnum, 6,
		// \amp, Pseq((0..3)/20.0, inf),
		\out, 2,


		// midi
		\midicmd, \noteOn,
		\midiout, m,
		\chan, 2,
		\note, 0,
		\legato, Pwhite(0.1, 1),
		\octave, 1,

));
)



///// PLAY
(
Pdef(\p).play(quant:1);
Pdef(\q).play(quant:1);
Pdef(\r).play(quant:1);
)

////////////////// 2


(
// KICK
Pdef(\p,
	Pbind(
		\type, \midisynth,

		// synth
		\instrument, \sampler,
		\dur, Pseq([1/4, Rest(1/2)], inf),
		\pan, 1,
		\timbre, 0,
		\bufnum, 2,
		\amp, 1,
		\out, 0,

		// midi
		\midicmd, \noteOn,
		\midiout, m,
		\chan, 0,
		\note, 0,
		\legato, Pwhite(0.1, 0.9),
		\octave, 1,
));
// SNARE
Pdef(\q,
	Pbind(
		\type, \midisynth,

		// synth
		\instrument, \sampler,
		\dur, Pseq([Rest(0.5), 2, 1/8, 1/4], inf),
		\pan, 1,
		\timbre, 0,
		\bufnum, 4,
		\amp, 0.3,
		\out, 1,

		// midi
		\midicmd, \noteOn,
		\midiout, m,
		\chan, 1,
		\note, 0,
		\legato, Pwhite(0.1, 0.9),
		\octave, 1,
));
// HAT
Pdef(\r,
	Pbind(

		\type, \midisynth,

		// synth
		\instrument, \sampler,
		\dur, Pseq([1/8], inf),
		\pan, 0.5,
		// \timbre, Pseq([0,0.5, 0.8, 0.2, 1], inf),
		\bufnum, 6,
		// \amp, Pseq((0..3)/20.0, inf),
		\out, 2,


		// midi
		\midicmd, \noteOn,
		\midiout, m,
		\chan, 2,
		\note, 0,
		\legato, Pwhite(0.1, 0.9),
		\octave, 1,

));
)











///// STOP
(
Pdef(\p).stop;
Pdef(\q).stop;
Pdef(\r).stop;
m.allNotesOff(0);


m.allNotesOff(1);

)
