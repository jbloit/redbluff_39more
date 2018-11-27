currentEnvironment.clear;
s.latency = 0.01;
// s.reboot;

s.waitForBoot({

	// load synthdefs:
	"clou_synthDefs.scd".loadRelative(true, {"loaded synthdefs".postln});

	s.sync;
	~debug = true; // post messages

	// ------------------------------------------------------------ LEVELS------------------------------------
	~bBeat = Bus.audio(s, 2);
	~bBass = Bus.audio(s,2);
	~bFx = Bus.audio(s, 2);

	~levelBeat = Synth(\gain, [\in, ~bBeat, \gain, 0.5], ~fx);
	~levelBass = Synth(\gain, [\in, ~bBass, \gain, 0.5], ~fx);
	~levelFx = Synth(\gain, [\in, ~bFx, \gain, 0.5], ~fx);

	~levelBeat.set(\gain, 0.2);
	~levelBass.set(\gain, 1);
	~levelFx.set(\gain, 0);

	// ------------------------------------------------------------ INIT MUSIC STUFF ------------------------------------


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
		~beat = Synth(\pulse, [\out, ~bBeat, \amp, 0, \f1, 8, \f2, 3, \chaos, 1], ~src);
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
		postf("perc in % % \n", nn, vel);
		Synth(\perc, [\out, ~bBass,  \freq, pitch.midicps, \amp, amp], ~src);
	};

	// ------------------------------------------------------
	~cues[0,1] = {
		if(~debug) {postf("CUE: 0 - 1 \n")};
		~beat.set(\chaos, rrand(0.0, 1));
	};
	~trigs[0, 1] = {|nn, vel|
		var pitch, amp;
		pitch = nn + 37;
		amp = vel / 127;
		Synth(\perc, [\out, ~bBass, \freq, pitch.midicps, \amp, amp], ~src);
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