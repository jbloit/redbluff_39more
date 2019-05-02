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
SynthDef(\cross,{arg amp=0.1,smooth=0.3,mul=1,freq=0.2, filterFreq=432, in=0, out=0;
	var sig = SoundIn.ar(in,2);
	filterFreq = filterFreq.clip(50, 2000);
	sig = CrossoverDistortion.ar(sig,amp,SinOsc.ar([freq,freq+0.5],0,0.1,smooth),mul);
	// sig = FreeVerb.ar(sig,0.5,0.5);
	sig = sig + CombC.ar(sig,0.1,1/8,0.1);
	sig = sig ;
	//sig = SineShaper.ar(sig, 1,0.5);
	sig = BRF.ar(sig,filterFreq,15,-10);
	sig = HPF.ar(sig,filterFreq/2);
	//	sig = Limiter.ar(sig,0.5);
	sig = LeakDC.ar(sig);
	sig = Compander.ar(sig,In.ar(4,2),0.1,1,0.25,0.1,0.01);
	// sig = [DelayL.ar(sig*(-1),0.1,SinOsc.kr(-0.1,0,0.05,0.1)),DelayL.ar(sig*(-1),0.1,SinOsc.kr(0.1,0,0.05,0.1))]*0.1;
	Out.ar(out, sig);
}).add;
)

s.freeAll;
x = Synth(\mic);
y = Synth.after(x, \cross);

x.free;
y.free;

(
MIDIdef.cc(\ccCheck, {
	|val, cc|
	val.postln;
	y.set(\smooth, val.linlin(0, 127, 1, 0));
	y.set(\amp, val.linlin(0, 127, 1, 0));
	y.set(\freq, cc.linlin(0, 5, 0, 100));
	y.set(\filterFreq, val.linlin(0, 127, 200, 1000));
});
)
