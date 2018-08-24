// TODO
// - mockup drum pattern playing a sampler and sending MIDI events


fork{

	// load synthdefs:
	"clou_synthDefs.scd".loadRelative(true, {"loaded synthdefs".postln});

	s.sync;

	~debug = true; // post messages
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


	~initSection = {|section|
		switch(section,
			0, {
				if(~debug) {postf("INIT SECTION: %  \n", section)};
				~xxx.free;
				~xxx = Synth(\pulse, [\amp, 0, \f1, 8, \f2, 3, \chaos, 1]);
			},
			1, {
				if(~debug) {postf("INIT SECTION: %  \n", section)};
				~xxx.free;

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
						~xxx.set(\amp, 0.3);
					},
					1, {
						if(~debug) {postf("PERFORM: % - % \n", section, cue)};
						~xxx.set(\chaos, rrand(0.0, 1));
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




	// manage the MIDI parsing:
	"parseMIDI.scd".loadRelative(true, {"loaded parse MIDI".postln});


};