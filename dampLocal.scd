/**
This script exemplifies the use of SuperCollider on Bela.
When a project contains a `_main.scd` file, `sclang` is started
and the content of the file is executed.
If you want to interact with SuperCollider running on the board
from within the SuperCollider IDE on your computer, check out
the 12-SuperCollider/remote examples instead.
Those files also include more code examples to interface with
Bela-specific UGens.
 */
s = Server.default;

s.options.numAnalogInChannels = 8;
s.options.numAnalogOutChannels = 8;
s.options.numDigitalChannels = 16;

s.options.blockSize = 16;
s.options.numInputBusChannels = 2;
s.options.numOutputBusChannels = 2;

s.options.postln;

s.waitForBoot({

	SynthDef.new(\mic, {
		|in=0, out=0, deltime=0.1, mix=(-0.5), decay=3, amp=1|
		var sig, delay;
		sig = SoundIn.ar(in!2)*amp;
		delay = CombL.ar(sig, 0.5, deltime, decay);
		sig = XFade2.ar(sig, delay, mix);
		Out.ar(out, sig);
	}).add;
	Synth(\mic);
});
