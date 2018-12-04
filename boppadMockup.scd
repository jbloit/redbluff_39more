
///////////////////////////////////////////////////////////////////////////// INIT SAMPLER FOR MOCKUP

Buffer.freeAll;
~samplesDir = thisProcess.nowExecutingPath.dirname +/+"RedBluffAcousticDrums";

SynthDef(\sampler, {
	|out=0, bufnum=0, amp=0.3, rate=1, timbre=1, pan=0.5|
	var sig, sigfilt;
	sig = PlayBuf.ar(1, bufnum, rate * BufRateScale.kr(bufnum), doneAction:2);
	sigfilt = BPF.ar(sig, timbre.clip(0,1).linexp(0, 1, 100, 10000), 0.3);
	sig = Mix.ar([sig*0.5, sigfilt*0.9]);
	Out.ar(out, Pan2.ar(sig*amp, pan.linlin(0.0, 1.0, -1.0, 1.0)));
}).add;



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
MIDIdef.noteOn(\noteOnTest, {
	|vel, nn, chan |
	switch(chan,
		0, {~armKick = true; ~velKick = vel;}
	);

	postf("note %, vel %, chan % \n", nn, vel, chan);
/*


	switch (chan,
		0, {Synth(\sampler, [\bufnum, ~kickBuffers[]]},
	);*/
	// Synth(\sampler, [\bufnum, ~percBuffers[nn], \amp, vel.linlin(0, 127, 0.0, 1.0)]);

};
);

MIDIdef.noteOff(\noteOffTest, {
	|vel, nn |
	// [vel, nn].postln;
};
);

MIDIdef.cc(\ccTest, {
 |val, num, chan|

	switch(chan,
		0, {
			if (~armKick && (num == 2), {

				Synth(\sampler, [\bufnum, ~kickBuffers[val.linlin(0, 127, 0, 2)], \amp, ~velKick.linlin(0, 127, 0, 1)]);
				postf("val % num % chan % \n", val, num, chan);
				~armKick = false;
			};
			)
		};
	);

});

