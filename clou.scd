// have an expression midi control, to edit a pbind seq?

s.latency = 0.01;
// s.reboot;

s.waitForBoot({

	// load synthdefs:
	"clou_synthDefs.scd".loadRelative(true, {"loaded synthdefs".postln});

	s.sync;

	~debug = true; // post messages

	// ------------------------------------------------------------ INIT MUSIC STUFF ------------------------------------

	~bassSynth = nil;

	// ------------------------------------------------------------- SCORE ----------------------------------------------------
	~sections = Array.newClear(5);
	~cues = Array2D.new(5,5);
	~trigs = Array2D.new(5,5);

	~currentSection = 0;
	~currentCue = 0;

	// =====================================================
	~sections[0] = {
		if(~debug) {postf("INIT SECTION 0  \n")};
		~beat.free;
		~beat = Synth(\pulse, [\amp, 0, \f1, 8, \f2, 3, \chaos, 1]);
		~playBass = true;
	};

	// ------------------------------------------------------
	~cues[0,0] = {
		if(~debug) {postf("CUE: 0 - 0 \n")};
		~beat.set(\amp, 0.3);
		~beat.set(\f1, 8);
		~beat.set(\f2, 3);
		~beat.set(\chaos, 1);
		// ~bass = PmonoArtic(\bass, \amp, 0.1, \degree, Pseq([0, 2, 4], inf), \octave, 3, ).asStream;
	};
	~trigs[0, 0] = {|nn, vel|
		// nn is instrument coded:
		// 1: kick
		// 2: snare
		// 3: hat
		// 4: tom
		var pitch, amp;
		pitch = nn + 40;
		amp = vel / 127;
		postf("note pitch % amp % \n", pitch, amp);
		Synth(\perc, [ \freq, pitch.midicps, \amp, amp]);
		// ~bassSynth = Synth(\bass, [\freq, nn.midicps]);
	};

	// ------------------------------------------------------
	~cues[0,1] = {
		if(~debug) {postf("CUE: 0 - 1 \n")};
		~beat.set(\chaos, rrand(0.0, 1));
	};

	// ------------------------------------------------------
	~cues[0,2] = {
		if(~debug) {postf("CUE: 0 - 2 \n")};
		~beat.set(\f2, rrand(3,24))
	};

	// ------------------------------------------------------
	~cues[0,3] = {
		if(~debug) {postf("CUE: 0 - 3 \n")};
		~beat.set(\f1, [6,8].choose);
	};


	// manage the MIDI parsing:
	"parseMIDI.scd".loadRelative(true, {"loaded parse MIDI".postln});

});