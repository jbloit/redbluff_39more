s.latency = 0.01;

s.waitForBoot({

	// load synthdefs:
	"clou_synthDefs.scd".loadRelative(true, {"loaded synthdefs".postln});

	s.sync;

	~debug = false; // post messages
	~section = 0;   // song sections
	~cue = 0;        // parts within sections

	// MIDI controller callbacks
	~sectionChange = {|num|
		// postf("SECTION CHANGE: %\n", num);
		~section = num;
		~initSection.value(~section);
	};
	~cueChange = {|num|
		// postf("CUE CHANGE: %\n", num);
		~cue = num;
		~performCue.value(~section, ~cue);
	};

	~playBass = true;
	~bass = PmonoArtic(\bass, \amp, 0.1, \degree, Pseq([0, 2, 4], inf), \octave, 3, ).asStream;

	~initSection = {|section|
		switch(section,
			0, {
				if(~debug) {postf("INIT SECTION: %  \n", section)};
				~xxx.free;
				~xxx = Synth(\pulse, [\amp, 0, \f1, 8, \f2, 3, \chaos, 1]);
				~playBass = true;
			},
			1, {
				if(~debug) {postf("INIT SECTION: %  \n", section)};
				~xxx.free;
				~playBass = false;

			},
			2, {
				if(~debug) {postf("INIT SECTION: %  \n", section)};
				~xxx.free;

			},
			3, {
				if(~debug) {postf("INIT SECTION: %  \n", section)};
				~xxx.free;

			},
			4, {
				if(~debug) {postf("INIT SECTION: %  \n", section)};
				~xxx.free;
			},
		);
	};

	~performCue = {|section, cue|
		// "PERFORM".postln;
		switch(section,
			0, {
				switch(cue,
					0, {
						if(~debug) {postf("PERFORM: % - % \n", section, cue)};
						~xxx.set(\amp, 0.5);
						~xxx.set(\f1, 8);
						~xxx.set(\f2, 3);
						~xxx.set(\chaos, 1);
						~bass = PmonoArtic(\bass, \amp, 0.1, \degree, Pseq([0, 2, 4], inf), \octave, 3, ).asStream;

					},
					1, {
						if(~debug) {postf("PERFORM: % - % \n", section, cue)};
						~xxx.set(\chaos, rrand(0.0, 1));
						~bass = PmonoArtic(\bass, \amp, 0.1, \degree, Pseq([0], inf), \octave, Pseq([3, 4], inf) ).asStream;

					},
					2, {
						if(~debug) {postf("PERFORM: % - % \n", section, cue)};
						~xxx.set(\f2, rrand(3,24));
					},
					3, {
						if(~debug) {postf("PERFORM: % - % \n", section, cue)};
						~xxx.set(\f1, [6,8].choose);
					},
					4, {
						if(~debug) {postf("PERFORM: % - % \n", section, cue)};
					},
				);
			},
			1, {
				switch(cue,
					0, {
						if(~debug) {postf("PERFORM: % - % \n", section, cue)};
					},
					1, {
						if(~debug) {postf("PERFORM: % - % \n", section, cue)};
					},
					2, {
						if(~debug) {postf("PERFORM: % - % \n", section, cue)};
					},
					3, {
						if(~debug) {postf("PERFORM: % - % \n", section, cue)};
					},
					4, {
						if(~debug) {postf("PERFORM: % - % \n", section, cue)};
					},
				);
			},
			2, {
				switch(cue,
					0, {
						if(~debug) {postf("PERFORM: % - % \n", section, cue)};
					},
					1, {
						if(~debug) {postf("PERFORM: % - % \n", section, cue)};
					},
					2, {
						if(~debug) {postf("PERFORM: % - % \n", section, cue)};
					},
					3, {
						if(~debug) {postf("PERFORM: % - % \n", section, cue)};
					},
					4, {
						if(~debug) {postf("PERFORM: % - % \n", section, cue)};
					},
				);
			},
			3, {
				switch(cue,
					0, {
						if(~debug) {postf("PERFORM: % - % \n", section, cue)};
					},
					1, {
						if(~debug) {postf("PERFORM: % - % \n", section, cue)};
					},
					2, {
						if(~debug) {postf("PERFORM: % - % \n", section, cue)};
					},
					3, {
						if(~debug) {postf("PERFORM: % - % \n", section, cue)};
					},
					4, {
						if(~debug) {postf("PERFORM: % - % \n", section, cue)};
					},
				);
			},
			4, {
				switch(cue,
					0, {
						if(~debug) {postf("PERFORM: % - % \n", section, cue)};
					},
					1, {
						if(~debug) {postf("PERFORM: % - % \n", section, cue)};
					},
					2, {
						if(~debug) {postf("PERFORM: % - % \n", section, cue)};
					},
					3, {
						if(~debug) {postf("PERFORM: % - % \n", section, cue)};
					},
					4, {
						if(~debug) {postf("PERFORM: % - % \n", section, cue)};
					},
				);
			},
		);
	};

	~performNote = {|note, vel|
		if(~debug) {postf("PERFORM NOTE: % - % \n", note, vel)};
		if(~playBass)
		{~bass.next(Event.default).play;};
	};

	// manage the MIDI parsing:
	"parseMIDI.scd".loadRelative(true, {"loaded parse MIDI".postln});


});