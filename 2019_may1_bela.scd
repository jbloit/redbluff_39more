MIDIClient.init;
MIDIIn.connectAll;
MIDIFunc.trace(false);



when running from laptop:
(
Server.default = s = Server("belaServer", NetAddr("192.168.7.2", 57110));
s.initTree;
s.startAliveThread;
)

(
SynthDef(\mic, {
	|in=0, out=0|
	var sig;
	sig = SoundIn.ar(in);
	Out.ar(out, sig);
}).add;


SynthDef(\comb,{arg freq=1/10000, in=0, out=0;
	var sig = In.ar(in,1);
	sig = sig + CombC.ar(sig,0.1,freq,0.1);
	sig = Compander.ar(sig,In.ar(4,2),0.1,1,0.25,0.1,0.01);
	Out.ar(out, sig);
}).add;



SynthDef(\help_sinegrain,
	{ arg out=0, freq=440, sustain=0.05, amp=1;
		var env;
		env = EnvGen.kr(Env.perc(0.01, sustain, 0.5), doneAction:2);
		Out.ar(out, SinOsc.ar(freq, 0, env)*amp)
}).add;


// make a DC synth (the DC ugen doesn't allow modulation)
SynthDef(\dc, {|val=0, out=2|
	AnalogOut.ar(out, SinOsc.ar(0, add:val));
}).add;
)

(
a = [1, 2, 0, 3, 7] * 100 ;

~step = 0;

~combBus = Bus.audio(s, 1);

~in0 = Synth(\mic, [\in, 0, \out, 0]);
~in1 = Synth(\mic, [\in, 1, \out, 1]);
~in2 = Synth(\mic, [\in, 2, \out, 2]);
~in3 = Synth(\mic, [\in, 3, \out, 3]);
~comb = Synth.after(~in1, \comb, [\in,  ~combBus, \out, 1]);
~pitch = Synth(\dc, [\out, 2]);
~decay = Synth(\dc, [\out, 3]);
~balance = Synth(\dc, [\out, 4]);
~overtone = Synth(\dc, [\out, 5]);
)


// PERF
(
~in2.set(\out, ~combBus);
~in3.set(\out, ~combBus);
)

(
~in3.set(\out, 3);
)

(
~in0.set(\out, 0);
~in1.set(\out, 1);
~in2.set(\out, 2);
~in3.set(\out, 666);
a = [1, 2, 0, 3, 7] * 50 ;
)

(
~in1.set(\out, ~combBus);
~in2.set(\out, ~combBus);
~in3.set(\out, ~combBus);
a = [1, 2, 0, 3, 7] * 50 ;
)

(
~in1.set(\out, ~combBus);
~in2.set(\out, ~combBus);
~in3.set(\out, ~combBus);
a = [0, 2, 0, 3, 0, 8] * 50 ;
)

(
~in1.set(\out, ~combBus);
~in2.set(\out, ~combBus);
~in3.set(\out, ~combBus);
a = [0, 2, 0, 1, 0, 1]  ;
)


(
~in1.set(\out, 1);
~in2.set(\out, ~combBus);
~in3.set(\out, 3);
a = [0, 2, 0, 0, 9] * 300 ;
)


(
s.freeAll;
)


(
~in1.set(\out, ~combBus);
~in2.set(\out, ~combBus);
~in3.set(\out, ~combBus);
a = [0, 2, 0, 4] * 300 ;
)

(
~in1.set(\out, ~combBus);
~in2.set(\out, ~combBus);
~in3.set(\out, ~combBus);
a = [0, 2, 0, 4, 9] * 300 ;
)

(
~in1.set(\out, ~combBus);
~in2.set(\out, ~combBus);
~in3.set(\out, ~combBus);
a = [0, 1, 1, 0] * 200 ;
)



(
MIDIdef.noteOn(\hatOn, {| val, num, chan|
	// val.postln;

	~step = ~step + 1;
	~step = ~step % a.size;

	~in1.set(\out, ~combBus);
	~in2.set(\out, ~combBus);
	~in3.set(\out, ~combBus);
	a = [0, 1, 1, 0] * 200 ;

	Synth(\help_sinegrain, [\freq, a[~step, \amp, 4]]);
	~comb.set(\freq, ~step * 0.009);

	~pitch.set(\val,  a[~step]*0.0001);
	~overtone.set(\val, ~step);
}, chan: 2);

)


(
a = [0, 1, 1, 0] * 200 ;
MIDIdef.noteOn(\hatOn, {| val, num, chan|
	// val.postln;
	~step = ~step + 1;
	~step = ~step % a.size;

	// ~step.postln;

	Synth(\help_sinegrain, [\freq, a[~step, \amp, 4]]);
	~comb.set(\freq, ~step * 0.009);

	~pitch.set(\val,  a[~step]*0.001);
	~overtone.set(\val, ~step);
}, chan: 2);

)


(
a = [1, 2, 0, 3, 3] ;
MIDIdef.noteOn(\hatOn, {| val, num, chan|
	// val.postln;
	~step = ~step + 1;
	~step = ~step % a.size;

	// ~step.postln;

	Synth(\help_sinegrain, [\freq, a[~step, \amp, 4]]);
	~comb.set(\freq, a[~step] * 0.09);

	~pitch.set(\val,  a[~step]*2000);
	~overtone.set(\val, ~step);
}, chan: 2);
)



(
a = [1, 2, 0, 3, 3] ;
b = (0..127);

~aStep = 0;
~bStep = 0;
MIDIdef.noteOn(\hatOn, {| val, num, chan|
	// val.postln;
	~aStep = ~aStep + 1;
	~aStep = ~aStep % a.size;


	~bStep = ~bStep + 1;
	~bStep = ~bStep % b.size;


	// ~step.postln;

	Synth(\help_sinegrain, [\freq, a[~step, \amp, 4]]);
	~comb.set(\freq, a[~step] * 0.09);

	~pitch.set(\val,  b[~step].linlin(0, 127, 0, 1));

	~overtone.set(\val, ~step);
}, chan: 2);

)


//// Cut bass note with snare?
(
a = [1, 2, 0, 3, 3] ;
b = (0..127);

~aStep = 0;
~bStep = 0;
MIDIdef.noteOn(\hatOn, {| val, num, chan|
	// val.postln;
	~aStep = ~aStep + 1;
	~aStep = ~aStep % a.size;


	~bStep = ~bStep + 1;
	~bStep = ~bStep % b.size;


	// ~step.postln;

	Synth(\help_sinegrain, [\freq, a[~step, \amp, 4]]);
	~comb.set(\freq, a[~step] * 0.09);

	~pitch.set(\val,  b[~step].linlin(0, 127, 0, 1));

	~overtone.set(\val, ~step);
}, chan: 2);

)