
// CLIPS

////////////////////////////////////////////////////  1  Seed clip. Run this once only.
(

Ndef(\mix).play;
TempoClock.tempo = 1;


Pdef(\kick,
	Pbind(\instrument, \kick,
		\out, ~o1.index,
		\dur, Pseq([1], inf),
		\isRest, Pseq([1, 1, 1, 1, 1, 1, 1, 1], inf).coin.not,
		\amp, Pseq([0.8], inf),
	)
).play(quant:1);

TempoClock.sched(1, {
	~p1 = Synth(\p1).set(\freq, 4000, \detune,0.3, \f0,8, \f1,4, \w0,0.98, \phasing,0, \legato,0.5, \amp,0.1, \out, ~o2);
});

~lo = Synth(\lo, [\freq,  30, \amp, 0.8,  \modBus, ~k2, \modMul, 0,  \modLag, 1.5, \out, ~o3 ]);
~roof = Synth(\roof, [\x, 0.1, \y, 0.5, \amp, 2,  \out, ~o4, \modBus, ~k1, \modMul, 0, \modLag, 0]);

~disto = Synth(\disto, [\amp, 0.1 , \smooth, 1, \mul, 0.4, \freq,  0.2 , \filterFreq, 1000,  \rezFreq, 400 , \in, ~o1 , \out, ~o7]);


)

~disto.set(\amp, 1)
~disto.set(\in, ~o1)
~disto.set(\in, ~o2)
~disto.set(\in, ~o3)
~disto.set(\in, ~o5)
~disto.set(\in, ~o1)
~disto.set(\smooth, 0.5)
~disto.set(\smooth, 0.7)
~disto.set(\smooth, 0.9)
~disto.set(\mul, 0.14)
~disto.set(\freq, 0.2)
~disto.set(\freq, 30)
~disto.set(\filterFreq, 900)
~disto.set(\rezFreq, 1900)
~disto.set(\rezFreq, 4000)
~disto.set(\rezFreq, 100)

///////////////////////////////////////////////////// 2
(
Pdef(\kick,
	Pbind(\instrument, \kick,
		\out, ~o1.index,
		\dur, Pseq([1], inf),
		\isRest, Pseq([1, 1,1, 1, 1, 1, 1, 1], inf).coin.not,
		\amp, Pseq([0.8], inf),
	)
).play(quant:1);

TempoClock.sched(1, {
	~p1.set(\freq,4000, \detune,0.3, \f0,8, \f1,4, \w0,0.98, \phasing,0, \legato,0.5, \amp,0.1, \out, ~o2);

});

~lo .set(\freq,  30, \amp, 2,  \modBus, ~k2, \modMul, 1,  \modLag, 1.5, \out, ~o3 );
~roof.set(\x, 0.8, \y, 0.5, \amp, 1,  \out, ~o4, \modBus, ~k1, \modMul, 0, \modLag, 0);
)

///////////////////////////////////////////////////// 3
(
Pdef(\kick,
	Pbind(\instrument, \kick,
		\out, ~o1.index,
		\dur, Pseq([1], inf),
		\isRest, Pseq([1, 1,1, 1, 1, 1, 1, 1], inf).coin.not,
		\amp, Pseq([0.8], inf),
	)
).play(quant:1);

TempoClock.sched(1, {
	~p1.set(\freq,4000, \detune,0.3, \f0,8, \f1,4, \w0,0.98, \phasing,0, \legato,0.5, \amp,0.1, \out, ~o2);
	~lo .set(\freq,  35, \amp, 0.8,  \modBus, ~k2, \modMul, 1,  \modLag, 0.5, \out, ~o3 );
	~roof.set(\x, 0.1, \y, 0.5, \amp, 2,  \out, ~o4, \modBus, ~k1, \modMul, 0, \modLag, 0);

});

)

///////////////////////////////////////////////////// 7
(
Pdef(\kick,
	Pbind(\instrument, \kick,
		\out, ~o1.index,
		\dur, Pseq([1], inf),
		\isRest, Pseq([1, 1,1, 1, 1, 1, 1, 1], inf).coin.not,
		\amp, Pseq([0.8], inf),
	)
).play(quant:1);

Pdef(\snare,
	Pbind(\instrument, \noise,
		\out, ~o6.index,
		\freq, Pseq([0, 1000, 3000], inf),
		\dur, Pseq([1.6, 0.3, 0.1], inf),
		\isRest, Pseq([0, 1,1], inf).coin.not,
		\amp, Pseq([1], inf),
	)
).play(quant:1);


TempoClock.sched(1, {
	~p1.set(\freq,1000, \detune,0.3, \f0,8, \f1,4, \w0,0.98, \phasing,0, \legato,0.5, \amp,0.2, \out, ~o2);
	~lo .set(\freq,  35, \amp, 0.8,  \modBus, ~k2, \modMul, 1,  \modLag, 0.5, \out, ~o3 );
	~roof.set(\x, 0.01, \y, 0.5, \amp, 2,  \out, ~o4, \modBus, ~k1, \modMul, 0, \modLag, 0);

});

)
///////////////////////////////////////////////////// 8
(
Pdef(\kick,
	Pbind(\instrument, \kick,
		\out, ~o1.index,
		\dur, Pseq([0.3, 0.7, 1]/2, inf),
		\isRest, Pseq([1, 1,1, 1, 1, 1, 1, 1], inf).coin.not,
		\amp, Pseq([0.8], inf),
	)
).play(quant:1);

Pdef(\snare,
	Pbind(\instrument, \noise,
		\out, ~o6.index,
		\freq, Pseq([1000, 3000], inf),
		\dur, Pseq([0, 1], inf),
		\isRest, Pseq([0, 1,1], inf).coin.not,
		\amp, Pseq([1], inf),
	)
).play(quant:1);


TempoClock.sched(1, {
	~p1.set(\freq,1000, \detune,0.3, \f0,8, \f1,4, \w0,0.98, \phasing,0, \legato,0.5, \amp,0.2, \out, ~o2);
	~lo .set(\freq,  35, \amp, 0.8,  \modBus, ~k2, \modMul, 1,  \modLag, 0.5, \out, ~o3 );
	~roof.set(\x, 0.01, \y, 0.5, \amp, 2,  \out, ~o4, \modBus, ~k1, \modMul, 0, \modLag, 0);

});

)

///////////////////////////////////////////////////// 4
(
Pdef(\kick,
	Pbind(\instrument, \kick,
		\out, ~o1.index,
		\dur, Pseq([1], inf),
		\isRest, Pseq([1, 1,1, 1, 1, 1, 1, 1], inf).coin.not,
		\amp, Pseq([0.8], inf),
	)
).play(quant:1);

TempoClock.sched(1, {
	~p1.set(\freq,4000, \detune,0.3, \f0,8, \f1,4, \w0,0.98, \phasing,0, \legato,0.1, \amp,0.1, \out, ~o2);
	~lo .set(\freq,  40, \amp, 0.8,  \modBus, ~k2, \modMul, 1,  \modLag, 1.5, \out, ~o3 );
	~roof.set(\x, 0.1, \y, 0.5, \amp, 2,  \out, ~o4, \modBus, ~k1, \modMul, 0, \modLag, 0);

});

)

Pdef(\snare).stop

///////////////////////////////////////////////////// 5
(
Pdef(\kick,
	Pbind(\instrument, \kick,
		\out, ~o1.index,
		\dur, Pseq([1, 1/4, 1/8], inf),
		\isRest, Pseq([1, 1, 0, 1, 1, 0, 1, 1], inf).coin.not,
		\amp, Pseq([0.8], inf),
	)
).play(quant:1);

TempoClock.sched(1, {
	~p1.set(\freq,4000, \detune,0.3, \f0,8, \f1,4, \w0,0.98, \phasing,0, \legato,0.1, \amp,0.1, \out, ~o2);
	~lo .set(\freq,  40, \amp, 0.8,  \modBus, ~k2, \modMul, 0.4,  \modLag, 0.5, \out, ~o3 );
	~roof.set(\x, 0.1, \y, 0.5, \amp, 2,  \out, ~o4, \modBus, ~k1, \modMul, 0, \modLag, 0);

});
)

///////////////////////////////////////////////////// 6
(
Pdef(\kick,
	Pbind(\instrument, \kick,
		\out, ~o1.index,
		\dur, Pseq([1/2], inf),
		\isRest, Pseq([1, 1, 1], inf).coin.not,
		\amp, Pseq([0.8], inf),
	)
).play(quant:1);

Pdef(\snare,
	Pbind(\instrument, \noise,
		\out, ~o6.index,
		\freq, 1000,
		\dur, Pseq([1], inf),
		\isRest, Pseq([0, 1], inf).coin.not,
		\amp, Pseq([1], inf),
	)
).play(quant:1);



TempoClock.sched(1, {
	~p1.set(\freq,4000, \detune,0.3, \f0,8, \f1,4, \w0,0.98, \phasing,0, \legato,0.1, \amp,0.1, \out, ~o2);
	~lo .set(\freq,  40, \amp, 0.8,  \modBus, ~k2, \modMul, 0.4,  \modLag, 0.5, \out, ~o3 );
	~roof.set(\x, 0.1, \y, 0.5, \amp, 2,  \out, ~o4, \modBus, ~k1, \modMul, 0, \modLag, 0);

});

)


















)

TempoClock.sched(1, {
	~p1.set(\freq,4000, \detune,0, \f0,8, \f1,2, \w0,0.99, \phasing,0, \legato,0.01, \amp,0.2, \out, ~o2);
	~lo .set(\freq,  30, \amp, 0.8,  \modBus, ~k2, \modMul, 0.4,  \modLag, 0, \out, ~o3 );
	~roof.set(\x, 0.01, \y, 0.01, \amp, 2,  \out, ~o4, \modBus, ~k1, \modMul, 1, \modLag, 0);
});


()
Ndef(\lfo, {LFTri.ar(30,mul:0.9, add:0.5)}).play(0,4);
Ndef(\p1).set(\freq, 4000, \detune,0, \f0,6.5, \f1,2.7, \w0, 0.7, \phasing,0, \legato,0.1, \amp,0.2).play(0,2);
Ndef(\roof).set(\x, 0.01, \y, 0.01, \amp, ~b1.asMap).play;
)














(
~p1.set(\freq, 4000, \detune,0.3, \f0,6.5, \f1,2.7, \w0,0.98, \phasing,0, \legato,0.5, \amp,0.1).play(0,2);
Ndef(\roof).set(\x, 0.1, \y, 0.5, \amp, ~b1.asMap).play;
Ndef(\lfo, {LFTri.ar(1.2,mul:0.5, add:0.1)}).play(4, 0);
)

(
Ndef(\p1).set(\freq, 4000, \detune,0.3, \f0,6.5, \f1,2.7, \w0,0.98, \phasing,0, \legato,0.5, \amp,0.1).play(0,2);
Ndef(\roof).set(\x, 0.1, \y, 0.5, \amp, ~b1.asMap).play;
Ndef(\lfo, {LFTri.ar(1.2,mul:0.5, add:0.1)}).play(4,0);
Ndef(\roof).map(\x, Ndef(\lfo));
)

(
Ndef(\p1).set(\freq, 4000, \detune,0.3, \f0,6.5, \f1,2.7, \w0,0.98, \phasing,0, \legato,0.5, \amp,0.1).play(0,2);
Ndef(\roof).set(\x, 0.1, \y, 0.5, \amp, ~b1.asMap).play;
Ndef(\roof).map(\x, Ndef(\lfo));
Ndef(\lfo, {LFTri.ar(30,mul:0.5, add:0.5)}).play(0,0);
)

(
Ndef(\p1).set(\freq, 1000, \detune,0.3, \f0,6.5, \f1,2.7, \w0,0.98, \phasing,0, \legato,0.5, \amp,0.1).play(0,2);
Ndef(\roof).set(\x, 0.1, \y, 0.5, \amp, ~b1.asMap).play;
Ndef(\roof).map(\x, Ndef(\lfo));
Ndef(\lfo, {LFTri.ar(30,mul:0.5, add:0.5)}).play(0,4);
)

(
Ndef(\p1).set(\freq, 4000, \detune,0.3, \f0,6.5, \f1,2.7, \w0, 0.8, \phasing,0, \legato,0.1, \amp,0.1).play(0,2);
Ndef(\roof).set(\x, 0.1, \y, 0.5, \amp, ~b1.asMap).play;
Ndef(\roof).map(\x, Ndef(\lfo));
Ndef(\lfo, {LFTri.ar(30,mul:0.5, add:0.5)}).play(0,4);
)

(
Ndef(\p1).set(\freq, 1000, \detune,0, \f0,6.5, \f1,2.7, \w0, 0.1, \phasing,0, \legato,0.1, \amp,0.1).play(0,2);
Ndef(\roof).set(\x, 0.1, \y, 0.5, \amp, ~b1.asMap).play;
Ndef(\roof).map(\x, Ndef(\lfo));
Ndef(\lfo, {LFTri.ar(30,mul:0.5, add:0.5)}).play(0,4);
)

(
Ndef(\lfo, {LFTri.ar(30,mul:0.9, add:0.5)}).play(4,4);
Ndef(\p1).set(\freq, 4000, \detune,0, \f0,6.5, \f1,2.7, \w0, 0.9, \phasing,0, \legato,0.1, \amp,0.1).play(0,2);
Ndef(\roof).set(\x, 0.1, \y, 0.5, \amp, ~b1.asMap).play;
)

(
Ndef(\p1).set(\freq, 2000, \detune,0, \f0,6.5, \f1,2.7, \w0, 0.1, \phasing,0, \legato,0.1, \amp,0.1).play(0,2);
Ndef(\roof).set(\x, 0.1, \y, 0.5, \amp, ~b1.asMap).play;
Ndef(\roof).map(\x, Ndef(\lfo));
Ndef(\lfo, {LFTri.ar(50,mul:0.5, add:0.5)}).play(0,4);
)

(
Ndef(\lfo, {LFTri.ar(30,mul:0.9, add:0.5)}).play(0,4);
Ndef(\p1).set(\freq, 4000, \detune,0, \f0,6.5, \f1,2.7, \w0, 0.5, \phasing,0, \legato,0.1, \amp,0.2).play(0,2);
Ndef(\roof).set(\x, 0.01, \y, 0.01, \amp, ~b1.asMap).play;
)

(
Ndef(\lfo, {LFTri.ar(30,mul:0.9, add:0.5)}).play(4,4);
Ndef(\p1).set(\freq, 1000, \detune,0, \f0,6.5, \f1, 2.7, \w0, 0.5, \phasing,0, \legato,0.3, \amp,0.2).play(0,2);
Ndef(\roof).set(\x, 0.01, \y, 0.01, \amp, ~b1.asMap).play;
)

(
Ndef(\lfo, {LFTri.ar(30,mul:0.9, add:0.5)}).play(0,4);
Ndef(\p1).set(\freq, 4000, \detune,0, \f0,6.5, \f1,2.7, \w0, 0.6, \phasing,0, \legato,0.1, \amp,0.2).play(0,2);
Ndef(\roof).set(\x, 0.01, \y, 0.01, \amp, ~b1.asMap).play;
)

(
Ndef(\lfo, {LFTri.ar(30,mul:0.9, add:0.5)}).play(4,4);
Ndef(\p1).set(\freq, 1000, \detune,0, \f0,6.5, \f1, 2.7, \w0, 0.6, \phasing,0, \legato,0.3, \amp,0.2).play(0,2);
Ndef(\roof).set(\x, 0.01, \y, 0.01, \amp, ~b1.asMap).play;
)


(
Ndef(\lfo, {LFTri.ar(30,mul:0.9, add:0.5)}).play(0,4);
Ndef(\p1).set(\freq, 4000, \detune,0, \f0,6.5, \f1,2.7, \w0, 0.7, \phasing,0, \legato,0.1, \amp,0.2).play(0,2);
Ndef(\roof).set(\x, 0.01, \y, 0.01, \amp, ~b1.asMap).play;
)

(
Ndef(\lfo, {LFTri.ar(30,mul:0.9, add:0.5)}).play(0,4);
Ndef(\p1).set(\freq,  4000, \detune,0, \f0,6.5, \f1, 3.7, \w0, 0.7, \phasing,0, \legato,0.01, \amp,0.15).play(0,2);
Ndef(\roof).set(\x, 0.4, \y, 1, \amp, 0.4).play;
)

(
Ndef(\lfo, {LFTri.ar(60,mul:0.9, add:0.5)}).play(0,4);
Ndef(\p1).set(\freq, 4000, \detune,0, \f0,6.5, \f1,2.7, \w0, 0.7, \phasing,0, \legato,0.1, \amp,0.2).play(0,2);
Ndef(\roof).set(\x, 0.01, \y, 0.01, \amp, ~b1.asMap).play;
)

(
Ndef(\lfo, {LFTri.ar(30,mul:0.9, add:0.5)}).play(0,4);
Ndef(\p1).set(\freq,  4000, \detune,0, \f0,6.5, \f1, 3.7, \w0, 0.7, \phasing,0, \legato,0.01, \amp,0.15).play(0,2);
Ndef(\roof).set(\x, 0.4, \y, 1, \amp, 0.4).play;
)


(
Ndef(\lfo, {LFTri.ar(60,mul:0.9, add:0.5)}).play(0,4);
Ndef(\p1).set(\freq, 4000, \detune,0, \f0,6.5, \f1,2.7, \w0, 0.7, \phasing,0, \legato,0.1, \amp,0.2).play(0,2);
Ndef(\roof).set(\x, 0.01, \y, 0.01, \amp, ~b1.asMap).play;
)

(
Ndef(\lfo, {LFTri.ar(30,mul:0.9, add:0.5)}).play(0,4);
Ndef(\p1).set(\freq,  4000, \detune,0, \f0,6.5, \f1, 3.7, \w0, 0.9, \phasing,0, \legato,0.01, \amp,0.15).play(0,2);
Ndef(\roof).set(\x, 0.4, \y, 1, \amp, ~b1.asMap).play;
)


(
Ndef(\lfo, {LFTri.ar(60,mul:0.9, add:0.5)}).play(0,4);
Ndef(\p1).set(\freq, 4000, \detune,0, \f0,6.5, \f1,2.7, \w0, 0.7, \phasing,0, \legato,0.1, \amp,0.2).play(0,2);
Ndef(\roof).set(\x, 0.01, \y, 0.01, \amp, ~b1.asMap).play;
)


(
Ndef(\lfo, {LFTri.ar(60,mul:0.9, add:0.5)}).play(0,4);
Ndef(\p1).set(\freq, 4000, \detune,0, \f0,6.5, \f1,2.7, \w0, 0.7, \phasing,0, \legato,0.1, \amp,0.2).play(~a2, 1);
Ndef(\roof).set(\x, 0.01, \y, 0.01, \amp, ~b1.asMap).play;



Ndef(\roof).play(~a1,1);
Ndef(\roof).stop;

{In.ar(~a1.index)}.play(0)
Ndef(\roof).play(0);


Ndef(\test, {|in=0|
	Compander.ar(LFPar.ar(), In.ar(~a2),
		thresh: MouseX.kr(0.01,0.5),
		slopeBelow: 30,
		slopeAbove:  1,
		clampTime:   0.01,
		relaxTime:   0.01
	)
}).play;

)

(
Ndef(\lfo, {LFTri.ar(60,mul:0.6, add:0.5)}).play(0,4);
Ndef(\p1).set(\freq,  4000, \detune,0, \f0,6.5, \f1, 3.7, \w0, 0.9, \phasing,0, \legato,0.01, \amp,0.15).play(0,2);
Ndef(\roof).set(\x, 0.4, \y, 0.1, \amp, ~b1.asMap).play;
)


(
Ndef(\lfo, {LFTri.ar(60,mul:0.6, add:0.5)}).play(0,4);
Ndef(\p1).set(\freq,  4000, \detune,0, \f0,6.5, \f1, 9.7, \w0, 0.1, \phasing,0, \legato,0.1, \amp,0.15).play(0,2);
Ndef(\roof).set(\x, 0.4, \y, 0.1, \amp, ~b1.asMap).play;
)

(
Ndef(\lfo, {LFTri.ar(30,mul:0.6, add:0.5)}).play(0,4);
Ndef(\p1).set(\freq,  1000, \detune,0, \f0,6.5, \f1, 0.1, \w0, 0.1, \phasing,0, \legato,0.1, \amp,0.15).play(0,2);
Ndef(\roof).set(\x, 0.1, \y, 0.1, \amp, ~b1.asMap).play;
)


(
Ndef(\lfo, {LFTri.ar(30,mul:0.6, add:0.5)}).play(0,1);
Ndef(\p1).set(\freq,  4000, \detune,0, \f0,6.5, \f1, 0.1, \w0, 0.89, \phasing,0, \legato,0.1, \amp,0.015).play(0,2);
Ndef(\roof).set(\x, 0.4, \y, ~b1.asMap, \amp, 0.3).play;
)

(
Ndef(\lfo, {LFTri.ar(60,mul:0.6, add:0.5)}).play(1,1);
Ndef(\p1).set(\freq,  4000, \detune,0, \f0,6.5, \f1, 0.1, \w0, 0.89, \phasing,0, \legato,0.1, \amp,0.015).play(0,2);
Ndef(\roof).set(\x, 0.4, \y, ~b1.asMap, \amp, 0.3).play;
)


(
Ndef(\lfo, {LFTri.ar(30,mul:0.6, add:0.5)}).play(0,1);
Ndef(\p1).set(\freq,  4000, \detune,0, \f0,6.5, \f1, 0.1, \w0, 0.89, \phasing,0, \legato,0.1, \amp,0.015).play(0,2);
Ndef(\roof).set(\x, 0.4, \y, ~b1.asMap, \amp, 0.3).play;
)

(
Ndef(\lfo, {LFTri.ar(3,mul:0.6, add:0.5)}).play(0,2);
Ndef(\p1).set(\freq,  4000, \detune,0, \f0,6.5, \f1, 0.1, \w0, 0.89, \phasing,0, \legato,Ndef(\lfo), \amp,0.015).play(0,2);
Ndef(\roof).set(\x, 0.4, \y, 0.1, \amp, 0.1).play;
)

(
Ndef(\lfo, {LFTri.ar(1,mul:0.6, add:0.5)}).play(0,2);
Ndef(\p1).set(\freq,  4000, \detune,0, \f0,6.5, \f1, 0.1, \w0, 0.5, \phasing,0, \legato,Ndef(\lfo), \amp,0.005).play(0,2);
Ndef(\roof).set(\x, 0.4, \y, 0.9, \amp, 0.1).play;
)

(
Ndef(\lfo, {LFTri.ar(0.8,mul:0.4, add:0.8)}).play(0,2);
Ndef(\p1).set(\freq,  4000, \detune,0, \f0,6.5, \f1, 0.1, \w0, 0.5, \phasing,0, \legato,Ndef(\lfo), \amp,0.005).play(0,2);
Ndef(\roof).set(\x, 0.8, \y, 0.9, \amp, 0.01).play;
)

(
Ndef(\lfo, {LFTri.ar(0.8,mul:0.4, add:0.8)}).play(0,2);
Ndef(\p1).set(\freq,  4000, \detune,0, \f0,6.5, \f1, 0.1, \w0, 0.5, \phasing,0, \legato,Ndef(\lfo), \amp,0.005).play(0,2);
Ndef(\roof).set(\x, 0.8, \y, 0.9, \amp, 0.01).play;
)

(
Ndef(\roof).set(\x, 1, \y, 0.9, \amp, 0.001).play;
Ndef(\lfo).stop;
Ndef(\p1).stop;
)




(
Ndef(\roof).stop;
Ndef(\lfo).stop;
Ndef(\p1).stop;
)


