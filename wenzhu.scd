
(
t = TempoClock.tempo = 60/60;



Tdef(\arrangement,{
	Ndef(\arp).clear;
	Ndef(\arp2).clear;
	Ndef(\arp3).clear;



	//////////////////////////////////////////////////////////////////////////////////////////////
	"intro".postln;

	// Ndef(\pulse, {Out.ar(0, Impulse.ar(4!2))});

	Ndef(\beat,
	    {
		        var trig, sig, freq;
		        trig = TDuty.ar(
			                Dseq([1/8], inf), // demand ugen as durations
			                0,
			                Dseq((10..1)/15, inf) // demand ugen as amplitude
		            );
			freq = Demand.ar(trig, 0, Dseq([7000], inf));
			sig = Ringz.ar(trig, freq, 0.1);
			Out.ar(0, sig!2);
	};);


	Ndef(\arp3, {|out=0, freq=55, detune=0.3, f0=8, f1=2.7, w0=0.95, phasing=0, legato=0.5, amp=0.5,rel=0.1,lpf=1000|
		var sig, env, env2, trig, sig2;
		trig = Pulse.ar(f0, w0);

		env = EnvGen.ar(Env.adsr(releaseTime:rel),trig).lag(0.01);
		env2 = DelayC.ar(env, 1, phasing);

		// experiment replacing oscillators (LFPulse, LFCub, LFTri, LFSaw, etc)
		sig = LPF.ar(LFSaw.ar([freq, freq*2]*8, mul:0.5)+LFSaw.ar([freq, freq*2]*8+0.01, mul:0.5),lpf);
		sig2 = LFPulse.ar([freq, freq*2]*8 + detune.linlin(0, 1, 0, 100), mul:0.1);
		Out.ar(out, Splay.ar([sig * env*0.5, sig2 * env2]*amp*0.4));
	});


	 7.wait;
	Ndef(\arp3).free;

	 1.wait;

	//////////////////////////////////////////////////////////////////////////////////////////////

	// "up1".postln;

	Ndef(\arp, {|out=0, freq=55, detune=0.3, f0=8, f1=2.7, w0=0.9 phasing=0, legato=0.5, amp=0.5,rel=0.1,lpf=1000|
		var sig, env, env2, trig, sig2;
		trig = Pulse.ar(f0, w0);
		env = EnvGen.ar(Env.adsr(releaseTime:rel),trig).lag(0.01);
		env2 = DelayC.ar(env, 1, phasing);

		// experiment replacing oscillators (LFPulse, LFCub, LFTri, LFSaw, etc)
		sig =LPF.ar( LFSaw.ar([freq, freq*2], mul:0.5)+LFSaw.ar([freq, freq*2]+0.01, mul:0.5),lpf);
		sig2 = LFPulse.ar([freq, freq*2] + detune.linlin(0, 1, 0, 100), mul:0.1);
		Out.ar(out, Splay.ar([sig * env*0.5, sig2 * env2]*amp));
	});

	Ndef(\arp2, {|out=0, freq=9888, detune=0.3, f0=8, f1=2.7, w0=0.9, phasing=0, legato=0.5, amp=0.5,rel=0.1|
		var sig, env, env2, trig, sig2;
		trig = Pulse.ar(f0, w0);
		env = EnvGen.ar(Env.adsr(releaseTime:rel), trig).lag(0.01);
		env2 = DelayC.ar(env, 1, phasing);

		// experiment replacing oscillators (LFPulse, LFCub, LFTri, LFSaw, etc)
		sig = LFPar.ar([freq, freq], mul:0.5);
		sig2 = LFPulse.ar([freq, freq] + detune.linlin(0, 1, 0, 3), mul:0.1);
		Out.ar(out, Splay.ar([sig * env, sig2 * env2]*amp));
	});


	Ndef(\arp3, {|out=0, freq=55, detune=0.3, f0=8, f1=2.7, w0=0.9, phasing=0, legato=0.5, amp=0.5,rel=0.1,lpf=1000|
		var sig, env, env2, trig, sig2;
		trig = Pulse.ar(f0, w0);
		env = EnvGen.ar(Env.adsr(releaseTime:rel),trig).lag(0.01);
		env2 = DelayC.ar(env, 1, phasing);
		// experiment replacing oscillators (LFPulse, LFCub, LFTri, LFSaw, etc)
		sig = LPF.ar(LFSaw.ar([freq, freq*2]*2, mul:0.5)+LFSaw.ar([freq, freq*2]*2+0.01, mul:0.5),lpf);
		sig2 = LFPulse.ar([freq, freq*2]*2 + detune.linlin(0, 1, 0, 100), mul:0.1);
		Out.ar(out, Splay.ar([sig * env*0.5, sig2 * env2]*amp*0.4));
	});


	16.wait;


	Ndef(\beat,
	    {
		        var trig, sig, freq, dec;
		        trig = TDuty.ar(
			                Dseq([1/4], inf), // demand ugen as durations
			                0,
			                Dseq((10..1)/15, inf) // demand ugen as amplitude
		            );
			freq = Demand.ar(trig, 0, Dseq([60, 60, 70, 6000, 7000], inf));
			dec = Demand.ar(trig, 0, Dseq([0.8, 0.01, 0.01, 0.01, 0.01], inf));

			sig = Ringz.ar(trig, freq, );
			Out.ar(0, sig!2);
	};);
	16.wait;



	//////////////////////////////////////////////////////////////////////////////////////////////

	Ndef(\arp).free;
	Ndef(\arp2).free;
	Ndef(\arp3).free;
	2.wait;
	"up2".postln;

	Ndef(\arp).map(\rel,Ndef(\lfo0,{SinOsc.ar(5, 0, 1, 0.1)}).asMap);
	Ndef(\arp2).map(\rel,Ndef(\lfo2,{SinOsc.ar(2.5, 0, 1, 0)}).asMap);

	Ndef(\arp, {|out=0, freq=55, detune=0.3, f0=8, f1=2.7, w0=0.9 phasing=0, legato=0.5, amp=0.5,rel=0.1,lpf=1000|
		var sig, env, env2, trig, sig2;
		trig = Pulse.ar(f0, w0);
		env = EnvGen.ar(Env.adsr(releaseTime:rel),trig).lag(0.01);
		env2 = DelayC.ar(env, 1, phasing);

		// experiment replacing oscillators (LFPulse, LFCub, LFTri, LFSaw, etc)
		sig =LPF.ar( LFSaw.ar([freq, freq*2], mul:0.5)+LFSaw.ar([freq, freq*2]+0.01, mul:0.5),lpf);
		sig2 = LFPulse.ar([freq, freq*2] + detune.linlin(0, 1, 0, 100), mul:0.1);
		Out.ar(out, Splay.ar([sig * env*0.5, sig2 * env2]*amp));
	});

	Ndef(\arp2, {|out=0, freq=9888, detune=0.3, f0=8, f1=2.7, w0=0.9, phasing=0, legato=0.5, amp=0.5,rel=0.1|
		var sig, env, env2, trig, sig2;
		trig = Pulse.ar(f0, w0);
		env = EnvGen.ar(Env.adsr(releaseTime:rel), trig).lag(0.01);
		env2 = DelayC.ar(env, 1, phasing);

		// experiment replacing oscillators (LFPulse, LFCub, LFTri, LFSaw, etc)
		sig = LFPar.ar([freq, freq], mul:0.5);
		sig2 = LFPulse.ar([freq, freq] + detune.linlin(0, 1, 0, 3), mul:0.1);
		Out.ar(out, Splay.ar([sig * env, sig2 * env2]*amp));
	});


	Ndef(\arp3, {|out=0, freq=55, detune=0.3, f0=8, f1=2.7, w0=0.9, phasing=0, legato=0.5, amp=0.5,rel=0.1,lpf=1000|
		var sig, env, env2, trig, sig2;
		trig = Pulse.ar(f0, w0);
		env = EnvGen.ar(Env.adsr(releaseTime:rel),trig).lag(0.01);
		env2 = DelayC.ar(env, 1, phasing);
		// experiment replacing oscillators (LFPulse, LFCub, LFTri, LFSaw, etc)
		sig = LPF.ar(LFSaw.ar([freq, freq*2]*2, mul:0.5)+LFSaw.ar([freq, freq*2]*2+0.01, mul:0.5),lpf);
		sig2 = LFPulse.ar([freq, freq*2]*2 + detune.linlin(0, 1, 0, 100), mul:0.1);
		Out.ar(out, Splay.ar([sig * env*0.5, sig2 * env2]*amp*0.4));
	});
	28.wait;
	1.wait;
	1.wait;
	1.wait;
	Ndef(\arp2).set(\amp,0);
	Ndef(\arp3).set(\amp,0);
	Ndef(\arp).set(\amp,0);
	1.wait;
	"up3".postln;

	Ndef(\arp).set(\amp,0.5);
	Ndef(\arp2).set(\amp,0.5);
	Ndef(\arp3).set(\amp,0.5);
	Ndef(\arp).map(\rel,Ndef(\lfo0,{SinOsc.ar(5, 0, 1, 0.1)}).asMap);
	Ndef(\arp2).map(\rel,Ndef(\lfo2,{SinOsc.ar(2.5, 0, 1, 0)}).asMap);
	Ndef(\arp).map(\f0,8);
	Ndef(\arp2).map(\f0,8);
	Ndef(\arp2).map(\w0,0.3);
	Ndef(\arp).map(\w0,0.4);
	Ndef(\arp).set(\detune, 0);


	32.wait;
	"break".postln;

	Ndef(\arp).set(\amp,0);
	Ndef(\arp2).set(\amp,0);
	Ndef(\arp3).set(\amp,0);

	"up4".postln;

	Ndef(\arp).set(\amp,0.5);
	Ndef(\arp2).set(\amp,0.5);
	Ndef(\arp3).set(\amp,0.5);

	32.wait;
	"up5".postln;


	Ndef(\arp2).map(\rel,Ndef(\lfo2,{SinOsc.ar(2.5, 0, 1, 0)}).asMap);
	Ndef(\arp2).map(\f0,16);
	Ndef(\arp2).map(\w0,0.3*2);
	Ndef(\arp).map(\w0,0.4*2);
	Ndef(\arp).set(\detune, 0);

	32.wait;

	"up6".postln;

	Ndef(\arp2).set(\detune, 1);
	Ndef(\arp).map(\rel,Ndef(\lfo0,{SinOsc.ar(5, 0, 1, 0.2)}).asMap);
	Ndef(\arp).map(\f0,8);
	Ndef(\arp2).map(\f0,8);

	32.wait;

	"up7".postln;

	Ndef(\arp2).map(\w0,0.3*2);
	Ndef(\arp).map(\w0,0.4*2);
	Ndef(\arp).map(\detune,Ndef(\line,{Line.kr(0,1,100)}) );

	32.wait;

	"break".postln;
	Ndef(\arp).set(\amp,0);
	Ndef(\arp2).set(\amp,0);
	Ndef(\arp3).set(\amp,0);

	"up8".postln;

	Ndef(\arp).set(\amp,0.5);
	Ndef(\arp2).set(\amp,0.5);
	Ndef(\arp3).set(\amp,0.5);
	Ndef(\arp2).map(\w0,0.85);
	Ndef(\arp).map(\w0,0.95);
	Ndef(\arp).map(\detune,Ndef(\sin,{SinOsc.kr(0.1,0,0.02,0.02)}));
	Ndef(\arp).map(\phasing,0);

	32.wait;

	"up9".postln;
	Ndef(\arp).map(\phasing,0.25);

	32.wait;

	"up10".postln;
	Ndef(\arp3).map(\rel,Ndef(\lfo2,{SinOsc.ar(2.5, 0, 1, 0)}).asMap);
	Ndef(\arp3).map(\phasing,0.5);
	Ndef(\arp3).map(\f0,8,\amp,1,\detune,4);
	Ndef(\arp3).map(\f0,8,\amp,1,\detune,0);

	32.wait;

	"up11".postln;
	Ndef(\arp).map(\phasing,0.5);
	Ndef(\arp3).map(\phasing,0.75);

	32.wait;

	"up12".postln;
	Ndef(\arp).map(\phasing,1.25);
	Ndef(\arp).map(\f0,8);
	Ndef(\arp2).map(\f0,8);
	Ndef(\arp3).map(\f0,8);

	32.wait;

	"up13".postln;
	Ndef(\arp).map(\phasing,6);
	Ndef(\arp3).map(\phasing,1.5);
	Ndef(\arp2).map(\phasing,8);

	32.wait;


	"end".postln;
	Ndef.clear;
	1.wait;

}).play.quant(4);
)