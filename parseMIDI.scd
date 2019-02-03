MIDIClient.init;
MIDIIn.connectAll;

// MIDIFunc.trace;
// to turn tracing off:
// MIDIFunc.trace( false );

// channels 0= TMC6
// Channels 0-3 reserved for BOPPAD
// channel 15 = softstep controller (==channel 2 in max and in softstep editor)
// on softstep, upper keys send program change events, mapped to section changes (1->5)
// lower keys send notes (0->4) mapped to cue chages.

MIDIdef.program(\program, {|num, chan|
	postf("PROGRAM CHANGE % on chan % \n", num, chan);
	switch (chan,
		0, {},
		1, {
			// program changes start at 1 in softstep.
			if (num > 0)
			{
				~currentSection = num - 1;
				post("CALLING SECTION % \n", ~currentSection);
				~sections[~currentSection].value();

			}
			{};
		},
	);
}
);

MIDIdef.noteOn(\noteOn, {
	|vel, nn, chan |
	postf("NOTE ON % % %\n", nn, vel, chan);

	if (chan==15,
		{
			if (vel > 0)
			{
				~currentCue = nn;
				~cues[~currentSection, ~currentCue].value();
			}
			{};
		},
		{
			~trigs[~currentSection, ~currentCue].value(nn, vel);
		}
	);
};
);

MIDIdef.noteOff(\noteOff, {
	|vel, nn |
	// [vel, nn].postln;
};
);

MIDIdef.cc(\cc, {
	|val|
	// val.postln;
};);

