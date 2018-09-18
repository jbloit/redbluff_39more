MIDIClient.init;
MIDIIn.connectAll;

// MIDIFunc.trace;
// to turn tracing off:
// MIDIFunc.trace( false );

// channel 0 = TMC6 (==channel 1 in max)
// channel 1 = softstep controller (==channel 2 in max and in softstep editor)
// on softstep, upper keys send program change events, mapped to section changes (1->5)
// lower keys send notes (0->4) mapped to cue chages.

MIDIdef.program(\program, {|num, chan|

	switch (chan,
		0, {},
		1, {
			// program changes start at 1 in softstep.
			if (num > 0)
			{
				~currentSection = num - 1;
				~sections[~currentSection].value();
			}
			{};
		},
	);
}
);

MIDIdef.noteOn(\noteOn, {
	|vel, nn, chan |
	// postf("NOTE ON % % %\n", nn, vel, chan);
	switch (chan,
		0, {
			~trigs[~currentSection, ~currentCue].value(nn, vel);
		},
		1, {
			if (vel > 0)
			{
				~currentCue = nn;
				~cues[~currentSection, ~currentCue].value();
			}
			{};
		},
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

