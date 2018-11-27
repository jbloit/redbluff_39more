////////////////////////////////////////////// BASS CHOP

(
i = Bus.audio(s, 1);

SynthDef(\pulse, {|out=0, freq=3, width=0.5|
	Out.ar(out, Pulse.ar(freq, width));
}
).add;

~sine = Buffer.alloc(s, 512, 1, {arg buf; buf.sine1Msg(1.0/[1,2,3,4,5,6,7,8,9,10])});

SynthDef(\bassChop, {
	|in=0, out=0, freq=60, amp=1, atk=0.1, dec=0.1, sus=0.8, rel=0.1, curve=9, beating=0.1|
	var sig, env;
	env = EnvGen.ar(Env.adsr(atk, dec, sus, rel, curve:curve), In.ar(in, 1));
	// sig = LFPar.ar(freq, mul:env);

	sig =  COsc.ar(~sine.bufnum, freq, beating, env);

	Out.ar(out, sig*amp!2);
}).add;

)
// ------ INIT
(
~pulse=Synth( \pulse, [\out, i.index]);
~chopper=Synth.after(~pulse,\bassChop, [\in, i.index, \amp, 0]);
)

(
~freqChop = 8 ;
~pulse.set(\freq, ~freqChop, \width, 0.5);
~chopper.set(\amp, 0.2, \atk, 0.01/~freqChop, \dec, 0.3/~freqChop, \rel, 0.2/~freqChop, \curve, -3, \freq, 60, \beating, 0.3)
)

(
~freqChop = 10 ;
~pulse.set(\freq, ~freqChop, \width, 0.5);
~chopper.set(\amp, 0.2, \atk, 0.01/~freqChop, \dec, 0.3/~freqChop, \rel, 0.2/~freqChop, \curve, -3, \freq, 60, \beating, 0.3)
)

(
~freqChop = 8 ;
~pulse.set(\freq, ~freqChop, \width, 0.5);
~chopper.set(\amp, 0.3, \atk, 0.01/~freqChop, \dec, 0.3/~freqChop, \rel, 0.2/~freqChop, \curve, -3, \freq, 40, \beating, 0.3)
)

(
~freqChop = 12 ;
~pulse.set(\freq, ~freqChop, \width, 0.5);
~chopper.set(\amp, 0.3, \atk, 0.01/~freqChop, \dec, 0.3/~freqChop, \rel, 0.2/~freqChop, \curve, -3, \freq, 80, \beating, 0.3)
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

// Maybe woek on an impulse variation of this?

////////////////////////////////////////////// WHISPERING BASS

(
~samplesDir = "/Users/bloit/Dropbox/redbluff_transfer/ASMR/ASMR Project/";
~asmrBuf= Buffer.read(s, ~samplesDir +/+ "japaneseASMR_mono.wav", 44100*1,  44100*2);
)

(
SynthDef(\asmr, {|out=0, sendBus=0, bufnum=0, loop=1, amp=0.1|
	var sig;
	sig = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), loop:loop);
	Out.ar(out, sig*amp!2);
	Out.ar(sendBus, sig);


}).add;

SynthDef(\bassmr, {|out=0, in=0, freq=60, amp=1, atk=0.1, rel=0.1|
	var env;
	env = Amplitude.kr(In.ar(in), atk, rel);
	Out.ar(out, LFPar.ar(freq, mul:env * amp)!2);
}
).add
)

// ------ INIT
(
~asmrOut = Bus.audio(s, 1);
~asmr = Synth(\asmr, [\bufnum, ~asmrBuf.bufnum, \sendBus, ~asmrOut.index, \out, 5]);
~bassmr = Synth.after(~asmr, \bassmr, [\amp, 0, \in, ~asmrOut.index, \out, 0]);
~asmr.set(\out, 0, \amp, 0)
)


(
~bassmr.set(\rel, 1, \atk, 0.3, \amp, 4, \freq, 50);
~asmr.set(\out, 0, \amp, 0.1);
)