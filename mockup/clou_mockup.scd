
// ----------------------------------------- INIT SAMPLER FOR MOCKUP
(
Buffer.freeAll;
~samplesDir = thisProcess.nowExecutingPath.dirname;

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
	sig = PlayBuf.ar(1, bufnum, rate * BufRateScale.kr(bufnum), doneAction:2);
	sigfilt = BPF.ar(sig, timbre.clip(0,1).linexp(0, 1, 100, 10000), 0.3);
	sig = Mix.ar([sig*0.5, sigfilt*0.9]);
	Out.ar(out, Pan2.ar(sig*amp, pan.linlin(0.0, 1.0, -1.0, 1.0)));
}).add;

BfRd


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

TempoClock.tempo = 0.4;
)

//-------------------------------------------- STEP THROUGH SECTIONS & CUES

(
~currentSection = 0;
~sections[~currentSection].value();
)

(
~curentCue = 0;
~cues[~currentSection, ~currentCue].value();
)


(
Pdef(\kick, Pbind(\instrument, \sampler, \dur, 1/16,  \isRest,Pseq([1,0,0,1,0,0,1,1,0,0],inf).coin.not, \amp, 0.2, \bufnum, 0, \pan, 0.5, \synth, Pfunc({arg event; ~trigs[0,0].value(1, event[\isRest].not.asInt / 10)}))).play(quant:1);

Pdef(\snare, Pbind(\instrument, \sampler, \dur, 1/16,  \isRest,Pseq([0,0,1,0,0,1,0,0,1,0],inf).coin.not, \amp, 0.2, \bufnum, 1, \pan, 0.5)).play(quant:1);

// Pdef(\tom, Pbind(\instrument, \sampler, \dur, 1/16,  \isRest,Pseq([0,1,0,0,0,0,0,0,0,1],inf).coin.not, \amp, 0.2, \bufnum, 2, \pan, 0.5)).play(quant:1);

Pdef(\tom, Pbind(\instrument, \sampler, \dur, 1/16,  \isRest,Pseq([0,1,0,0,0,0,0,0,0,1],inf).coin.not, \amp, 0.2, \bufnum, 2, \pan, 0.5, \synth, Pfunc({arg event; ~trigs[0,0].value(4, event[\isRest].not.asInt / 5)}))).play(quant:1);

)


// Pfunc({arg ev; ~patternEvent.value(0, ev[\amp])}

(
~cueChange.value(1);
)