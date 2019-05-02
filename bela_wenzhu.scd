/*
when running from laptop:
(
Server.default = s = Server("belaServer", NetAddr("192.168.7.2", 57110));
s.initTree;
s.startAliveThread;
)
*/

s = Server.default;

s.options.numAnalogInChannels = 0;
s.options.numAnalogOutChannels = 8;
s.options.numDigitalChannels = 16;

s.options.blockSize = 16;
s.options.numInputBusChannels = 4;
s.options.numOutputBusChannels = 4;

s.options.postln;

s.waitForBoot({
	MIDIClient.init;
	MIDIIn.connectAll;
	MIDIFunc.trace(false);

	SynthDef(\mic, {
		|in=0, out=0|
		var sig;
		sig = SoundIn.ar(in);
		Out.ar(out, sig);
	}).add;


	// resonator
	SynthDef(\rez,{
		|in=0, out = 0, pitch= 1, timbre=0.1|
		var sig;
		var input = In.ar(in,1);
		sig = DynKlank.ar(`[[800, 1071, 1153, 1723] * pitch, [1,1,1,1]*timbre, [1, 1, 1, 1]*timbre], input);
		Out.ar(out, sig);
	}).add;

	// distortion
	SynthDef(\cross,{arg amp=0.01,smooth=1,mul=0.4,freq=0.2, filterFreq=1000, in=0, out=0;
		var sig = In.ar(in,1);
		filterFreq = filterFreq.clip(50, 2000);
		sig = CrossoverDistortion.ar(sig,amp,SinOsc.ar([freq,freq+0.5],0,0.1,smooth),mul);
		// sig = FreeVerb.ar(sig,0.5,0.5);
		sig = sig + CombC.ar(sig,0.1,1/8,0.1);
		sig = sig ;
		//sig = SineShaper.ar(sig, 1,0.5);
		sig = BRF.ar(sig,filterFreq,15,-10);
		sig = HPF.ar(sig,filterFreq/2);
		//	sig = Limiter.ar(sig,0.5);
		sig = LeakDC.ar(sig);
		sig = Compander.ar(sig,In.ar(4,2),0.1,1,0.25,0.1,0.01);
		// sig = [DelayL.ar(sig*(-1),0.1,SinOsc.kr(-0.1,0,0.05,0.1)),DelayL.ar(sig*(-1),0.1,SinOsc.kr(0.1,0,0.05,0.1))]*0.1;
		Out.ar(out, sig);
	}).add;



	// make a DC synth (the DC ugen doesn't allow modulation)
	SynthDef(\dc, {|val=0, out=2|
		AnalogOut.ar(out, SinOsc.ar(0, add:val));
	}).add;

	// modulation synth
	SynthDef(\saw, {|val=0, out=4, freq=8|
		AnalogOut.ar(out, Saw.ar(freq, mul:(0.5*val), add:0.5));
	}).add;


	s.sync;


	~curMode = 1;

	~pitch = Synth(\dc, [\out, 2]);
	~decay = Synth(\dc, [\out, 3]);
	~balance = Synth(\dc, [\out, 4]);
	~overtone = Synth(\dc, [\out, 5]);

	~in0 = Synth(\mic, [\in, 0, \out, 0]);
	~in1 = Synth(\mic, [\in, 1, \out, 1]);
	~in2 = Synth(\mic, [\in, 2, \out, 2]);

	// FX BUSSES
	~rezBus0 = Bus.audio(s, 1);
	~rezBus1 = Bus.audio(s, 1);
	~rezBus2 = Bus.audio(s, 1);

	~distoBus = Bus.audio(s, 1);

	// FX Synths
	~rez0 = Synth.after(~in0, \rez, [\in,  ~rezBus0, \out, 0]);
	~rez1 = Synth.after(~in1, \rez, [\in,  ~rezBus1, \out, 1]);
	~rez2 = Synth.after(~in2, \rez, [\in,  ~rezBus2, \out, 2]);

	~disto = Synth.after(~in0, \cross, [\in,  ~distoBus, \out, 3]);


	// set effects or not on individual drum inputs

	// SET MODE
	MIDIdef.program(\pgm, {|val|
		val.postln;
		if(val > 0, {

			~curMode = val;

			// Mode init

			switch(~curMode,
				1, {
					postf("MODE %\n", ~curMode);

					~in0.set(\out, 0);
					~in1.set(\out, 1);
					~in2.set(\out, 2);

					~pitch.set(\val, 0.10);
					~decay.set(\val, 0.0 );
					~balance.set(\val, 0.1);
					~overtone.set(\val, 0.1);

					~disto.free;


				},
				2, {
					postf("MODE %\n", ~curMode);

					~disto.free;


					~in0.set(\out, ~rezBus0);
					~in1.set(\out, ~rezBus1);
					~in2.set(\out, ~rezBus2);

					~pitch.set(\val, 0.11);
					~decay.set(\val, 0.1 );
					~balance.set(\val, 0.1);
					~overtone.set(\val, 0.1);

				},
				3, {
					postf("MODE %\n", ~curMode);

					~disto = Synth.after(~in0, \cross, [\in,  ~distoBus, \out, 3]);


					~pitch.set(\val, 0.10);
					~decay.set(\val, 0.0 );
					~balance.set(\val, 0.1);
					~overtone.set(\val, 0.1);

					~in0.set(\out, ~distoBus);
					~in1.set(\out, ~distoBus);
					~in2.set(\out, ~distoBus);

				},
			);

		});

		postf("SET MODE %\n", ~curMode);


	});

	MIDIdef.cc(\ccCheck, {
		|val, cc|
		//	val.postln;

		switch(~curMode,

			// pitch, decay and timbre : linear control with midi pedal
			1, {
				if (val>0, {

					~decay.set(\val, 1);

					switch(cc,
						1, {
							~pitch.set(\val, 0.1);
							~balance.set(\val, 0.1);
							~overtone.set(\val, 1);
						},
						2, {
							~pitch.set(\val, 0.105);
							~balance.set(\val, 0.1);
							~overtone.set(\val, val.linlin(0, 127, 1,0));
						},
						3, {
							~pitch.set(\val, 0.105);
							~balance.set(\val, val.linlin(0, 127, 0.1,0.2));
							~overtone.set(\val, val.linlin(0, 127, 1,0));
						},
						4, {
							~pitch.set(\val, 0.11);
							~balance.set(\val, val.linlin(0, 127, 0.2,0.3));
							~overtone.set(\val, val.linlin(0, 127, 2,0));

						},
						5, {
							~pitch.set(\val, 0.12);
							~balance.set(\val, val.linlin(0, 127, 0.3,0.7));
							~overtone.set(\val, val.linlin(0, 127, 4,0));

						},


					);


				},
				{
					~decay.set(\val, 0);

				});


			},

			2, {
				if (val>0, {

					~decay.set(\val, 1);

					switch(cc,
						1, {
							~rez0.set(\pitch, 100 + 1.rrand(2));
							~rez0.set(\timbre, 0.1 + val.linlin(0,127, 0, 0.2));

							~rez1.set(\pitch, 300);
							~rez1.set(\timbre, 0.1);

							~rez2.set(\pitch, 1000);
							~rez2.set(\timbre, 0.1);

						},
						2, {
							~rez0.set(\pitch, 1);
							~rez0.set(\timbre, 0.3);

							~rez1.set(\pitch, 3000);
							~rez1.set(\timbre, 0.3 + val.linlin(0, 127, 0, 0.6));

							~rez2.set(\pitch, 300);
							~rez2.set(\timbre, 0.1 + val.linlin(0, 127, 0, 0.6));

							~pitch.set(\val, 0.11);
							~balance.set(\val, 0.1);
							~overtone.set(\val, 0.1);
						},
						3, {
							~rez0.set(\pitch, 1.05);
							~rez0.set(\timbre, 0.4);

							~rez1.set(\pitch, 10);
							~rez1.set(\timbre, 0.5);

							~rez2.set(\pitch, 10);
							~rez2.set(\timbre, 0.1 + val.linlin(0,127, 0, 0.4));

							~pitch.set(\val, 0.115);
							~balance.set(\val, 0.15);
							~overtone.set(\val, 0.3);
						},
						4, {
							~rez0.set(\pitch, 1.05);
							~rez0.set(\timbre, 0.2);

							~rez1.set(\pitch, 10);
							~rez1.set(\timbre, 0.5);

							~rez2.set(\pitch, 10);
							~rez2.set(\timbre, 0.1 + val.linlin(0,127, 0, 0.4));

							~pitch.set(\val, 0.115);
							~balance.set(\val, 0.25);
							~overtone.set(\val, 0.3);

						},
						5, {
							~rez0.set(\pitch, 1.05);
							~rez0.set(\timbre, 0.2);

							~rez1.set(\pitch, 2);
							~rez1.set(\timbre, 0.5 + val.linlin(0,127, 0, 0.4));

							~rez2.set(\pitch, 10);
							~rez2.set(\timbre, 0.1 + val.linlin(0,127, 0, 0.4));

							~pitch.set(\val, 0.1);
							~balance.set(\val, 0.4);
							~overtone.set(\val, 0.4);

						},
					);
				},
				{
					~decay.set(\val, 0);

				});
			},
			3, {

				if(val>0, {
					~decay.set(\val, 1);

					switch(cc,
						1,{
							~disto.set(\amp, 0.05);
							~disto.set(\smooth, 1);
							~disto.set(\mul, 0.4);
							~disto.set(\freq, 0.2);
							~disto.set(\filterFreq, 1000);

							~pitch.set(\val, val.linlin(0, 127, 0.1, 0.2));

						},
						2,{
							~disto.set(\amp, 0.1);
							~disto.set(\smooth, 0.9);
							~disto.set(\mul, 0.5);
							~disto.set(\freq, 0.8);
							~disto.set(\filterFreq, 700);

							~pitch.set(\val, val.linlin(0, 127, 0.1, 0.2));

							},
						3,{
							~disto.set(\amp, 0.10);
							~disto.set(\smooth, 0.7);
							~disto.set(\mul, 0.5);
							~disto.set(\freq, 0.8);
							~disto.set(\filterFreq, 1000);

							~pitch.set(\val, val.linlin(0, 127, 0.1, 0.3));

							},
						4,{
							~disto.set(\amp, 0.10);
							~disto.set(\smooth, 0.7);
							~disto.set(\mul, 0.5);
							~disto.set(\freq, 0.8);
							~disto.set(\filterFreq, 1000);

							~pitch.set(\val, val.linlin(0, 127, 0.1, 0.3));
						},
						5,{
							~disto.set(\amp, 0.14);
							~disto.set(\smooth, 0.6);
							~disto.set(\mul, 0.8);
							~disto.set(\freq, 0.8);
							~disto.set(\filterFreq, 1000);

							~pitch.set(\val, val.linlin(0, 127, 0.1, 0.5));

					}
					);
				},
				{
					~decay.set(\val, 0);
				});

			},
			4, {},
			5, {},);

	});

});
