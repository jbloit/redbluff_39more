

// ex. How can I build tension/reward  with only these elements?
// riff: make longer ones. should feel the repetition, but not hear it.


MIDIFunc.trace(true)


// CLIPS

////////////////////////////////////////////////////  1  Seed clip. Run this once only.



(

Ndef(\mix).play;
TempoClock.tempo = 1;


TempoClock.sched(1, {
	~p1 = Synth(\p1).set(\freq, 4000, \detune,0.3, \f0,8, \f1,4, \w0,0.98, \phasing,0, \legato,0.5, \amp,0.2, \out, ~o2);
	~p2 = Synth(\p1).set(\freq, 2000, \detune,0.3, \f0,8, \f1,4, \w0,0.98, \phasing,0, \legato,0.5, \amp,0, \out, ~o2);
});

~lo = Synth(\lo, [\freq,  30, \amp, 0.8,  \modBus, ~k2, \modMul, 0,  \modLag, 1.5, \out, ~o3 ]);
~roof = Synth(\roof, [\x, 0.1, \y, 0.5, \amp, 0,  \out, ~o4, \modBus, ~k1, \modMul, 0, \modLag, 0]);
~disto = Synth(\disto, [\amp, 0.1 , \smooth, 1, \mul, 0.4, \freq,  0.2 , \filterFreq, 1000,  \rezFreq, 400 , \in, ~o1 , \out, ~o7]);


MIDIdef.noteOn(\noteOnPad, {
	|vel, nn, chan |


	nn.postln;
	if(nn<60,
		{
			Synth( \kick, [\out, ~o1]);
			~lo.set(\amp, 0.8, \freq, nn.linlin(30, 60, 20, 40));
			~p2.set(\freq, 1000);
		},
		{
			Synth(\noise, [\freq, nn.linexp(60, 80, 500, 20000), \out, ~o6]);
			if(nn> 66, {~lo.set(\amp, 0);}, {	~lo.set(\amp, 0.8);});
			~p2.set(\freq, 2000;)
		}
	);
});

~disto.set(\amp, 1, \in, ~o1, \mul, 0.2, \smooth, 0.7, \freq, 0.2, \filterFreq, 900, \rezFreq, 1900);
)

(
MIDIdef.program(\cues,{|val|
	val.postln;

	switch(val,

		1, {"//////////////////// preset 1".postln;

			~p1.set(\freq,4000, \detune,0.3, \f0,8, \f1,4, \w0,0.98, \phasing,0, \legato,0.5, \amp,0.1, \out, ~o2);
			~lo .set(\freq,  30, \amp, 2,  \modBus, ~k2, \modMul, 1,  \modLag, 1.5, \out, ~o3 );
			~roof.set(\x, 0.8, \y, 0.5, \amp, 1,  \out, ~o4, \modBus, ~k1, \modMul, 0, \modLag, 0);


			MIDIdef.noteOn(\noteOnPad, {
				|vel, nn, chan |


				nn.postln;
				if(nn<60,
					{
						Synth( \kick, [\out, ~o1]);
						~lo.set(\amp, 2, \freq, nn.linlin(30, 60, 20, 40));
						~p2.set(\freq, 4000);

						~disto.set(\amp, 1, \in, ~o2, \mul, 0.2, \smooth, 0.6, \freq, 20, \filterFreq, 1000, \rezFreq, 2000);
						~p1.set(\freq,4000, \detune,0, \f0,8, \f1,6, \w0,0.98, \phasing,0, \legato,0.1, \amp,0.2, \out, ~o2);


					},
					{
						Synth(\noise, [\freq, nn.linexp(60, 80, 500, 20000), \out, ~o6]);
						if(nn> 66, {~lo.set(\amp, 0);}, {	~lo.set(\amp, 2);});
						~p2.set(\freq, 4000;)
					}
				);
			}, chan:0);
		},

		2, {"///////////////////////////////////// preset 2".postln;


			~p1.set(\freq,1000, \detune,0, \f0,8, \f1,6, \w0,0.98, \phasing,0, \legato,0.1, \amp,0.2, \out, ~o2);
			~lo .set(\freq,  35, \amp, 0.8,  \modBus, ~k2, \modMul, 2,  \modLag, 0, \out, ~o3 );
			~roof.set(\x, 0.01, \y, 0.5, \amp, 2,  \out, ~o4, \modBus, ~k1, \modMul, 0, \modLag, 0);

			MIDIdef.noteOn(\noteOnPad, {
				|vel, nn, chan |

				nn.postln;
				if(nn<60,
					{
						// kick bass
						Synth( \kick, [\out, ~o1]);
						~lo.set(\amp,2, \freq, nn.linlin(30, 60, 20, 40));
						~disto.set(\amp, 1, \in, ~o1, \mul, 0.2, \smooth, 0.7, \freq, 0.2, \filterFreq, 900, \rezFreq, 1900);
						~p1.set(\freq,1000, \detune,0, \f0,8, \f1,6, \w0,0.98, \phasing,0, \legato,0.1, \amp,0.2, \out, ~o2);
						~roof.set(\x, 0.01, \y, 0.5, \amp, 2,  \out, ~o4, \modBus, ~k1, \modMul, 0, \modLag, 0);

					},
					{
						Synth(\noise, [\freq, nn.linexp(60, 80, 500, 20000), \out, ~o6]);
						if(nn> 66, {

							// cut snare
							~lo.set(\amp, 0);
							~disto.set(\amp, 1, \in, ~o2, \mul, 0.2, \smooth, 0.6, \freq, 20, \filterFreq, 1000, \rezFreq, 2000);
							~p1.set(\freq,1000, \detune,0, \f0,8, \f1,6, \w0,0.98, \phasing,0, \legato,0.1, \amp,0.2, \out, ~o2);

						},
						{
							// snare
							~lo.set(\amp, 2);
							~p1.set(\freq,1000, \detune,0, \f0,8, \f1,19, \w0,0.96, \phasing,0, \legato,0.001, \amp,0.2, \out, ~o2);

							~disto.set(\amp, 1, \in, ~o2, \mul, 0.2, \smooth, 0.6, \freq, 20, \filterFreq, 1000, \rezFreq, 2000);
							~roof.set(\x, 0.5, \y, 0.1, \amp, 2,  \out, ~o4, \modBus, ~k1, \modMul, 0, \modLag, 0);



						});
					}
				);
			}, chan:0);

		}
	);

}, 15 );

)