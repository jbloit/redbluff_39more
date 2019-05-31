MIDIClient.init;
MIDIIn.connectAll;
MIDIFunc.trace(false);


//when running from laptop:
(
Server.default = s = Server("belaServer", NetAddr("192.168.7.2", 57110));
s.initTree;
s.startAliveThread;
)

(
SynthDef(\mic, {
	|in=0, out=0|
	var sig;
	sig = SoundIn.ar(in);
	Out.ar(out, sig);
}).add;


SynthDef(\fx1,{| amp=0.1,smooth=1,mul=0.4,freq=0.2, filterFreq=1000, in=0, out=0|

	var sig = In.ar(in,1);


	filterFreq = filterFreq.clip(50, 2000);
	sig = CrossoverDistortion.ar(sig,amp,SinOsc.ar([freq,freq+0.5],0,0.1,smooth),mul);
	// sig = FreeVerb.ar(sig,0.5,0.5);
	// sig = sig + CombC.ar(sig,0.1,1/8,0.1);
	sig = sig ;
	//sig = SineShaper.ar(sig, 1,0.5);
	sig = BRF.ar(sig,filterFreq,15,-10);
	sig = HPF.ar(sig,filterFreq/2);
	//	sig = Limiter.ar(sig,0.5);
	sig = LeakDC.ar(sig);
	sig = Compander.ar(sig,In.ar(4,2),0.1,1,0.25,0.1,0.01);



	Out.ar(out, sig);
}).add;



// make a DC synth (the DC ugen doesn't allow modulation)
SynthDef(\dc, {|val=0, out=2|
	AnalogOut.ar(out, SinOsc.ar(0, add:val));
}).add;

SynthDef(\noise, {|freq=1000|
	var mod, sig, sig2;
	mod = SinOsc.ar(0.1, mul:300);
	sig = PinkNoise.ar(0.5);
	sig = HPF.ar(sig, freq:800 + mod);
	sig2 = BPF.ar(sig, freq:freq + mod );
	Out.ar(0, [sig, sig2]);
}).add;


)
(
s.freeAll
)


(

~fxBus = Bus.audio(s, 1);

~in0 = Synth(\mic, [\in, 0, \out, 0]);
~in1 = Synth(\mic, [\in, 1, \out, 1]);
~in2 = Synth(\mic, [\in, 2, \out, 2]);
~in3 = Synth(\mic, [\in, 3, \out, 3]);
~fx1 = Synth.after(~in1, \fx1, [\in,  ~fxBus, \out, 1]);
~pitch = Synth(\dc, [\out, 2]);
~decay = Synth(\dc, [\out, 3]);
~balance = Synth(\dc, [\out, 4]);
~overtone = Synth(\dc, [\out, 5]);

~noise;
~noiseOn=False;
~noiseFreq = 1000;
~noiseFreqInc = 400;
~hatCount=0;
)


// s.freeAll

// ~fx1.free


(
MIDIdef.program(\section, {|val|
	if(val>0,

		{switch(val,

			1,{">>>>>>>>>>>>SECTION 1".postln

				(

					~pitch.set(\val, 0.1);
					~decay.set(\val, 0.3);
					~balance.set(\val, 1);
					~overtone.set(\val, 1);
					~in1.set(\out, 1);
					~in2.set(\out, 2);

					MIDIdef.noteOn(\kick, {|val|
						// val.postln;
						if(val>0,{
							~decay.set(\val, 0.4);
							if(~noiseOn==True,{~noise.free; ~noiseOn=False}, {});
						});
					}, chan:0);


					MIDIdef.noteOn(\snare, {|val|
						// val.postln;
						if(val>0,{
							~pitch.set(\val, 0.05);
							~decay.set(\val, 0.0);
							if(~noiseOn==True, {}, {
								~hatCount = 0;
								~noise=Synth(\noise);
								~noiseOn = True;}
							);
						});
					}, chan:1);


					MIDIdef.noteOn(\hat, {|val|
						// val.postln;
						if(val>0,{
							~hatCount = ~hatCount + 1;
							~noise.set(\freq, ~noiseFreq + ~noiseFreqInc * ~hatCount);
							~pitch.set(\val, 0.07);
							~decay.set(\val, 0.3);
							~balance.set(\val, 0.rrand(1.0);
							);
						});
					}, chan:2);

				)





			},



			2,{">>>>>>>>>>>>SECTION 2".postln;
				(

					~pitch.set(\val, 0.1);
					~decay.set(\val, 0.3);
					~balance.set(\val, 1);
					~overtone.set(\val, 1);


					// distortion
					~in1.set(\out, ~fxBus);
					~in2.set(\out, ~fxBus);
					~fx1.set(\amp, 1);
					~fx1.set(\filterFreq, 1000);
					~fx1.set(\smooth, 0.9);




					MIDIdef.noteOn(\kick, {|val|
						// val.postln;
						if(val>0,{
							~pitch.set(\val, 0.1.rrand(0.2));

							~decay.set(\val, 0.4);
							if(~noiseOn==True,{~noise.free; ~noiseOn=False}, {});
						});
					}, chan:0);


					MIDIdef.noteOn(\snare, {|val|
						// val.postln;
						if(val>0,{
							~pitch.set(\val, 0.05);
							~decay.set(\val, 0.0);
							if(~noiseOn==True, {}, {
								~hatCount = 0;
								~noise=Synth(\noise);
								~noiseOn = True;}
							);
						});
					}, chan:1);


					MIDIdef.noteOn(\hat, {|val|
						// val.postln;
						if(val>0,{
							~hatCount = ~hatCount + 1;
							~noise.set(\freq, ~noiseFreq + ~noiseFreqInc * ~hatCount);
							~pitch.set(\val, 0.07);
							~decay.set(\val, 0.3);
							~balance.set(\val, 0.rrand(1.0);
							);
						});
					}, chan:2);

				)
			},
			3,{">>>>>>>>>>>>SECTION 3".postln},


			4,{">>>>>>>>>>>>SECTION 4".postln},


			5,{">>>>>>>>>>>>SECTION 5".postln},


		)
		};
	)


}, chan: 15);


)






