
///////////////////////////////////////////////////////////////////////////// INIT SAMPLER FOR MOCKUP
(
Buffer.freeAll;
~samplesDir = thisProcess.nowExecutingPath.dirname +/+".."+/+"samples";

~drumDirs = [
PathName.new(~samplesDir +/+ "Kick"),
PathName.new(~samplesDir +/+ "Snare"),
PathName.new(~samplesDir +/+ "Tom"),
];

~samplerTrigged = {|i|
	"sdfsdf".postln;
	i.postln;
};

SynthDef(\sampler, {
	|out=0, bufnum=0, amp=0.3, rate=1, timbre=1, pan=0.5|
	var sig, sigfilt;
	sig = PlayBuf.ar(2, bufnum, rate * BufRateScale.kr(bufnum), doneAction:2);
	sigfilt = BPF.ar(sig, timbre.clip(0,1).linexp(0, 1, 100, 10000), 0.3);
	sig = Mix.ar([sig*0.5, sigfilt*0.9]);
	Out.ar(out, Pan2.ar(sig*amp, pan.linlin(0.0, 1.0, -1.0, 1.0)));
}).add;



// PICK RANDOM SAMPLES
Buffer.freeAll;
~percBuffers= Array.new;
// ~percBuffers.clear;
3.do({|i|
	i.postln;
	~percBuffers = ~percBuffers.add(Buffer.read(s, ~drumDirs[i].entries[4].fullPath));
});


// print picked samples
(~percBuffers.size).do{|i|
	~percBuffers[i].path.postln;
};
)


/////////////////////////////////////////////////////////////////////////// MIDI IN
(
MIDIClient.init;
MIDIIn.connectAll;

// MIDIFunc.trace;
// to turn tracing off:
// MIDIFunc.trace( false );

MIDIdef.noteOn(\noteOnTest, {
	|vel, nn |
	Synth(\sampler, [\bufnum, ~percBuffers[nn], \amp, vel.linlin(0, 127, 0.0, 1.0)]);

};
);

MIDIdef.noteOff(\noteOffTest, {
	|vel, nn |
	// [vel, nn].postln;
};
);

MIDIdef.cc(\ccTest, {
	|val|
	// val.postln;
};);
)

Synth(\sampler, [\bufnum, ~percBuffers[1].bufnum])
