/*****
Run the code below from the SuperCollider IDE after you started scsynth on Bela (see -main.scd)

Make sure you have the Bela Remote SC classes are in the extensions directory of your SC installation.
Get them here: https://github.com/sensestage/bela-remote

(c) 2017: Jonathan Reus, Marije Baalman, Giulio Moro, Andrew McPherson
*****/


( // connect to the already-running remote belaserver
Server.default = s = Server("belaServer", NetAddr("192.168.7.2", 57110));
s.options.maxLogins = 4; // should match the settings on the Bela
s.initTree;
s.startAliveThread;
);

// Communicate with the server
s.plotTree; // show all active nodes
s.freeAll;  // free all nodes


{SinOsc.ar()}.play;

(
MIDIClient.init;
MIDIIn.connectAll;
)

MIDIFunc.trace;
// to turn tracing off:
MIDIFunc.trace( false );


(
~fxBus1 = Bus.audio(s, 1);
~fxBus2 = Bus.audio(s, 1);

SynthDef.new(\mic, {
	|in=0, out=0, deltime=0.1, mix=(-0.5), decay=3, amp=1|
	var soundin, sig;
	soundin= SoundIn.ar([0,1]);
	Out.ar(out, soundin);
	Out.ar(~fxBus1, soundin);

}).add;

// FX
SynthDef(\rez, {|in=0, out=0, timbre=1|
	var sig;
	var input = In.ar(in,2);
	sig = DynKlank.ar(`[[800, 1071, 1153, 1723], [1,1,1,1]*timbre, [1, 1, 1, 1]*timbre], input);
	Out.ar(out, sig);
}).add;


SynthDef(\par, {|in=0, out=0, timbre=1|
	var sig;
	var input = In.ar(in,2);
	sig = LFPar.ar(330);
	Out.ar(out, sig);
}).add;


)
(
~mic = Synth(\mic);

 ~fx1 = Synth.after(~mic, \rez, [\in, ~fxBus1]);

 //~fx2 = Synth.after(~fx1, \par, [\in, ~fxBus2]);

)
s.freeAll;
 ~fx1.free

(
MIDIdef.cc(\ccTest, {
	|val, cc|
	//cc.postln;
	switch(cc,
		1, {~fx1.set(\timbre, val/20)},
		2, {~fx2.set(\timbre, val/20)}
	);

};);

)

(
{
var in = SoundIn.ar([0,1]);
	DynKlank.ar(`[[800, 1071, 1153, 1723], nil, [1, 1, 1, 1]], in);
}.play;
)
