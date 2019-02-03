
///////////////////////////////////////////////////////////////////////////// INIT SAMPLER FOR MOCKUP

~samplesDir = thisProcess.nowExecutingPath.dirname +/+"RedBluffAcousticDrums";

~busVerb = Bus.audio(s,2);

SynthDef(\sampler, {
	|out=0, bufnum=0, amp=0.3, rate=1, timbre=1, pan=0.5|
	var sig, sigfilt;
	sig = PlayBuf.ar(1, bufnum, rate * BufRateScale.kr(bufnum), doneAction:2);
	sigfilt = BPF.ar(sig, timbre.clip(0,1).linexp(0, 1, 100, 10000), 0.3);
	sig = Mix.ar([sig*0.5, sigfilt*0.9]);
	sig = Pan2.ar(sig*amp, pan.linlin(0.0, 1.0, -1.0, 1.0));
	Out.ar(out, sig);
	Out.ar(~busVerb.index, sig);
}).add;

SynthDef(\verb, {|in=3, out=0, wet=0.4|
	Out.ar(out, GVerb.ar(In.ar(~busVerb.index, 2), drylevel:1-wet));
}).add;

~verb = Synth(\verb, [\wet, 0.5]);

// PICK RANDOM SAMPLES
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

/////////////////////////////////////////////////////////////////////////// MIDI IN

MIDIClient.init;
MIDIIn.connectAll;

// MIDIFunc.trace;
// to turn tracing off:
MIDIFunc.trace( false );

~armKick = false;
~velKick = 0;

~armSnare = false;
~velSnare = 0;

~armHat = false;
~velHat = 0;

~armTom = false;
~velTom = 0;

MIDIdef.noteOn(\noteOnPad, {
	|vel, nn, chan |
	switch(chan,
		0, {~armKick = true; ~velKick = vel;},
		1, {~armSnare = true; ~velSnare = vel;},
		2, {~armHat = true; ~velHat = vel;},
		3, {~armTom = true; ~velTom = vel;}
	);

	// postf("note %, vel %, chan % \n", nn, vel, chan);
	/*


	switch (chan,
	0, {Synth(\sampler, [\bufnum, ~kickBuffers[]]},
	);*/
	// Synth(\sampler, [\bufnum, ~percBuffers[nn], \amp, vel.linlin(0, 127, 0.0, 1.0)]);

};
);

MIDIdef.noteOff(\noteOffPad, {
	|vel, nn |
	// [vel, nn].postln;
};
);

MIDIdef.cc(\ccPad, {
	|val, num, chan|

	// Doing the triggering on CC because I need the CC info to know which sample to play. But CC only come AFTER the
	// noteOn message...

	switch(chan,
		0, {
			if (~armKick && (num == 2), {
				Synth(\sampler, [\bufnum, ~kickBuffers[val.linlin(0, 127, 0, 2)], \amp, ~velKick.linlin(0, 127, 0, 2)]);
				~armKick = false;
			};
			)
		},
		1, {
			if (~armSnare && (num == 2), {
				Synth(\sampler, [\bufnum, ~snareBuffers[val.linlin(0, 127, 0, 2)], \amp, ~velSnare.linlin(0, 127, 0, 1)]);
				~armSnare = false;
			};
			)
		},
		2, {
			if (~armHat && (num == 2), {
				Synth(\sampler, [\bufnum, ~hatBuffers[val.linlin(0, 127, 0, 2)], \amp, ~velHat.linlin(0, 127, 0, 1)]);
				~armHat = false;
			};
			)
		},

		3, {
			if (~armTom && (num == 2), {
				Synth(\sampler, [\bufnum, ~tomBuffers[val.linlin(0, 127, 0, 2)], \amp, ~velTom.linlin(0, 127, 0, 1)]);
				~armTom = false;
			};
			)
		}
	);

});


