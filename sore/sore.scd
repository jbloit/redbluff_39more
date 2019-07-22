// have an expression midi control, to edit a pbind seq?
currentEnvironment.clear;
s.latency = 0.01;
// s.reboot;

s.waitForBoot({

	// load synthdefs:
	"sore_synthDefs.scd".loadRelative(true, {"loaded synthdefs".postln});

	s.sync;

	~debug = true; // post messages

	// ------------------------------------------------------------ INIT MUSIC STUFF ------------------------------------

	~asmrOut_1 = Bus.audio(s, 1);
	~asmrOut_2 = Bus.audio(s, 1);

	~tempoHz = 9.6;

	// ------------------------------------------------------------- SCORE ----------------------------------------------------
	~sections = Array.newClear(5);
	~cues = Array2D.new(5,5);
	~trigs = Array2D.new(5,5);

	~currentSection = 0;
	~currentCue = 0;

	// =====================================================
	~sections[0] = {
		if(~debug) {postf("INIT SECTION 0  \n")};

		~arp1.free;

	};

	// ------------------------------------------------------
	~cues[0,0] = {
		if(~debug) {postf("CUE: 0 - 0 \n")};

		// ~arp1 = Synth(\arp);
		// NodeWatcher.register(~arp1, true)
		//
		// ~arp1.isRunning
		// ~arp1.isPlaying
		// ~arp1.free


	};
	~trigs[0, 0] = {|nn, vel|
		// nn is instrument coded:
		// 1: kick
		// 2: snare
		// 3: hat
		// 4: tom

		if(~debug) {postf("TRIG: % - % \n", nn, vel)};
		// Synth(\wiggle);
		switch (nn,
			0, {

				~arp1.set(\amp, 0.2, \freq, 55, \detune, 0.7, \legato, 0.9, \f0, ~tempoHz, \f1, ~tempoHz*1.25, \w0, 0.94, \phasing, 0.5)

			},

			1,
			{

				// ~asmr_1 = Synth(\asmr, [\bufnum, ~asmrBuf[0].bufnum, \sendBus, ~asmrOut_1.index]);
				// ~bassmr_1 = Synth.after(~asmr_1, \bassmr, [\freq, 50, \amp, 4, \in, ~asmrOut_1.index, \out, 0]);

				~arp1.set(\amp, 0.2,\freq, 8888, \detune, 0, \legato, 0.1, \f0, ~tempoHz, \f1, ~tempoHz*1.5, \w0, 0.9, \phasing, 0.5)

			},

			2, {

				~arp1.set(\amp, 0.2,\freq, 8000, \detune, 0.2, \legato, 0.1, \f0, ~tempoHz, \f1, ~tempoHz*1.75, \w0, 0.94, \phasing, 0.5)

			},
			3, {

				~arp1.set(\amp, 0.2,\freq, 50, \detune, 0.1, \legato, 0.8, \f0, ~tempoHz, \f1, ~tempoHz*2, \w0, 0.94, \phasing, 0.5)


			},
			4,
			{
				// ~asmr_2 = Synth(\asmr, [\bufnum, ~asmrBuf[2].bufnum, \sendBus, ~asmrOut_2.index]);
				// ~bassmr_2 = Synth.after(~asmr_2, \bassmr, [\freq, 90, \amp, 4, \in, ~asmrOut_2.index, \out, 0]);
		});
	};

	// ------------------------------------------------------
	~cues[0,1] = {
		if(~debug) {postf("CUE: 0 - 1 \n")};

	};
	~trigs[0, 1] = {|nn, vel|
		// nn is instrument coded:
		// 1: kick
		// 2: snare
		// 3: hat
		// 4: tom

		if(~debug) {postf("TRIG: % - % \n", nn, vel)};
		// Synth(\wiggle);
		switch (nn,
			1,
			{
				~asmr_1 = Synth(\asmr, [\bufnum, ~asmrBuf[0].bufnum, \sendBus, ~asmrOut_1.index]);
				~bassmr_1 = Synth.after(~asmr_1, \bassmr, [\freq, 150, \amp, 4, \in, ~asmrOut_1.index, \out, 0]);
			},
			4,
			{
				~asmr_2 = Synth(\asmr, [\bufnum, ~asmrBuf[2].bufnum, \sendBus, ~asmrOut_2.index]);
				~bassmr_2 = Synth.after(~asmr_2, \bassmr, [\freq, 190, \amp, 4, \in, ~asmrOut_2.index, \out, 0]);
		});
	};

	// ------------------------------------------------------
	~cues[0,2] = {
		if(~debug) {postf("CUE: 0 - 2 \n")};

	};

	// ------------------------------------------------------
	~cues[0,3] = {
		if(~debug) {postf("CUE: 0 - 3 \n")};

	};


	// manage the MIDI parsing:
	"../parseMIDI.scd".loadRelative(true, {"loaded parse MIDI".postln});

});