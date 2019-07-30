MIDIClient.init;
MIDIIn.connectAll;
MIDIFunc.trace(false );

s.options.outDevice = "USB PnP Sound Device";
s.options.inDevice = "Soundflower (16ch)";
// {SinOsc.ar()}.play

// a version without the analog synth

//when running from laptop:
(
Server.default = s = Server("belaServer", NetAddr("192.168.7.2", 57110));
s.initTree;
s.startAliveThread;
)

(
SynthDef(\mic, {
	|in=0, out=0, amp=1|
	var sig;
	sig = SoundIn.ar(in);
	Out.ar(out, sig*amp);
}).add;

// distortion
SynthDef(\disto,{| amp=0.1,smooth=1,mul=0.4,freq=0.2, filterFreq=1000, rezFreq=400, in=0, out=0|

	var sig = In.ar(in,1);

	filterFreq = filterFreq.clip(50, 2000);
	sig = CrossoverDistortion.ar(sig,amp,SinOsc.ar([freq,freq+0.5],0,0.1,smooth),mul);
	// sig = FreeVerb.ar(sig,0.5,0.5);
	// sig = sig + CombC.ar(sig,0.1,1/8,0.1);
	sig = sig ;
	//sig = SineShaper.ar(sig, 1,0.5);
	sig = BRF.ar(sig,filterFreq,15,-10);
	sig = HPF.ar(sig,filterFreq/2);

	sig = Resonz.ar(sig, rezFreq);

	//	sig = Limiter.ar(sig,0.5);
	sig = LeakDC.ar(sig);
	sig = Compander.ar(sig,In.ar(4,2),0.1,1,0.25,0.1,0.01);
	Out.ar(out, sig);
}).add;




// make a DC synth (the DC ugen doesn't allow modulation)
SynthDef(\dc, {|val=0, out=2|
	Out.ar(out, SinOsc.ar(0, add:val));
}).add;


// bass
~wt0 = Signal.sineFill(1024, [1, 1, 1, 1, 1, 1, 1]);
~wt1 = Signal.chebyFill(1024, [0, 1, 0.1, 0, 0, 0.3, 0]);

~buf = Buffer.allocConsecutive(2, s, 2048);
~buf[0].loadCollection(~wt0.asWavetable);
~buf[1].loadCollection(~wt1.asWavetable);


SynthDef(\bass, {|out=0, buf=0, numBufs=2, freq=300, amp=0.1|
	var sig, bufpos, detuneSig;
	detuneSig = LFNoise1.kr(0.2!8).bipolar(0.2).midiratio;
	bufpos = buf + MouseX.kr(0, numBufs-1);
	sig = VOsc.ar(bufpos, freq);
	sig = Splay.ar(sig);
	sig = LeakDC.ar(sig) * amp;
	Out.ar(out, sig);
}).add;







SynthDef(\noise, {|freq=1000, out=0|
	var mod, sig, sig2;
	mod = SinOsc.ar(0.1, mul:300);
	sig = PinkNoise.ar(0.5);
	sig = HPF.ar(sig, freq:800 + mod);
	freq = 	(freq  + mod).clip(1, 10000);
	sig2 = BPF.ar(sig, freq: freq);
	Out.ar(out, [sig, sig2]);
}).add;


SynthDef(\beep, {|out=0, freq=3400, rel=1|
	var sig;
	sig = EnvGen.ar(Env.perc(releaseTime:rel), doneAction:2);
	sig = Ringz.ar(sig, freq, 1);
	Out.ar(out, sig);
}).add;

SynthDef(\reverb, {|in=0, out=0, dec=5|
	var s, z, y;
	s = In.ar(in, 1);
	// reverb predelay time :
	z = DelayN.ar(s, 0.048);
	// 7 length modulated comb delays in parallel :
	y = Mix.ar(Array.fill(7,{ CombL.ar(z, 0.1, LFNoise1.kr(0.1.rand, 0.04, 0.05), dec) }));
	// two parallel chains of 4 allpass delays (8 total) :
	7.do({ y = AllpassN.ar(y, 0.050, [0.050.rand, 0.050.rand],1) });
	// add original sound to reverb and play it :
	s = s+(0.2*y);
	Out.ar(out, s);
}).add;

SynthDef(\rezo, {|in=0, out=0, freq=100, dec=0.1|
	var sig, fx;
	sig = In.ar(in, 1);
	fx = Ringz.ar(sig, freq, decaytime:dec);
	sig = sig + (0.2*fx);
	Out.ar(out, sig);
}).add;


)
(
s.freeAll;
MIDIdef.freeAll;
)



(

~distoBus = Bus.audio(s, 1);
~revBus = Bus.audio(s, 1);
~rezoBus = Bus.audio(s, 1);

~in0 = Synth(\mic, [\in, 0, \out, 0]);
~in1 = Synth(\mic, [\in, 1, \out, 1]);
~in2 = Synth(\mic, [\in, 2, \out, 0]);
~in3 = Synth(\mic, [\in, 3, \out, 1]);

~disto = Synth.after(~in1, \disto, [\in,  ~distoBus, \out, 1]);
~reverb = Synth(\reverb, [\in, ~revBus, \out, 0, \dec, 5]);
~rezo = Synth(\rezo, [\in, ~rezoBus, \out, 0]);

~pitch = Synth(\dc, [\out, 2]);
~decay = Synth(\dc, [\out, 3]);
~balance = Synth(\dc, [\out, 4]);
~overtone = Synth(\dc, [\out, 5]);

~noise;
~noiseOn=False;
~noiseFreq = 1000;
~noiseFreqInc = 400;
~hatCount=0;

~bass;
~bassOn=False;
~bassFreq = 40;
~bassRez = 10;
)




// s.freeAll

// ~disto.free


(
MIDIdef.program(\section, {|val|
	if(val>0,

		{switch(val,

			1,{">>>>>>>>>>>>SECTION 1".postln

				(


					~in0.set(\out, 0, \amp, 40);
					~in1.set(\out, 1, \amp, 40);
					~in2.set(\out, 0, \ap, 80);
					~in3.set(\out, 1);


					MIDIdef.noteOn(\kick, {|val|
						// val.postln;
						if(val>0,{
							if(~noiseOn==True,{~noise.free; ~noiseOn=False}, {});


							if(~bassOn==True, {}, {
								// ~bass=Synth(\bass, [\freq, ~bassFreq, \rez, ~bassRez]);
								~bass = Synth(\bass, [\freq, ~bassFreq, \buf, ~buf[0].bufnum , \numBufs, 2, \amp, 0.2]);
								~bassOn = True;}
							);

						});
					}, chan:0);


					MIDIdef.noteOn(\snare, {|val|
						// val.postln;
						if(val>0,{


							if(~bassOn==True,{~bass.free; ~bassOn=False}, {});

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
							if (~noiseOn==True, {~noise.set(\freq, ~noiseFreq + ~noiseFreqInc * ~hatCount);});
							if(~bassOn==True, {
								~bass.set(\freq, ~bassFreq+3, \buf, ~buf[0].bufnum + 0.5);

							});


						});
					}, chan:2);

				)

			},



			2,{">>>>>>>>>>>>SECTION 2".postln;
				(

/*					~pitch.set(\val, 0.1);
					~decay.set(\val, 0.3);
					~balance.set(\val, 1);
					~overtone.set(\val, 1);*/

					// distortion
					~in0.set(\out, 0);
					~in1.set(\out, ~distoBus);
					~in2.set(\out, ~distoBus);
					~in3.set(\out, 3);

					~disto.set(\amp, 1);
					~disto.set(\filterFreq, 1000);
					~disto.set(\smooth, 0.9);

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
								~noise=Synth(\noise, [\out, ~distoBus]);
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
							~balance.set(\val, 0.rrand(1.0));
							~disto.set(\rezFreq, 400.rrand(10000));
							if (~hatCount%3 == 0, {
								Synth(\beep, [\out, ~revBus, \freq, 3400]);});
						});
					}, chan:2);

				)
			},
			3,{">>>>>>>>>>>>SECTION 3".postln;

				(

					~pitch.set(\val, 0.1);
					~decay.set(\val, 0.3);
					~balance.set(\val, 1);
					~overtone.set(\val, 1);

					// distortion
					~in0.set(\out, ~distoBus);
					~in1.set(\out,1);
					~in2.set(\out, ~distoBus);
					~in3.set(\out, ~distoBus);



					~disto.set(\amp, 1);
					~disto.set(\filterFreq, 1000);
					~disto.set(\smooth, 0.9);


					MIDIdef.noteOn(\kick, {|val|
						// val.postln;
						if(val>0,{
							~pitch.set(\val, 0.2);

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
								~noise=Synth(\noise, [\out, ~rezoBus]);
								~rezo.set(\freq, 1200);
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
							~balance.set(\val, 0.rrand(1.0));
							~disto.set(\rezFreq, 400.rrand(10000));
							// Synth(\beep, [\out, 2, \rel, 0.05, \freq, 3000]);


							if (~hatCount%3 == 0, {
								Synth(\beep, [\out, 1, \rel, 0.05, \freq, 3400]);},
							{

								Synth(\beep, [\out, 2, \rel, 0.05.rrand(0.1), \freq, 3200]);
							}


							);
						},

						);
					}, chan:2);

				)
			},





			4,{">>>>>>>>>>>>SECTION 4".postln;


				(

					~pitch.set(\val, 0.1);
					~decay.set(\val, 0.3);
					~balance.set(\val, 1);
					~overtone.set(\val, 1);

					// distortion
					~in0.set(\out, ~distoBus);
					~in1.set(\out,1);
					~in2.set(\out, ~distoBus);
					~in3.set(\out, 3);



					~disto.set(\amp, 1);
					~disto.set(\filterFreq, 1000);
					~disto.set(\smooth, 0.9);


					MIDIdef.noteOn(\kick, {|val|
						// val.postln;
						if(val>0,{
							~pitch.set(\val, 0.1);

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
								~noise=Synth(\noise, [\out, ~rezoBus]);
								~rezo.set(\freq, 800);
								~hatCount = 0;
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
							~balance.set(\val, 0.rrand(1.0));
							~disto.set(\rezFreq, 400.rrand(10000));
							// Synth(\beep, [\out, 2, \rel, 0.05, \freq, 3000]);


							if (~hatCount%3 == 0, {
								Synth(\beep, [\out, 1, \rel, 0.05, \freq, 3400]);},
							{

								Synth(\beep, [\out, 2, \rel, 0.05.rrand(0.1), \freq, 3200]);
							}


							);
						},

						);
					}, chan:2);

				)



			},


			5,{">>>>>>>>>>>>SECTION 5".postln},


		)
		};
	)


}, chan: 15);


)






