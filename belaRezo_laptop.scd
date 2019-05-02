/*
Use cases for running an scsynth on a remote Bela, and editing on a local laptop.
The goal is remain in the flow while editing, avoid rebooting the server after each new edit.
*/

// Connect to remote server on Bela (after booting the serever on Bela)

(
Server.default = s = Server("belaServer", NetAddr("192.168.7.2", 57110));
s.initTree;
s.startAliveThread;
)

// ----------------------------------------------------------  test Audio out
(
{SinOsc.ar(mul:0.1)!2}.play
)
s.freeAll;

(
SynthDef(\sine, {|out=0|
	Out.ar(out, SinOsc.ar(mul:0.1)!2);
}).add;
a = Synth(\sine);
)
a.free;

// ----------------------------------------------------------  test Audio IN/OUT (DELAY FX)

(
SynthDef.new(\mic, {
	|in=0, out=0, deltime=0.3, mix=(-0.5), decay=3, amp=1|
	var sig, delay;
	sig = SoundIn.ar(in)*amp;
	//	delay = CombL.ar(sig, 0.5, deltime, decay);
	//	sig = XFade2.ar(sig, delay, mix);
	Out.ar(out, sig);
}).add;
)

(
SynthDef(\rez,{
		|in=0, out = 0, pitchNorm= 1, timbre=0.1, amp=1|
		var sig;
		var input = In.ar(in, 1);
		sig = DynKlank.ar(`[[800, 1071, 1153, 1723] * pitchNorm, [1,1,1,1]*timbre, [1, 1, 1, 1]*timbre], input);
		Out.ar(out, sig*amp);
	}).add;
)

s.freeAll;
x = Synth(\mic);
y = Synth.after(x, \cross);
z = Synth.after(x, \rez);


x.free;
y.free;

(
MIDIdef.cc(\ccCheck, {
	|val, cc|
	val.postln;
	z.set(\pitchNorm, cc.linlin(0, 5, 0, 1));
	z.set(\timbre, val.linlin(0, 127, 0, 1));
	z.set(\amp, val.linlin(0, 127, 0, 1));

});
)
