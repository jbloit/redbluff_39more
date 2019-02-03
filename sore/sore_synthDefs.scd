////////////////////////////////////////////// WHISPERING BASS

// ~samplesDir = "/home/pi/prynth/server/public/soundfiles";
~samplesDir = "/home/jbloit/Dropbox/sounds/ASMR";
~asmrAudioCues = [5.72, 59.0, 19.187, 26.592];
~asmrBuf = Array.fill(~asmrAudioCues.size, {|i|
	var startSample, numFrames, cues;
	cues = [];
	startSample = 44100 * ~asmrAudioCues[i];
	numFrames = 44100 * 2;
	Buffer.read(s, ~samplesDir +/+ "japaneseASMR_mono.wav", startSample, numFrames);
});


// The whisper sampler
SynthDef(\asmr, {|out=0, sendBus=0, bufnum=0, loop=0, amp=0.2|
	var sig;
	sig = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), loop:loop, doneAction:4);
	Out.ar(out, sig*amp!2);
	Out.ar(sendBus, sig);
}).add;

// The bass whose level is modulated from another source's envelope
SynthDef(\bassmr, {|out=0, in=0, freq=90, amp=1, atk=0.1, rel=0.1, sens=1.0|

	var env;
	env = Amplitude.kr(In.ar(in) * sens, atk, rel);
	Out.ar(out, LFPar.ar(freq, mul:env * amp)!2);
}
).add;


//////////////////////////////////////////////  PATTERNING SYNTH


SynthDef(\arp, {|out=0, freq=55, detune=0.3, f0=6, f1=2.7, w0=0.98, phasing=0, legato=0.5, amp=1|
	var sig, env, env2, trig, sig2;
	trig = Pulse.ar(f0, w0);
	env = EnvGen.ar(Env.adsr(releaseTime:SinOsc.ar(f1, 0, 1, legato)), trig).lag(0.01);
	env2 = DelayC.ar(env, 1, phasing);

	// experiment replacing oscillators (LFPulse, LFCub, LFTri, LFSaw, etc)
	sig = LFPar.ar([freq, freq*2], mul:0.5);
	sig2 = LFPulse.ar([freq, freq*2] + detune.linlin(0, 1, 0, 3), mul:0.1);
	Out.ar(out, Splay.ar([sig * env, sig2 * env2]*amp));
}).add;


/*
Ndef(\arp).play

Ndef(\arp).set(\amp, 0.2)
Ndef(\arp).set(\freq, 60, \legato, 0.1, \f1, 2.7)
Ndef(\arp).set(\freq, 63, \legato, 0.9, \f1, 2)
Ndef(\arp).set(\freq, 60, \legato, 0.01, \f1, 2.7)
Ndef(\arp).set(\freq, 63, \legato, 0.9, \f1, 2)
Ndef(\arp).set(\freq, 50, \legato, 0.9, \f1, 2)
Ndef(\arp).set(\freq, 50, \detune, 0.3, \legato, 0.9, \f1, 2)
Ndef(\arp).set(\freq, 50, \detune, 0.1, \legato, 0.9, \f1, 2)
Ndef(\arp).set(\freq, 50, \detune, 0.9, \legato, 0.9, \f1, 2)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.9, \f1, 2)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.9, \f0, 6, \f1, 4)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.9, \f0, 6, \f1, 5)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.9, \f0, 8, \f1, 5)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.7, \f0, 8, \f1, 5)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.6, \f0, 8, \f1, 5)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.6, \f0, 8, \f1, 6)
Ndef(\arp).set(\freq, 60, \detune, 0.2, \legato, 0.6, \f0, 8, \f1, 6)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.6, \f0, 8, \f1, 6)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.6, \f0, 8, \f1, 7)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.5, \f0, 8, \f1, 7)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.1, \f0, 8, \f1, 7, \w0, 0.98)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.1, \f0, 8, \f1, 7, \w0, 0.8)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.1, \f0, 8, \f1, 7, \w0, 0.92)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.1, \f0, 8, \f1, 7, \w0, 0.94)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.1, \f0, 8, \f1, 14, \w0, 0.94, \phasing, 0)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.1, \f0, 8, \f1, 14, \w0, 0.94, \phasing, 0.25)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.1, \f0, 8, \f1, 14, \w0, 0.94, \phasing, 0.125)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.1, \f0, 8, \f1, 14, \w0, 0.94, \phasing, 0.5)
Ndef(\arp).set(\freq, 50, \detune, 0.7, \legato, 0.9, \f0, 8, \f1, 14, \w0, 0.94, \phasing, 0.5)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.1, \f0, 8, \f1, 14, \w0, 0.94, \phasing, 0.5)
Ndef(\arp).set(\freq, 40, \detune, 0.3, \legato, 0.1, \f0, 8, \f1, 14, \w0, 0.94, \phasing, 0.5)
Ndef(\arp).set(\freq, 60, \detune, 0.1, \legato, 0.1, \f0, 8, \f1, 14, \w0, 0.94, \phasing, 0.5)
Ndef(\arp).set(\freq, 60, \detune, 0.1, \legato, 0.8, \f0, 8, \f1, 13, \w0, 0.94, \phasing, 0.5)
Ndef(\arp).set(\freq, 200, \detune, 0.1, \legato, 0.1, \f0, 8, \f1, 13, \w0, 0.8, \phasing, 0.5)
Ndef(\arp).set(\freq, 8888, \detune, 0, \legato, 0.1, \f0, 8, \f1, 13, \w0, 0.9, \phasing, 0.125)
Ndef(\arp).set(\freq, 8888, \detune, 0, \legato, 0.1, \f0, 16, \f1, 18, \w0, 0.9, \phasing, 0.5)

Ndef(\arp).free
Ndef(\arp).play
*/