(
Server.default = s = Server("belaServer", NetAddr("192.168.7.2", 57110));
s.initTree;
s.startAliveThread;
)


// Conduite:
// 1 avoir des synths de base (en version Ndef !!!) en debut de fichier et les dupliquer. je ne peux pas coder en live. mais je peux
// hacker en live. ca suffira pour un debut.
// commencer avec des sons aigus
// 2. le dupliquer
// 3. rajouter des bus
// 4. mapper vers Ocoast, pour ajouter des basses
// ajouter une nappe et un bus disto
// avoir des Ndef de LFO

(

// make a DC synth (the DC ugen doesn't allow modulation)
SynthDef(\dc, {|val=0, out=2|
	AnalogOut.ar(out, SinOsc.ar(0, add:val));
}).add;
)

(
~c1 = Bus.control(s, 1);
~c2 = Bus.control(s, 1);
~c3 = Bus.control(s, 1);
~c4 = Bus.control(s, 1);


(
Ndef(\noise, {|out=0, freq=55, detune=0.3, f0=6, f1=2.7, w0=0.98, phasing=0, legato=0.5|
	var sig, env, env2, trig, sig2,outSig;
	trig = Pulse.ar(f0, w0);
	env = EnvGen.ar(Env.adsr(releaseTime:SinOsc.ar(f1, 0, 1, legato)), trig);
	env2 = DelayC.ar(env, 0.2, phasing);
	Out.kr(~c1, Amplitude.kr(trig));
	sig = LFPar.ar([freq, freq*2], mul:0.5);
	Out.kr(~c2, Amplitude.kr(sig));
	sig2 = LFPar.ar([freq, freq*2] + detune.linlin(0, 1, 0, 3), mul:0.6);
	Out.kr(~c3, Amplitude.kr(sig2));
	outSig = Splay.ar([sig * env, sig2 * env2]);
	Out.ar(out, outSig );
	Out.kr(~c4, Amplitude.kr(outSig));
});
)

~pitch = Synth(\dc, [\out, 2]);
~decay = Synth(\dc, [\out, 3]);
~balance = Synth(\dc, [\out, 4]);
~overtone = Synth(\dc, [\out, 5]);

Ndef(\noise).stop;
Ndef(\noise).play;

s.freeAll;



(
~pitch.set(\val, 0.1);
~decay.set(\val, 0.1);
~balance.set(\val, 1);
~overtone.set(\val, 1);
)

(
~pitch.set(\val, 1.2);
~decay.set(\val, 0.3);
~balance.set(\val, 1);
~overtone.set(\val, 1);
)
Ndef(\noise).set(\freq, 40, \legato, 0.2, \f0, 8,\f1, 0.8, \phasing, 9);
Ndef(\noise).set(\freq, 8040, \legato, 0.2, \f0, 8,\f1, 0.8, \phasing, 10);



(
~pitch.map(\val, ~c1.index);
~decay.map(\val, ~c2.index);
~balance.map(\val, ~c3.index);
~overtone.map(\val, ~c4.index);
)

(
~pitch.map(\val, ~c3.index);
~decay.map(\val, ~c3.index);
~balance.map(\val, ~c2.index);
~overtone.map(\val, ~c1.index);
)

(
~pitch.map(\val, ~c1.index);
~decay.map(\val, ~c1.index);
~balance.map(\val, ~c1.index);
~overtone.map(\val, ~c1.index);
)

(
~pitch
~pitch.map(\val, ~c4.index);
~decay.map(\val, ~c3.index);
~balance.map(\val, ~c1.index);
~overtone.map(\val, ~c1.index);
)


(
~pitch.map(\val, ~c3.index);
~decay.map(\val, ~c3.index);
~balance.map(\val, ~c3.index);
~overtone.map(\val, ~c3.index);
)


(
~pitch.map(\val, ~c4.index);
~decay.map(\val, ~c4.index);
~balance.map(\val, ~c4.index);
~overtone.map(\val, ~c4.index);
)


Ndef(\noise).set(\freq, 4000, \legato, 0.1, \f0, 8,\f1, 2.7, \phasing, 9);
Ndef(\noise).set(\freq, 40, \legato, 0.2, \f0, 8,\f1, 0.8, \phasing, 9);
Ndef(\noise).set(\freq, 40, \legato, 0.4, \f0, 8,\f1, 0.9, \phasing, 0.1);
Ndef(\noise).set(\freq, 40, \legato, 0.4, \f0, 8,\f1, 0.9, \phasing, 0.1,\detune, 1.3);
Ndef(\noise).set(\freq, 40, \legato, 0.1, \f0, 8,\f1, 1.8, \phasing, 0, \detune, 2);
Ndef(\noise).set(\freq, 40, \legato, 0.1, \f0, 9,\f1, 8, \phasing, 0, \detune, 2);


Ndef(\noise).set(\freq, 4000, \legato, 0.1, \f0, 8,\f1, 3.7, \phasing, 1);
Ndef(\noise).set(\freq, 4000, \legato, 0.1, \f0, 8,\f1, 4.7, \phasing, 1);

Ndef(\noise).set(\freq, 10030, \legato, 0.01, \f0, 8,\f1, 0.5, \phasing, 1);
Ndef(\noise).set(\freq, 200, \legato, 0.1, \f0, 8,\f1, 0.9, \detune, 0.9);
Ndef(\noise).set(\freq, 100, \legato, 0.1, \f0, 8,\f1, 1.9, \detune, 0.2);
Ndef(\noise).set(\freq, 100, \legato, 0.9, \f0, 8,\f1, 0.9, \detune, 0.9);



// todo : practice live setting each param one at the time