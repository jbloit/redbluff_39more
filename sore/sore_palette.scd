////////////////////////////////////////////// BASS CHOP

(

~dcBus = Bus.control(s, 1);

/*SynthDef(\dc, {|val=0, out=0|
	Out.kr(out, DC.kr(val););
}).add;*/


~sine = Buffer.alloc(s, 512, 1, {arg buf; buf.sine1Msg(1.0/[1,2,3,4,5,6,7,8,9,10])});

SynthDef(\bassChop, {
	|in=0, out=0, freq=60, chopFreq = 2, amp=1, atk=0.1, dec=0.1, sus=0.8, rel=0.1, curve=9, beating=0.1, width=0.5|
	var sig, env, pulseEnv, pulseTrig;

	pulseTrig = Pulse.ar(chopFreq, width);
	pulseEnv = EnvGen.ar(Env.adsr(atk, dec, sus, rel, curve:curve), pulseTrig);
	env = Select.ar(chopFreq, [DC.ar(1), pulseEnv]);

	sig =  COsc.ar(~sine.bufnum, freq, beating, env.lag(0.05));

	Out.ar(out, sig*amp!2);
}).add;

)

// ------ INIT
(
~chopper=Synth(\bassChop);
~chopper.map(\chopFreq, ~dcBus.index);
~dcBus.set(5);
)

// ------ MODULATE

(
// single note
~freqChop = 0;
~dcBus.set(~freqChop);
~chopper.set(\amp, 0.1, \atk, 0.01/~freqChop, \dec, 0.3/~freqChop, \rel, 0.2/~freqChop, \curve, -3, \freq, 60, \beating, 0.3);
)

(
~freqChop = 5;
~dcBus.set(~freqChop);
~chopper.set(\amp, 0.1, \atk, 0.01/~freqChop, \dec, 0.1/~freqChop, \rel, 0.1/~freqChop, \curve, -3, \freq, 60, \beating, 0.3, \width, 0.6);
)

(
// higher width creates some patterning effect
~freqChop = 8;
~dcBus.set(~freqChop);
~chopper.set(\amp, 0.1, \atk, 0.01/~freqChop, \dec, 0.1/~freqChop, \rel, 0.1/~freqChop, \curve, -3, \freq, 70, \beating, 0.4, \width, 0.9);
)

(
~freqChop = 8;
~dcBus.set(~freqChop);
~chopper.set(\amp, 0.1, \atk, 0.01/~freqChop, \dec, 0.1/~freqChop, \rel, 0.1/~freqChop, \curve, -3, \freq, 60, \beating, 0.3, \width, 0.8);
)

(
~freqChop = 10;
~dcBus.set(~freqChop);
~chopper.set(\amp, 0.1, \atk, 0.01/~freqChop, \dec, 0.1/~freqChop, \rel, 0.1/~freqChop, \curve, -3, \freq, 60, \beating, 0.3, \width, 0.8);
)


(
// RONRON 1
~freqChop = 18;
~dcBus.set(~freqChop);
~chopper.set(\amp, 0.2, \atk, 0.01/~freqChop, \dec, 0.1/~freqChop, \rel, 0.1/~freqChop, \curve, 3, \freq, 50, \beating, 0.4, \width, 0.8);
)

(
// RONRON 2
~freqChop = 30;
~dcBus.set(~freqChop);
~chopper.set(\amp, 0.5, \atk, 0.01/~freqChop, \dec, 0.1/~freqChop, \rel, 0.1/~freqChop, \curve, 3, \freq, 40, \beating, 0.4, \width, 0.8);
)

(
// RONRON 2
~freqChop = 25;
~dcBus.set(~freqChop);
~chopper.set(\amp, 0.5, \atk, 0.01/~freqChop, \dec, 0.1/~freqChop, \rel, 0.1/~freqChop, \curve, 3, \freq, 40, \beating, 0.4, \width, 0.9);
)


(
// RONRON AIGU
~freqChop = 18;
~dcBus.set(~freqChop);
~chopper.set(\amp, 0.1, \atk, 0.01/~freqChop, \dec, 0.1/~freqChop, \rel, 0.1/~freqChop, \curve, 3, \freq, 8888, \beating, 0.4, \width, 0.8);
)
(
// NOTE AIGU
~freqChop = 0;
~dcBus.set(~freqChop);
~chopper.set(\amp, 0.1, \atk, 0.01/~freqChop, \dec, 0.1/~freqChop, \rel, 0.1/~freqChop, \curve, 3, \freq, 8888, \beating, 0.4, \width, 0.8);
)


(
// could modulate width, and freqChop?
)



(
~chopper.set(\amp, 0);
)

////////////////////////////////////////////// WIGGLES
(
play {
    DynKlang.ar(`[
        [800, 1000, 1200] + SinOsc.kr([2, 3, 4.2], 0, [13, 24, 12]),
        [0.3, 0.3, 0.3],
        [pi,pi,pi]!2
    ]
) * 0.1
};
)


(
SynthDef(\wiggle, {|out=0, gate=1, amp=0.1, freq=800|
	var sig, env;

	env = EnvGen.ar(Env.perc, gate, amp, 0, 1, 2);

	sig =  DynKlang.ar(`[
        [freq, freq*1.25, freq*1.5] + SinOsc.kr([2, 3, 4.2], 0, [13, 24, 12]),
        [0.3, 0.3, 0.3],
        [pi,pi,pi]!2
	]);

	Out.ar(out, sig*env);
}).add;

)

(
Synth(\wiggle, [\freq, 900]);
)

(
Synth(\wiggle, [\freq, 500]);
)

(
Synth(\wiggle, [\freq, 1300]);
)


////////////////////////////////////////////// WHISPERING BASS

//TODO: polyphonic looper, with N voices of (asmr +  bassmr) couples, each one with ite note. Creates interesting bass patterns.

(
~samplesDir = "/Users/bloit/Dropbox/redbluff_transfer/ASMR/ASMR Project/";
~asmrBuf = Array.fill(20, {|i|
	var startSample, numFrames;
	startSample = 44100 * i;
	numFrames = 44100 * 2;
	Buffer.read(s, ~samplesDir +/+ "japaneseASMR_mono.wav", startSample, numFrames);
});

)

~asmrBuf[19].bufnum
~asmrBuf[0].bufnum
(
// The whisper sampler
SynthDef(\asmr, {|out=0, sendBus=0, bufnum=0, loop=1, amp=0.2|
	var sig;
	sig = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), loop:loop);
	Out.ar(out, sig*amp!2);
	Out.ar(sendBus, sig);
}).add;

// The bass whose level is modulated from another source's envelope
SynthDef(\bassmr, {|out=0, in=0, freq=60, amp=1, atk=0.1, rel=0.1, sens=1.0|
	var env;
	env = Amplitude.kr(In.ar(in) * sens, atk, rel);
	Out.ar(out, LFPar.ar(freq, mul:env * amp)!2);
}
).add
)

// ------ INIT
(
~asmrOut = Bus.audio(s, 1);
~asmr = Synth(\asmr, [\bufnum, ~asmrBuf[19].bufnum, \sendBus, ~asmrOut.index, \out, 5]);
~bassmr = Synth.after(~asmr, \bassmr, [\amp, 0, \in, ~asmrOut.index, \out, 0]);
~asmr.set(\out, 0, \amp, 0.1)
)


(
~bassmr.set(\rel, 1, \atk, 0.3, \amp, 1, \freq, 4000);
~asmr.set(\out, 0, \amp, 0.1);
)

(
~bassmr.set(\rel, 1, \atk, 0.3, \amp, 4, \freq, 60);
~asmr.set(\out, 0, \amp, 0.1);
)


(
~bassmr.set(\sens, 0.8);
~asmr.set(\out, 0, \amp, 0.1);
)


//////////////////////////////////////////////  PATTERNING SYNTH

(
Ndef(\arp, {|out=0, freq=55, detune=0.3, f0=6, f1=2.7, w0=0.98, phasing=0, legato=0.5, amp=1|
	var sig, env, env2, trig, sig2;
	trig = Pulse.ar(f0, w0);
	env = EnvGen.ar(Env.adsr(releaseTime:SinOsc.ar(f1, 0, 1, legato)), trig).lag(0.01);
	env2 = DelayC.ar(env, 1, phasing);

	// experiment replacing oscillators (LFPulse, LFCub, LFTri, LFSaw, etc)
	sig = LFPar.ar([freq, freq*2], mul:0.5);
	sig2 = LFPulse.ar([freq, freq*2] + detune.linlin(0, 1, 0, 3), mul:0.1);
	Out.ar(out, Splay.ar([sig * env, sig2 * env2]*amp));
});
)


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
