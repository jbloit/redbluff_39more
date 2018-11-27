(
i = Bus.audio(s, 1);

SynthDef(\pulse, {|out=0, freq=3, width=0.5|
	Out.ar(out, Pulse.ar(freq, width));
}
).add;

b = Buffer.alloc(s, 512, 1, {arg buf; buf.sine1Msg(1.0/[1,2,3,4,5,6,7,8,9,10])});

SynthDef(\bassChop, {
	|in=0, out=0, freq=60, atk=0.1, dec=0.1, sus=0.8, rel=0.1, curve=9, beating=0.1|
	var sig, env;
	env = EnvGen.ar(Env.adsr(atk, dec, sus, rel, curve:curve), In.ar(in, 1));
	// sig = LFPar.ar(freq, mul:env);

	sig =  COsc.ar(b.bufnum, freq, beating, env);

	Out.ar(out, sig!2);
}).add;

)


a=Synth( \pulse, [\out, i.index]);
b=Synth.after(a,\bassChop, [\in, i.index])

~freq = 8 ;
a.set(\freq, ~freq, \width, 0.5);
b.set(\atk, 0.01/~freq, \dec, 0.3/~freq, \rel, 0.2/~freq, \curve, -1, \freq, 50, \beating, 0.3)


{LFPar.ar(60,0,1)!2}.play

(
play {
    DynKlang.ar(`[
        [800, 1000, 1200] + SinOsc.kr([2, 3, 4.2], 0, [13, 24, 12]),
        [0.3, 0.3, 0.3],
        [pi,pi,pi]
    ]
) * 0.1
};
)