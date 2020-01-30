

(

// MIDIClient.init;
// MIDIIn.connectAll;



~k1 = Bus.control(s, 1);
~k2 = Bus.control(s, 1);

~a1 = Bus.audio(s,1);
~a2 = Bus.audio(s,1);

~o1 = Bus.audio(s, 1); // kick
~o2 = Bus.audio(s, 1); // pulse
~o3 = Bus.audio(s, 1); // lo
~o4 = Bus.audio(s, 1); // roof L
~o5 = Bus.audio(s, 1); // roof R
~o6 = Bus.audio(s, 1); // snare
~o7 = Bus.audio(s, 1); // disto

Ndef(\mix, {
	Splay.ar(
		[
			In.ar(~o1.index),
			In.ar(~o2.index),
			In.ar(~o3.index),
			In.ar(~o4.index),
			In.ar(~o5.index),
			In.ar(~o6.index),
			In.ar(~o7.index),

	], 0.6);
});

// PULSE
SynthDef(\p1, {|freq=4000, detune=0.3, f0=6.5, f1=2.7, w0=0.98, phasing=0, legato=0.5, amp=0.1 , out=0|
	var sig, env, env2, trig, sig2, rel;
	trig =Pulse.ar(f0, w0);
	Out.kr(~k1, Amplitude.kr(trig));
	rel = SinOsc.ar(f1, 0, 1, legato);
	env = EnvGen.ar(Env.adsr(releaseTime:rel), trig);
	sig = LFPar.ar(freq, mul:0.5);
	Out.ar(out, sig * amp * env);
}).add;


SynthDef(\kick, {|out=0, amp=1|
	var sig, envFreq, env;
	envFreq = EnvGen.kr(Env([1, 0.1, 0], [0.1, 0.3], -6), doneAction:2, levelScale:380, levelBias:10);
	env = EnvGen.kr(Env([1, 1, 0], [0.1, 0.3]), levelScale:0.4);
	sig = LFPar.ar(envFreq, mul:env) * amp;
	Out.kr(~k2, env);
	Out.ar(~a1, sig);
	Out.ar(out, sig);
}).add;


SynthDef(\noise, {|freq=100, out=0|
	var mod, sig, sig2, env;
	env = EnvGen.kr(Env.perc(0.001, 0.1), doneAction:2);
	mod = SinOsc.ar(0.1, mul:300);
	sig = PinkNoise.ar(0.5);
	sig = HPF.ar(sig, freq:800 + mod);
	freq = 	(freq  + mod).clip(1, 10000);
	sig2 = BPF.ar(sig, freq: freq);
	Out.ar(out, sig2!2);
}).add;


// ROOF DRONE
SynthDef(\roof, {|x=0.3, y=0.4, amp=0.5, out=0,  modBus, modLag=0, modMul = 1|
	var sig, mod;
	a=Saw;
	// amp.poll;
	x = x.linlin(0, 1, 100, 400);
	y = y.linlin(0, 1, 100, 400);
	sig = Splay.ar(Formant.ar(a.ar((5,7..15)*19)*99+x, a.ar((1,3..13)*29)*199+x, a.ar((3,5..11)*a.ar(3,2,3))*299+y))/3;

	// modulate the amp
	mod = In.kr(modBus, 1).linlin(0, 1,0, amp + ((amp / 2 )* modMul) );
	mod = mod.lag(modLag);

	Out.ar(out, sig * mod);
}).add;

SynthDef(\lo, {|freq = 40, amp=0.1, modBus, out=0, modLag=0, modMul = 1|
	var sig, mod;

	// modulate the frequency
	mod = In.kr(modBus, 1).linlin(0, 1, freq, freq + ((freq / 2 )* modMul) );
	mod = mod.lag(modLag);
	sig = LFTri.ar(mod, mul:amp, add:0.5 );
	Out.ar(out, sig);
}).add;


// Distortion
SynthDef(\disto,{| amp=0.1,smooth=1,mul=0.4,freq=0.2, filterFreq=1000, rezFreq=400, in=0, out=0|

	var sig = In.ar(in,1);

	filterFreq = filterFreq.clip(50, 2000);
	sig = CrossoverDistortion.ar(sig,amp,SinOsc.ar([freq,freq+0.5],0,0.1,smooth),mul);
	// sig = FreeVerb.ar(sig,0.5,0.5);
	// sig = sig + CombC.ar(sig,0.1,1/8,0.1);
	sig = sig ;
	//sig = SineShaper.ar(sig, 1,0.5);
	sig = BRF.ar(sig,filterFreq,15,-10);
	sig = HPF.ar(sig,filterFreq/2);

	sig = Resonz.ar(sig, rezFreq);

	//	sig = Limiter.ar(sig,0.5);
	sig = LeakDC.ar(sig);
	sig = Compander.ar(sig,In.ar(4,2),0.1,1,0.25,0.1,0.01);
	Out.ar(out, sig);
}).add;
// Synth(\noise, [\gate , 1])

)