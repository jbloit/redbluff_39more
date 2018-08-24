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
			{~sectionChange.value(num - 1)}
			{};
		},
	);
}
);

MIDIdef.noteOn(\noteOn, {
	|vel, nn, chan |
	switch (chan,
		0, {},
		1, {
			if (vel > 0)
			{~cueChange.value(nn)}
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

