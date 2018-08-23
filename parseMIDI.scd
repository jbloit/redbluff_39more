MIDIClient.init;
MIDIIn.connectAll;

// MIDIFunc.trace;
// to turn tracing off:
// MIDIFunc.trace( false );

// channel 0 = TMC6 (==channel 1 in max)
// channel 1 = softstep controller (==channel 2 in max and in softstep editor)


MIDIdef.program(\program, {|num, chan|

	switch (chan,
		0, {},
		1, {
			if (num > 0)
			{~cueChange.value(num)}
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
			{~subcueChange.value(nn)}
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

