s.reboot

Ndef(\fm).set(\dur, 1/t.tempo / 8)



Ndef(\fm).set(\tu, 0.9)
Ndef(\fm).set(\tu, 0.8)
Ndef(\fm).set(\tu, 0.7)



Ndef(\fm).set(\tu, 0.3)
Ndef(\fm).set(\tu, 0.5)

Ndef(\fm).set(\tu, 0.2)
Ndef(\fm).stop


(
Ndef(\fm,{arg tu=0.4, dur = 0.3, amp = 0.6;
	//var env = EnvGen.ar(Env.perc);
	var envf = EnvGen.ar(Env([10000,310,10000,13000,15000]*tu,[0.05,0.02,0.03,1-0.1]*dur).circle);
	var sig = SinOsc.ar(SinOsc.ar([envf,envf] + 30 ,0,1),0,10);
	sig = sig +(HPF.ar(WhiteNoise.ar,envf)*0.01);
	sig*10 * amp;
}).play;

)




Ndef(\fm,{arg tu=0.4;
	//var env = EnvGen.ar(Env.perc);
	var envf = EnvGen.ar(Env([10000,310,10000,13000,15000]*tu,[0.05,0.02,0.03,1-0.1]*(60/70
	/10)).circle);
	var sig = SinOsc.ar(SinOsc.ar([envf,envf].linlin(0,20000,20,20000),0,1),0,10);
	sig = sig +(HPF.ar(WhiteNoise.ar,envf)*0.01);
	sig*10;
}).play;




(
Ndef(\arp, {|out=0, freq=55, detune=0.3, f0=9, f1=2.7, w0=0.98, phasing=0, legato=0.5, amp=1|
	var sig, env, env2, trig, sig2;
	trig = Pulse.ar(f0, w0);
	env = EnvGen.ar(Env.adsr(releaseTime:SinOsc.ar(f1, 0, 1, legato)), trig).lag(0.01);
	env2 = DelayC.ar(env, 1, phasing);

	// experiment replacing oscillators (LFPulse, LFCub, LFTri, LFSaw, etc)
	sig = LFPar.ar([freq, freq*2], mul:0.5);
	sig2 = LFPulse.ar([freq, freq*2] + detune.linlin(0, 1, 0, 3), mul:0.1);
	Out.ar(out, Splay.ar([sig * env, sig2 * env2]*amp));
});
)

(
Ndef(\arp2, {|out=0, freq=8888, detune=0.3, f0=9, f1=2.7, w0=0.98, phasing=0, legato=0.5, amp=1|
	var sig, env, env2, trig, sig2;
	trig = Pulse.ar(f0, w0);
	env = EnvGen.ar(Env.adsr(releaseTime:SinOsc.ar(f1, 0, 1, legato)), trig).lag(0.01);
	env2 = DelayC.ar(env, 1, phasing);

	// experiment replacing oscillators (LFPulse, LFCub, LFTri, LFSaw, etc)
	sig = LFPar.ar([freq, freq*2], mul:0.5);
	sig2 = LFPulse.ar([freq, freq*2] + detune.linlin(0, 1, 0, 3), mul:0.1);
	Out.ar(out, Splay.ar([sig * env, sig2 * env2]*amp));
});



)


Ndef(\arp).play

Ndef(\arp).set(\amp, 0.2)
Ndef(\arp).set(\freq, 60, \legato, 0.1, \f1, 2.7)
Ndef(\arp).set(\freq, 63, \legato, 0.9, \f1, 2)
Ndef(\arp).set(\freq, 60, \legato, 0.01, \f1, 2.7)
Ndef(\arp).set(\freq, 63, \legato, 0.9, \f1, 2)
Ndef(\arp).set(\freq, 50, \legato, 0.9, \f1, 2)
Ndef(\arp).set(\freq, 50, \detune, 0.3, \legato, 0.9, \f1, 2)
Ndef(\arp).set(\freq, 50, \detune, 0.1, \legato, 0.9, \f1, 2)
Ndef(\arp).set(\freq, 50, \detune, 0.9, \legato, 0.9, \f1, 2)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.9, \f1, 2)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.9, \f0, 6, \f1, 4)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.9, \f0, 6, \f1, 5)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.9, \f0, 8, \f1, 5)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.7, \f0, 8, \f1, 5)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.6, \f0, 8, \f1, 5)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.6, \f0, 8, \f1, 6)
Ndef(\arp).set(\freq, 60, \detune, 0.2, \legato, 0.6, \f0, 8, \f1, 6)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.6, \f0, 8, \f1, 6)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.6, \f0, 8, \f1, 7)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.5, \f0, 8, \f1, 7)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.1, \f0, 8, \f1, 7, \w0, 0.98)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.1, \f0, 8, \f1, 7, \w0, 0.8)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.1, \f0, 8, \f1, 7, \w0, 0.92)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.1, \f0, 8, \f1, 7, \w0, 0.94)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.1, \f0, 8, \f1, 14, \w0, 0.94, \phasing, 0)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.1, \f0, 8, \f1, 14, \w0, 0.94, \phasing, 0.25)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.1, \f0, 8, \f1, 14, \w0, 0.94, \phasing, 0.125)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.1, \f0, 8, \f1, 14, \w0, 0.94, \phasing, 0.5)
Ndef(\arp).set(\freq, 50, \detune, 0.7, \legato, 0.9, \f0, 8, \f1, 14, \w0, 0.94, \phasing, 0.5)
Ndef(\arp).set(\freq, 50, \detune, 0.2, \legato, 0.1, \f0, 8, \f1, 14, \w0, 0.94, \phasing, 0.5)
Ndef(\arp).set(\freq, 40, \detune, 0.3, \legato, 0.1, \f0, 8, \f1, 14, \w0, 0.94, \phasing, 0.5)
Ndef(\arp).set(\freq, 60, \detune, 0.1, \legato, 0.1, \f0, 8, \f1, 14, \w0, 0.94, \phasing, 0.5)
Ndef(\arp).set(\freq, 60, \detune, 0.1, \legato, 0.8, \f0, 8, \f1, 13, \w0, 0.94, \phasing, 0.5)
Ndef(\arp).set(\freq, 200, \detune, 0.1, \legato, 0.1, \f0, 8, \f1, 13, \w0, 0.8, \phasing, 0.5)
Ndef(\arp).set(\freq, 8888, \detune, 0, \legato, 0.1, \f0, 8, \f1, 13, \w0, 0.9, \phasing, 0.125)
Ndef(\arp).set(\freq, 8888, \detune, 0, \legato, 0.1, \f0, 16, \f1, 18, \w0, 0.9, \phasing, 0.5)
Ndef(\arp).set(\freq, 8888, \detune, 0, \legato, 0.1, \f0, 10, \f1, 16, \w0, 0.9, \phasing, 0.5)

Ndef(\arp).free
Ndef(\arp).play






(
Ndef(\fm2,{arg tu=0.1;
	//var env = EnvGen.ar(Env.perc);
	var envf = EnvGen.ar(Env([10000,310,10000,13000,15000]*tu/16,[0.05,0.02,0.03,1]*0.1).circle);
	var sig = SinOsc.ar(SinOsc.ar([envf,envf],0,1),0,10)*LPF.ar(LFPulse.ar(1,0.25,0.5),100);
//	sig = sig +(HPF.ar(WhiteNoise.ar,envf)*0.01);
	sig = LeakDC.ar(sig);
	sig*2;
}).play;

)

Ndef(\fm2).stop