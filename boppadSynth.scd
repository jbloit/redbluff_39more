MIDIClient.init;
MIDIIn.connectAll;
s.latency = 0.01;
MIDIFunc.trace;
//  to turn tracing off:
// MIDIFunc.trace( false );

(



SynthDef(\kick, {|out=0, amp=1|
	var sig, envFreq, env;
	envFreq = EnvGen.kr(Env([1, 0.1, 0], [0.1, 0.3], -6), doneAction:2, levelScale:380, levelBias:10);
	env = EnvGen.kr(Env([1, 1, 0], [0.1, 0.3]), levelScale:0.4);
	sig = LFPar.ar(envFreq, mul:env) * amp;
	Out.ar(out, sig);
}).add;


SynthDef(\noise, {|freq=100, out=0|
	var mod, sig, sig2, env;
	env = EnvGen.kr(Env.perc(0.001, 0.1), doneAction:2);
	mod = SinOsc.ar(0.1, mul:300);
	sig = PinkNoise.ar(0.5);
	sig = HPF.ar(sig, freq:800 + mod);
	freq = 	(freq  + mod).clip(1, 10000);
	sig2 = BPF.ar(sig, freq: freq);
	Out.ar(out, sig2!2);
}).add;


MIDIdef.noteOn(\noteOnPad, {
	|vel, nn, chan |

	if(nn<60,
		{
			Synth( \kick, [\out, 0]);
			Synth( \kick, [\out, 1]);
		},
	{
			Synth(\noise, [\freq, nn.linexp(60, 80, 500, 20000)]);
		}
	);


	switch(chan,
		0, {

		},
		1, {Synth(\noise, [\freq, 1000])},
		2, {"2".postln;},
		3, {"3".postln;},
	);

	// postf("note %, vel %, chan % \n", nn, vel, chan);
	/*


	switch (chan,
	0, {Synth(\sampler, [\bufnum, ~kickBuffers[]]},
	);*/
	// Synth(\sampler, [\bufnum, ~percBuffers[nn], \amp, vel.linlin(0, 127, 0.0, 1.0)]);

};
);

)