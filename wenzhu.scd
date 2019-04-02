


///TEST KICK SYNC NDEF BASS , Latecy ,

// GITCraken
(
Ndef(\arp).clear;
Ndef(\arp3).clear;
Ndef(\arp2).clear;


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


SynthDef(\default,{arg freq;
	var env= EnvGen.ar(Env.perc(0.01,3),doneAction:2);
	var freq2 = (freq/440*432);
	var sig = Mix.ar(SinOsc.ar([freq/2,freq,freq*2]));
	sig = CombC.ar(sig,0.2,0.1,1);
	sig = FreeVerb.ar(sig,1,1);
	Out.ar([0,1],sig*env*0.1);
}).add;

)

(
Tdef(\test,{loop{

	"1".postln;

	Ndef(\arp).play;
Ndef(\arp).map(\f0,8);
Ndef(\arp).map(\rel,Ndef(\lfo0,{SinOsc.ar(9/3, 0, 1, 0.1)}).asMap);
Ndef(\arp).set(\freq,53);


	12.wait;

	"2".postln;

Ndef(\arp).map(\rel,Ndef(\lfo0,{SinOsc.ar(8/3, 0, 1, 0.1)}).asMap);
Ndef(\arp).set(\freq,55);

	12.wait;

}}).play;


Tdef(\bass,{loop{
		"3".postln;

Ndef(\arp2).map(\f0,8);
Ndef(\arp2).play;
Ndef(\arp2).map(\rel,Ndef(\lfo1,{SinOsc.ar(9/3, 0, 1, 0.1)}).asMap);
Ndef(\arp2).set(\freq,53);

	12.wait;

		"4".postln;

Ndef(\arp2).map(\rel,Ndef(\lfo1,{SinOsc.ar(8/3, 0, 1, 0.1)}).asMap);
Ndef(\arp2).set(\freq,55);
	12.wait;
}}).play;

)

s.meter;

///////// PARTIE 1

			MIDIIn.connectAll;
(

Tdef(\test2,{

	Tdef(\test).play;
	96.wait;
	Tdef(\bass).play;
	48.wait;

	"5".postln;
	Ndef(\beat,
		{
			var trig, sig, freq;
			trig = TDuty.ar(
				Dseq([1/8], inf),  //demand ugen as durations
				0,
				Dseq((10..3)/15, inf)  //demand ugen as amplitude
			);
			freq = Demand.ar(trig, 0, Dseq([7000], inf));
			sig = Ringz.ar(trig, freq, 0.1);
			Out.ar(0, 0.25*sig!2);
	};);
	48.wait;



///////// PARTIE 2



	"6".postln;
	Ndef(\arp).play;

	Tdef(\test).stop;
	Tdef(\bass).stop;


	Ndef(\arp).play;
	Ndef(\arp).map(\f0,8);

	Ndef(\arp).map(\rel,Ndef(\lfo0,{SinOsc.ar(8/3, 0, 1, 0.1)}).asMap);
	Ndef(\arp).set(\freq,53);

	Ndef(\arp2).play;
	Ndef(\arp2).map(\rel,Ndef(\lfo1,{SinOsc.ar(8/6, 0, 1, 0.1)}).asMap);
	Ndef(\arp2).set(\freq,53);


	24.wait;

	"7".postln;

Ndef(\arp2).play;

Ndef(\arp2, {|out=0, freq=9888, detune=0.3, f0=16, f1=2.7, w0=0.9, phasing=0, legato=0.5, amp=0.5,rel=0.1|
	var sig, env, env2, trig, sig2;
	trig = Pulse.ar(f0, w0);
	env = EnvGen.ar(Env.adsr(releaseTime:rel), trig).lag(0.01);
	env2 = DelayC.ar(env, 1, phasing);

	// experiment replacing oscillators (LFPulse, LFCub, LFTri, LFSaw, etc)
	sig = LFPulse.ar([freq, freq], mul:0.5);
		sig = BRF.ar(sig,1066)+HPF.ar(sig,[5000,4000]);
	sig2 = LFPulse.ar([freq, freq] + detune.linlin(0, 1, 0, 3), mul:0.1);
		Out.ar(out, Splay.ar([sig * env, sig2 * env2]*amp*Line.kr(0,1,12)));
});

	24.wait;


	"8".postln;
/////////////////////////Debut mélodie
	Ndef(\arp).play;
	Ndef(\arp).map(\f0,8);

	Ndef(\arp).map(\rel,Ndef(\lfo0,{SinOsc.ar(8/3, 0, 1, 0.1)}).asMap);
	Ndef(\arp).set(\freq,53);

		Ndef(\arp, {|out=0, freq=55, detune=0.3, f0=16, f1=2.7, w0=0.9 phasing=0, legato=0.5, amp=0.5,rel=0.1,lpf=1000|
	var sig, env, env2, trig, sig2;
	trig = Pulse.ar(f0, w0);
	env = EnvGen.ar(Env.adsr(releaseTime:rel),trig).lag(0.01);
	env2 = DelayC.ar(env, 1, phasing);

	// experiment replacing oscillators (LFPulse, LFCub, LFTri, LFSaw, etc)
	sig =LPF.ar( LFCub.ar([freq/6, freq/2,freq*4,freq*8]*4, mul:0.5)+LFSaw.ar([freq, freq*2.5,freq*4.5,freq*8]+0.01, mul:0.5),lpf+SinOsc.ar(1/16,0,10000,10000));
	sig2 = Mix.ar(LFCub.ar([freq/6, freq/2,freq*4,freq*8]*4 + detune.linlin(0, 1, 0, 100), mul:0.1));
	Out.ar(out, Splay.ar([sig * env*0.5, sig2 * env2]*amp*Line.kr(0,1,12)));
});

	Pdef(\note,Pbind(\instrument,\default,\lag,1,\freq,Pseq([440,424,440,328],inf))).play;
	12.wait;

	"9".postln;

Pdef(\note2,Pbind(\instrument,\default,\dur,3,\lag,0.5,\freq,Pseq([440,424,440,330]*2,inf))).play;
	12.wait;

	"10".postln;

Pdef(\note3,Pbind(\instrument,\default,\dur,2,\freq,Pseq([440,424,440,328]/2,inf))).play;
	12.wait;

	"11".postln;
Pdef(\note4,Pbind(\instrument,\default,\dur,4,\freq,Pseq([71,75,77,79,80,83,86,89],inf).midicps)).play;
Ndef(\whitenoise,{
	WhiteNoise.ar(1!2)*In.ar(0,2)*0.1
}).play;

	94.wait;

	Ndef(\bass).fadeTime=2;
	Ndef(\bass,{
		SinOsc.ar([112,112.5]/1.5)*0.4
	}).play;

	2.wait;

		"break".postln;

	Ndef(\whitenoise).free;
	Ndef(\beat).free;
	Ndef(\arp).free;
	Ndef(\arp2).stop;
	Ndef(\arp3).stop;


	24.wait;

	Ndef(\sin).fadeTime=10;
	Ndef(\sin2).fadeTime=10;
	Ndef(\sin3).fadeTime=10;

	Ndef(\sin,{
		SinOsc.ar([112,112.5])*SinOsc.kr(1/16)*0.1
	}).play;
	Ndef(\sin2,{
		SinOsc.ar([112,112.5]*1.5)*SinOsc.kr(0.1)*0.1
	}).play;
	Ndef(\sin3,{
		SinOsc.ar([112,112.5]*3)*SinOsc.kr(0.11)*0.01
	}).play;


	24.wait;


	Ndef(\arp).play;

	48.wait;


	Ndef(\bass).fadeTime=0.01;
			i=0;
			MIDIdef.noteOn(\kick,{
				arg ...args;
				case
				{i ==0}{
					Ndef(\bass).play;
					"on".postln;
							Ndef(\arp2,).play;
					i=1;
				}
				{i ==1}{
					"off".postln;
							Ndef(\bass).free;
							//Ndef(\arp2,).free;
					i=0;
				}

			});



	24.wait;

	"Partie2".postln;

				Ndef(\arp2).clear;
Ndef(\arp2, {|out=0, freq=55, detune=0.3, f0=16, f1=2.7, w0=0.9 phasing=0, legato=0.5, amp=0.5,rel=0.1,lpf=1000|
	var sig, env, env2, trig, sig2;
	trig = Pulse.ar(f0, w0);
	env = EnvGen.ar(Env.adsr(releaseTime:rel),trig).lag(0.01);
	env2 = DelayC.ar(env, 1, phasing);
	// experiment replacing oscillators (LFPulse, LFCub, LFTri, LFSaw, etc)
	sig =LPF.ar( LFCub.ar([freq/6, freq/2,freq,freq*2], mul:0.5)+LFSaw.ar([freq/6, freq/2,freq,freq*2]+0.01, mul:0.5),lpf+SinOsc.ar(1/32,0,10000,10000));
	sig2 = Mix.ar(LFCub.ar([freq/6, freq/2,freq*4,freq] + detune.linlin(0, 1, 0, 100), mul:0.1));
	Out.ar(out, Splay.ar([sig * env*0.5, sig2 * env2]*amp));
});
	Ndef(\arp2).map(\w0,0.9);
	Ndef(\arp2).map(\f0,8);
Ndef(\arp2).play;

		24.wait;

	MIDIdef.noteOn(\kick).free;

			"1".postln;

	Ndef(\sin4,{
		SinOsc.ar([112,112.5]*4)*SinOsc.kr(0.11)*0.01
	}).play;

	Ndef(\bass,{
				(SinOsc.ar([112,112.5]/1.5)*0.4)+(BRF.ar(LFSaw.ar([112+0.05,112.5+0.05]/1.5,0,0.05),700,4)+BRF.ar(LFSaw.ar([112,112.5]/1.5,0,0.05),800,4))*SinOsc.ar(1/16)
	}).play;



	24.wait;

			"2".postln;



Pdef(\note,Pbind(\instrument,\default, \dur,4,\lag,1,\freq,Pseq([440,424,440,328],inf))).play;
Pdef(\note2,Pbind(\instrument,\default,\dur,4,\lag,0.5,\freq,Pseq([440,424,440,330]*2,inf))).play;
Pdef(\note3,Pbind(\instrument,\default,\dur,4,\freq,Pseq([440,424,440,328]/2,inf))).play;
Pdef(\note4,Pbind(\instrument,\default,\dur,4,\freq,Pseq([71,75,77,79,80,83,86,89],inf).midicps)).play;


48.wait;
	"note5".postln;
Pdef(\note5,Pbind(\instrument,\default,\dur,4,\lag,0,\freq,Pseq([71,75,77,79]-7,inf).midicps)).play;
			"3".postln;


12.wait;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

		"break".postln;
			Ndef(\arp2).free;
			Ndef(\arp).free;
			Ndef(\bass).free;
			Ndef(\sin4).free;

12.wait;
		Ndef(\sin).fadeTime=0;
		Ndef(\sin2).fadeTime=0;
		Ndef(\sin3).fadeTime=0;

		Ndef(\sin).free;
		Ndef(\sin2).free;
		Ndef(\sin3).free;

12.wait;

Ndef(\pulse,{
	// hack from "https://sccode.org/1-Z"
	// removing layers
	|f1=8, f2=16, chaos=1, amp=0.0, fxBus=0, fxSend=0|
	var sig1, ampMap, chaosMap;
	sig1 = tanh(Impulse.kr(f1).lag*Crackle.ar(LFSaw.kr(f2).abs.lag*chaos))*10;
		sig1 = HPF.ar((sig1!2),1000);
	sig1;
//	Out.ar(out, sig1 * amp);
//	Out.ar(fxBus, sig1 * fxSend);
}).play;

12.wait;

						"partie3".postln;

Ndef(\arp, {|out=0, freq=55, detune=0.3, f0=16, f1=2.7, w0=0.9 phasing=0, legato=0.5, amp=0.5,rel=0.1,lpf=1000|
	var sig, env, env2, trig, sig2;
	trig = LFPulse.ar(f0, w0);
	env = EnvGen.ar(Env.adsr(releaseTime:rel),trig).lag(0.01);
	env2 = DelayC.ar(env, 1, phasing);

	// experiment replacing oscillators (LFPulse, LFCub, LFTri, LFSaw, etc)
	sig =HPF.ar( LFSaw.ar([freq/6, freq/2,freq*4,freq*8,freq], mul:0.5)+LFTri.ar([freq, freq*2.5,freq*4.5,freq*8]+0.1, mul:0.5),lpf+SinOsc.ar(1/16,0,10000,10000));
	sig2 = Mix.ar(LFSaw.ar([freq/6, freq/2,freq*4,freq*8,freq]*4 + detune.linlin(0, 1, 0, 100), mul:0.1));
		Out.ar(out, FreeVerb.ar(Splay.ar([sig * env*0.5, sig2 * env2]*amp),0.5,0.5)*0.5);
});

	Ndef(\arp2).map(\w0,1.8);
	Ndef(\arp2).map(\f0,8);
	Ndef(\arp).map(\w0,4);
	Ndef(\arp).map(\f0,8);
	Ndef(\arp).play;

24.wait;

									"1".postln;


	Ndef(\arp2).play;

24.wait;

												"2".postln;

	Ndef(\bass,{
				(SinOsc.ar([112,112.5]/1.5)*0.4)+(BRF.ar(LFSaw.ar([112+0.05,112.5+0.05]/1.5,0,0.05),700,4)+BRF.ar(LFSaw.ar([112,112.5]/1.5,0,0.1),800,4))*SinOsc.ar(1/8)
	}).play;

			z=[0,0,0,1];
			i=0;
			x=0;
			MIDIdef.noteOn(\kick,{
				arg ...args;
				x=x+1;
				i= z[x%4];
				case
				{i ==0}{
					Ndef(\bass).play;
					"on".postln;
					i=1;
				}
				{i ==1}{
					"off".postln;
					Ndef(\bass).free;
							//Ndef(\arp2,).free;
					i=0;
				}

			});

24.wait;

												"3".postln;

	Ndef(\arp3).play;

		Ndef(\bass,{
				(SinOsc.ar([112,112.5]/1.5)*0.4)+(BRF.ar(LFSaw.ar([112+0.05,112.5+0.05]/1.5,0,0.05),700,4)+BRF.ar(LFSaw.ar([112,112.5]/1.5,0,0.1),800,4))*SinOsc.ar(1/16)
	}).play;

	24.wait;
												"4".postln;

			Ndef(\bass,{
				(SinOsc.ar([112,112.5]/1.5)*0.4)+(BRF.ar(LFSaw.ar([112+0.05,112.5+0.05]/1.5,0,0.05),700,4)+BRF.ar(LFSaw.ar([112,112.5]/1.5,0,0.1),800,4))*SinOsc.ar(8)
	}).play;
	24.wait;
												"5".postln;


			Ndef(\bass,{
				(SinOsc.ar([112,112.5]/1.5)*0.4)+(BRF.ar(LFSaw.ar([112+0.05,112.5+0.05]/1.5,0,0.05),700,4)+BRF.ar(LFSaw.ar([112,112.5]/1.5,0,0.1),800,4))*SinOsc.ar(4)
	}).play;
24.wait;

	Ndef(\bass).free;
	Ndef.clear;

24.wait;

Pdef.clear;

					                      	"partie3".postln;
											"break".postln;
~asmr = Buffer.read(s,"/home/unknown/Downloads/japaneseASMR_mono.wav");
SynthDef(\help_PlayBuf, {| out = 0, bufnum = 0 |
	    Out.ar([0,1],
        PlayBuf.ar(2, bufnum, BufRateScale.kr(bufnum), doneAction: Done.freeSelf)*0.5
    )
}).play(s, [\out, [0,1], \bufnum, ~asmr.bufnum]);


48.wait;

		                      	"partie4".postln;
									"1".postln;

	Ndef(\sin).fadeTime=16;

	Ndef(\sin2).fadeTime=16;

	Ndef(\sin3).fadeTime=16;

	Ndef(\sin,{
		SinOsc.ar([112,112.5])*SinOsc.kr(1/32)*0.1
	}).play;
	Ndef(\sin2,{
		SinOsc.ar([112,112.5]*2)*SinOsc.kr(0.1)*0.1
	}).play;
	Ndef(\sin3,{
		SinOsc.ar([112,112.5]*3.5)*SinOsc.kr(0.11)*0.01
	}).play;



	24.wait;

									"2".postln;

		Ndef(\arp, {|out=0, freq=55, detune=0.3, f0=16, f1=2.7, w0=0.9 phasing=0, legato=0.5, amp=0.5,rel=0.1,lpf=1000|
	var sig, env, env2, trig, sig2;
	trig = Pulse.ar(f0, w0);
	env = EnvGen.ar(Env.adsr(releaseTime:rel),trig).lag(0.01);
	env2 = DelayC.ar(env, 1, phasing);

	// experiment replacing oscillators (LFPulse, LFCub, LFTri, LFSaw, etc)
	sig =LPF.ar( LFPar.ar([freq/6, freq/2,freq/4,freq/8], mul:0.5)+LFPar.ar([freq, freq/2,freq/4,freq/8]+0.01, mul:0.5),lpf+SinOsc.ar(1/16,0,10000,10000));
	sig2 = Mix.ar(LFSaw.ar([freq/6, freq/2,freq/4,freq/8] + detune.linlin(0, 1, 0, 100), mul:0.1));
	Out.ar(out, Splay.ar([sig * env*0.5, sig2 * env2]*amp*Line.kr(0,1,12)));
});
	Ndef(\arp).play;

	24.wait;
									"3".postln;


	Ndef(\bass,{
		(SinOsc.ar([112,112.5]/1.5)*0.4)+(BRF.ar(LFSaw.ar([112+0.05,112.5+0.05]/1.5,0,0.05),700,4)+BRF.ar(LFSaw.ar([112,112.5]/1.5,0,0.1),800,4))*SinOsc.ar(1/16)+SinOsc.ar([13005,13000.5],0,0.1) ;
	}).play;

	48.wait;

									"4".postln;

	Ndef(\whitenoise,{
		WhiteNoise.ar(1!2)*In.ar(0,2)*Line.kr(0,0.5,100)*0.5
}).play;

	24.wait;
			   "kickin".postln;
			z=[0,0,0,1];
			i=0;
			x=0;
			MIDIdef.noteOn(\kick,{
				arg ...args;
				x=x+1;
				i= z[x%4];
				case
				{i ==0}{
						Ndef(\whitenoise).free;
					Ndef(\bass).play;
					"on".postln;
					i=1;
				}
				{i ==1}{
					"off".postln;
					Ndef(\bass).free;
			Ndef(\whitenoise).play;
							//Ndef(\arp2,).free;
					i=0;
				}
			});

	24.wait;


									"5".postln;



Ndef(\cross,{arg amp=0.5,smooth=0.3,mul=1,freq=0.2;
		var sig = In.ar(0,2);
	sig = CrossoverDistortion.ar(sig,amp,SinOsc.ar([freq,freq+0.5],0,0.1,smooth),mul);
	//sig = FreeVerb.ar(sig,0.5,0.5);
	sig = sig + CombC.ar(sig,0.1,1/8,0.1);
	sig = sig ;
	//sig = SineShaper.ar(sig, 1,0.5);
//	sig = BRF.ar(sig,432,15,-10);
		sig = HPF.ar(sig,4320/2)*Line.kr(0,1,4);
//	sig = Limiter.ar(sig,0.5);
	sig = LeakDC.ar(sig);
//	sig = Compander.ar(sig,In.ar(4,2),0.1,1,0.25,0.1,0.01);
	sig = [DelayL.ar(sig*(-1),0.1,SinOsc.kr(-0.1,0,0.05,0.1)),DelayL.ar(sig*(-1),0.1,SinOsc.kr(0.1,0,0.05,0.1))]*0.1;
		sig;
}).playN(0);

24.wait;

									"6".postln;


	Ndef(\whitenoise).free;
		Ndef(\whitenoise,{
		HPF.ar(WhiteNoise.ar(1!2)*In.ar(0,2)*Line.kr(0,1,1)*0.5,10000)
}).play;


	24.wait;
									"7".postln;


	Ndef(\lownoise,{
		LPF.ar(WhiteNoise.ar(1!2)*In.ar(0,2)*Line.kr(0,1,1)*0.5,500)
	}).play;

	24.wait;

									"8".postln;


	Ndef(\lownoise,{
		BRF.ar(WhiteNoise.ar(1!2)*In.ar(0,2)*Line.kr(0,1,1)*0.5,1000);
	}).play;



	Ndef(\lownoise,{ LatoocarfianL.ar(
			    SampleRate.ir/[4,4],
		    LFNoise2.kr(2,1.5,1.5),
		    LFNoise2.kr(2,1.5,1.5),
		    LFNoise2.kr(2,0.5,1.5),
		    LFNoise2.kr(2,0.5,1.5)
		) * 0.05*In.ar(0,2) }).play;

	24.wait;

									"9".postln;


	Ndef(\lownoise,{ LatoocarfianL.ar(
			    SampleRate.ir/[2,2],
		    LFNoise2.kr(0.2,1.5,1.5),
		    LFNoise2.kr(0.2,1.5,1.5),
		    LFNoise2.kr(0.2,0.5,1.5),
		    LFNoise2.kr(0.2,0.5,1.5)
		) * 0.05*In.ar(0,2) }).play;

	Ndef(\sin).fadeTime=0.01;
	Ndef(\sin2).fadeTime=0.01;
	Ndef(\sin3).fadeTime=0.01;
	Ndef(\sin).free;
	Ndef(\sin2).free;
	Ndef(\sin3).free;

    24.wait;
									"10".postln;


	Ndef(\whitenoise).free;
		Ndef(\whitenoise,{
		HPF.ar(WhiteNoise.ar(1!2)*In.ar(0,2)*Line.kr(0,1,1)*0.5,15000)
}).play;

		12.wait;

									"11".postln;

	Ndef(\lownoise,{
		LPF.ar(WhiteNoise.ar(1!2)*In.ar(0,2)*Line.kr(0,1,1)*0.5,100)
	}).play;
		12.wait;

									"12".postln;

Ndef(\cross,{arg amp=0.5,smooth=0.3,mul=1,freq=0.2;
		var sig = In.ar(0,2);
	sig = CrossoverDistortion.ar(sig,amp,SinOsc.ar([freq,freq+0.5],0,0.1,smooth),mul);
	//sig = FreeVerb.ar(sig,0.5,0.5);
	sig = sig + CombC.ar(sig,0.1,1/8,0.1);
	sig = sig ;
	//sig = SineShaper.ar(sig, 1,0.5);
//	sig = BRF.ar(sig,432,15,-10);
		sig = HPF.ar(sig,432)*Line.kr(0,1,4);
//	sig = Limiter.ar(sig,0.5);
	sig = LeakDC.ar(sig);
//	sig = Compander.ar(sig,In.ar(4,2),0.1,1,0.25,0.1,0.01);
	sig = [DelayL.ar(sig*(-1),0.1,SinOsc.kr(-0.1,0,0.05,0.1)),DelayL.ar(sig*(-1),0.1,SinOsc.kr(0.1,0,0.05,0.1))]*0.1;
		sig;
}).playN(0);

	Ndef(\bass,{
				(SinOsc.ar([112,112.5]/1.5)*0.4)+(BRF.ar(LFSaw.ar([112+0.05,112.5+0.05]/2,0,0.05),700,4)+BRF.ar(LFSaw.ar([112,112.5]/1.5,0,0.1),800,4))*SinOsc.ar(1/16)+(SinOsc.ar(11008,0,0.01) );
	}).play;


12.wait;
									"13".postln;


Ndef(\arp3, {|out=0, freq=55, detune=0.3, f0=8, f1=2.7, w0=0.95, phasing=0, legato=0.5, amp=0.5,rel=0.1,lpf=1000|
	var sig, env, env2, trig, sig2;
	trig = Pulse.ar(f0, w0);
	env = EnvGen.ar(Env.adsr(releaseTime:rel),trig).lag(0.01);
	env2 = DelayC.ar(env, 1, phasing);
	// experiment replacing oscillators (LFPulse, LFCub, LFTri, LFSaw, etc)
				sig = LPF.ar(LFSaw.ar([freq*2, freq*2.05]*Duty.kr(2,0,Dseq([8,8,8,12]/2,inf)), mul:0.5)+LFSaw.ar([freq*2, freq*2.05]*Duty.kr(1,0,Dseq([8,8,8,12],inf))+0.01, mul:0.5),lpf);
	sig2 = LFPulse.ar([freq, freq*2]*8 + detune.linlin(0, 1, 0, 100), mul:0.1);
	Out.ar(out, Splay.ar([sig * env*0.5, sig2 * env2]*amp*1));
}).play;

	12.wait;

											"14".postln;


	Ndef(\arp2, {|out=0, freq=55, detune=0.3, f0=8, f1=2.7, w0=0.95, phasing=0, legato=0.5, amp=0.5,rel=0.1,lpf=1000|
	var sig, env, env2, trig, sig2;
	trig = Pulse.ar(f0, w0);
	env = EnvGen.ar(Env.adsr(releaseTime:rel),trig).lag(0.01);
	env2 = DelayC.ar(env, 1, phasing);
	// experiment replacing oscillators (LFPulse, LFCub, LFTri, LFSaw, etc)
				sig = LPF.ar(LFSaw.ar([freq*2, freq*2.05]*Duty.kr(2,0,Dseq([8,8,8,12],inf)), mul:0.5)+LFSaw.ar([freq*2, freq*2.05]*Duty.kr(1,0,Dseq([8,8,8,12]/4,inf))+0.01, mul:0.5),lpf);
	sig2 = LFPulse.ar([freq, freq*2]*8 + detune.linlin(0, 1, 0, 100), mul:0.1);
	Out.ar(out, Splay.ar([sig * env*0.5, sig2 * env2]*amp*1));
}).play;

	12.wait;

											"15".postln;

	Ndef(\arp, {|out=0, freq=55, detune=0.3, f0=8, f1=2.7, w0=0.95, phasing=0, legato=0.5, amp=0.5,rel=0.1,lpf=1000|
	var sig, env, env2, trig, sig2;
	trig = Pulse.ar(f0, w0);
	env = EnvGen.ar(Env.adsr(releaseTime:rel),trig).lag(0.01);
	env2 = DelayC.ar(env, 1, phasing);
	// experiment replacing oscillators (LFPulse, LFCub, LFTri, LFSaw, etc)
				sig = LPF.ar(LFSaw.ar([freq*2, freq*2.05]*Duty.kr(2,0,Dseq([8,8,8,12]/5,inf)), mul:0.5)+LFSaw.ar([freq*2, freq*2.05]*Duty.kr(1,0,Dseq([8,8,8,12]/6,inf))+0.01, mul:0.5),lpf);
	sig2 = LFPulse.ar([freq, freq*2]*8 + detune.linlin(0, 1, 0, 100), mul:0.1);
	Out.ar(out, Splay.ar([sig * env*0.5, sig2 * env2]*amp*1));
}).play;


	12.wait;
											"16".postln;

			Ndef(\cross).free;
			Ndef(\lownoise).free;
			Ndef(\whitenoise).free;


	12.wait;

											"17".postln;
					Ndef(\whitenoise,{
		HPF.ar(WhiteNoise.ar(1!2)*In.ar(0,2)*Line.kr(0,1,1)*0.2,500)
}).play;
			12.wait;
											"18".postln;


			"kickin".postln;
			z=[0,0,1,1];
			i=0;
			x=0;
			MIDIdef.noteOn(\kick,{
				arg ...args;
				x=x+1;
				i= z[x%4];
				case
				{i ==0}{
					Ndef(\whitenoise).free;
					Ndef(\bass).play;
					Ndef(\fm).free;

					"on".postln;
					i=1;
				}
				{i ==1}{
					"off".postln;
					Ndef(\bass).free;
					Ndef(\whitenoise).play;
					Ndef(\fm).play;
					//Ndef(\arp2,).free;
					i=0;
				}
			});

			24.wait;

														"19".postln;

		Ndef(\whitenoise,{
		HPF.ar(WhiteNoise.ar(1!2)*In.ar(0,2)*Line.kr(0,1,1),200)
}).play;
			12.wait;
														"20".postln;

	Ndef(\arp4, {|out=0, freq=55, detune=0.3, f0=8, f1=2.7, w0=0.95, phasing=0, legato=0.5, amp=0.5,rel=0.1,lpf=1000|
	var sig, env, env2, trig, sig2;
	trig = Pulse.ar(f0, w0);
	env = EnvGen.ar(Env.adsr(releaseTime:rel),trig).lag(0.01);
	env2 = DelayC.ar(env, 1, phasing);
	// experiment replacing oscillators (LFPulse, LFCub, LFTri, LFSaw, etc)
				sig = LPF.ar(LFSaw.ar([freq*2, freq*2.05]*Duty.kr(1,0,Dseq([10,10,10,12]*2,inf)), mul:0.5)+LFSaw.ar([freq*2, freq*2.05]*Duty.kr(1,0,Dseq([8,8,8,12]*2,inf))+0.01, mul:0.5),lpf);
	sig2 = LFPulse.ar([freq, freq*2]*8 + detune.linlin(0, 1, 0, 100), mul:0.1);
	Out.ar(out, Splay.ar([sig * env*0.5, sig2 * env2]*amp*1));
}).play;
	Ndef(\arp4).play;


			12.wait;

													    "21".postln;

				Ndef(\arp5, {|out=0, freq=55, detune=0.3, f0=8, f1=2.7, w0=0.95, phasing=0, legato=0.5, amp=0.5,rel=0.1,lpf=1000|
	var sig, env, env2, trig, sig2;
	trig = Pulse.ar(f0, w0);
	env = EnvGen.ar(Env.adsr(releaseTime:rel),trig).lag(0.01);
	env2 = DelayC.ar(env, 1, phasing);
	// experiment replacing oscillators (LFPulse, LFCub, LFTri, LFSaw, etc)
				sig = LPF.ar(LFSaw.ar([freq*2, freq*2.05]*Duty.kr(1,0,Dseq([2,2,2,1]*2,inf)), mul:0.5)+LFSaw.ar([freq*2, freq*2.05]*Duty.kr(1,0,Dseq([4,4,4,2],inf))+0.01, mul:0.5),lpf);
	sig2 = LFPulse.ar([freq, freq*2] + detune.linlin(0, 1, 0, 100), mul:0.1);
	Out.ar(out, Splay.ar([sig * env*0.5, sig2 * env2]*amp*1));
}).play;

			12.wait;

														"22".postln;

Pdef(\note2,Pbind(\instrument,\default,\dur,4,\lag,0.5,\freq,Pseq([440,424,440,848],inf))).play;
Pdef(\note3,Pbind(\instrument,\default,\dur,4,\freq,Pseq([440,424,440,328]/2,inf))).play;
Pdef(\note4,Pbind(\instrument,\default,\dur,4,\freq,Pseq([71,75,77,79,80,83,86,89],inf).midicps)).play;

			24.wait;


				Ndef(\arp5, {|out=0, freq=55, detune=0.3, f0=8, f1=2.7, w0=0.95, phasing=0, legato=0.5, amp=0.5,rel=0.1,lpf=1000|
	var sig, env, env2, trig, sig2;
	trig = Pulse.ar(f0, w0);
	env = EnvGen.ar(Env.adsr(releaseTime:rel),trig).lag(0.01);
	env2 = DelayC.ar(env, 1, phasing);
	// experiment replacing oscillators (LFPulse, LFCub, LFTri, LFSaw, etc)
				sig = LPF.ar(LFSaw.ar([freq*2, freq*2.05]*Duty.kr(4,0,Dseq([2,2,2,1]*2,inf)), mul:0.5)+LFSaw.ar([freq*2, freq*2.05]*Duty.kr(4,0,Dseq([4,4,4,2],inf))+0.01, mul:0.5),lpf);
	sig2 = LFPulse.ar([freq, freq*2] + detune.linlin(0, 1, 0, 100), mul:0.1);
	Out.ar(out, Splay.ar([sig * env*0.5, sig2 * env2]*amp*1));
}).play;

			24.wait;


			"fin".postln;
			1.wait;
}).play;
)




Ndef(\arp5).free;

Ndef(\arp4).free;

Ndef(\arp3).free;

Ndef(\arp2).free;

Ndef(\arp).free;

Pdef.clear;

/*


Pdef.clear;




	s.meter;


	Ndef(\arp).fadeTime=0.1;

	Ndef(\arp).free;


Tdef(\phase,{loop{


	Ndef(\arp).stop;
Ndef(\arp).map(\f0,1);
Ndef(\arp).map(\rel,Ndef(\lfo0,{SinOsc.ar(9/3, 0, 1, 0.1)}).asMap);
	Ndef(\arp).set(\freq,26);
	rrand(4,7).wait;



Ndef(\arp).map(\f0,8);
Ndef(\arp).map(\rel,1);
	1.wait;
}}).play;

	44.wait;

	Pdef(\note,Pbind(\instrument,\default,\dur,1/4, \lag,1,\freq,Pseq([440,424,440,328],inf))).play;

	Ndef(\arp2).stop;


	Ndef(\arp).stop;
	Tdef(\phase).stop;
	Ndef(\pulse).stop;
		Pdef.clear;

	4.wait;

	Ndef(\arp2).play;
Ndef(\arp).play;
Ndef(\arp2, {|out=0, freq=9888, detune=0.3, f0=8, f1=2.7, w0=0.9, phasing=0, legato=0.5, amp=0.5,rel=0.1|
	var sig, env, env2, trig, sig2;
	trig = Pulse.ar(f0, w0);
	env = EnvGen.ar(Env.adsr(releaseTime:rel), trig).lag(0.01);
	env2 = DelayC.ar(env, 1, phasing);

	// experiment replacing oscillators (LFPulse, LFCub, LFTri, LFSaw, etc)
	sig = LFPulse.ar([freq, freq], mul:0.5);
		sig = BRF.ar(sig,1066)+HPF.ar(sig,[5000,4000]);
	sig2 = LFPulse.ar([freq, freq] + detune.linlin(0, 1, 0, 3), mul:0.1);
	Out.ar(out, Splay.ar([sig * env, sig2 * env2]*amp));
});
	Ndef(\arp).map(\rel,Ndef(\lfo0,{SinOsc.ar(9/3, 0, 1, 0.1)}).asMap);
	Ndef(\arp2).map(\rel,Ndef(\lfo0,{SinOsc.ar(9/3, 0, 1, 0.1)}).asMap);

Ndef(\arp, {|out=0, freq=55, detune=0.3, f0=8, f1=2.7, w0=0.9 phasing=0, legato=0.5, amp=0.5,rel=0.1,lpf=1000|
	var sig, env, env2, trig, sig2;
	trig = Pulse.ar(f0, w0);
	env = EnvGen.ar(Env.adsr(releaseTime:rel),trig).lag(0.01);
	env2 = DelayC.ar(env, 1, phasing);

	// experiment replacing oscillators (LFPulse, LFCub, LFTri, LFSaw, etc)
	sig =LPF.ar( LFSaw.ar([freq/6, freq/2,freq*4,freq*8]*4, mul:0.5)+LFSaw.ar([freq, freq*2.5,freq*4.5,freq*8]+0.01, mul:0.5),lpf+SinOsc.ar(1/16,0,10000,10000));
	sig2 = Mix.ar(LFCub.ar([freq/6, freq/2,freq*4,freq*8]*4 + detune.linlin(0, 1, 0, 100), mul:0.1));
	Out.ar(out, Splay.ar([sig * env*0.5, sig2 * env2]*amp));
});
Pdef(\note,Pbind(\instrument,\default, \lag,1,\freq,Pseq([440,424,440,328],inf))).play;
Pdef(\note2,Pbind(\instrument,\default,\dur,3,\lag,0.5,\freq,Pseq([440,424,440,330]*2,inf))).play;
Pdef(\note3,Pbind(\instrument,\default,\dur,2,\freq,Pseq([440,424,440,328]/2,inf))).play;
Pdef(\note4,Pbind(\instrument,\default,\dur,4,\freq,Pseq([71,75,77,79,80,83,86,89],inf).midicps)).play;
Pdef(\note5,Pbind(\instrument,\default,\dur,2,\freq,Pseq([71,75,78,79]-7,inf).midicps)).play;


	48.wait;

Pdef(\note,Pbind(\instrument,\default,\dur,1, \lag,1,\freq,Pseq([440,424,440,328],inf))).play;
	12.wait;
Pdef(\note2,Pbind(\instrument,\default,\dur,3,\lag,0.5,\freq,Pseq([440,424,440,330]*2,inf))).play;
	12.wait;
Pdef(\note3,Pbind(\instrument,\default,\dur,2,\freq,Pseq([440,424,440,328]/2,inf))).play;
	12.wait;

	Ndef(\sin).fadeTime=10;
Ndef(\sin2).fadeTime=10;
Ndef(\sin3).fadeTime=10;

Ndef(\sin,{
	SinOsc.ar([112,112.5])*SinOsc.kr(1/16)*0.3
}).play;
Ndef(\sin2,{
	SinOsc.ar([112,112.5]*1.5)*SinOsc.kr(0.1)*0.1
}).play;
Ndef(\sin3,{
	SinOsc.ar([112,112.5]*3)*SinOsc.kr(0.11)*0.1
}).play;

	12.wait;
	Ndef(\bass).clear;
Ndef(\bass,{
	LFSaw.ar([112,112.5]/1.5)*0.4
}).play;

	12.wait;


}).play;

)

///GIT LOCAL

(

)

Ndef(\bass,{
	SinOsc.ar([112,112.5]/1.5)*0.4
}).play;






s.meter;

FreqScope.new;

Pdef(\note5).stop;









Ndef(\whitenoise).clear;







Ndef(\arp).edit;

	Ndef(\arp).play;
Ndef(\arp).map(\f0,8);

Ndef(\arp).map(\rel,Ndef(\lfo0,{SinOsc.ar(9/6, 0, 1, 0.1)}).asMap);
Ndef(\arp).set(\freq,53);

Ndef(\arp2).play;
Ndef(\arp2).map(\rel,Ndef(\lfo1,{SinOsc.ar(8/6, 0, 1, 0.1)}).asMap);
Ndef(\arp2).set(\freq,53);


Ndef(\arp3).play;



	Ndef(\arp).play;
Ndef(\arp).map(\f0,8);

Ndef(\arp).map(\rel,Ndef(\lfo0,{SinOsc.ar(8/3, 0, 1, 0.1)}).asMap);
Ndef(\arp).set(\freq,55);

Ndef(\arp2).play;
Ndef(\arp2).map(\rel,Ndef(\lfo1,{SinOsc.ar(8/3, 0, 1, 0.1)}).asMap);
Ndef(\arp2).set(\freq,55);


	Tdef(\test).quant=0;
	Tdef(\test2).quant=0;
	Tdef(\bass).quant=0;


Ndef(\arp2).set(\freq,53);
Ndef(\arp).set(\freq,53);
Ndef(\arp3).play;
Ndef(\arp3).map(\rel,Ndef(\lfo1,{SinOsc.ar(8/3, 0, 1, 0.1)}).asMap);
Ndef(\arp3).set(\freq,53*2);

Ndef(\arp).map(\rel,Ndef(\lfo0,{SinOsc.ar(8/6, 0, 1, 0.1)}).asMap);

Ndef.clear;

8*60

Pdef.clear;


Ndef(\pulse).clear;
Ndef(\pulse,{
	// hack from "https://sccode.org/1-Z"
	// removing layers
	|f1=8, f2=3, chaos=1, amp=0.0, fxBus=0, fxSend=0|
	var sig1, ampMap, chaosMap;
	sig1 = tanh(Impulse.kr(f1).lag*Crackle.ar(LFSaw.kr(f2).abs.lag*chaos))*5;
	sig1 = (sig1!2);
	sig1;
//	Out.ar(out, sig1 * amp);
//	Out.ar(fxBus, sig1 * fxSend);
}).play;


s.meter;


////ADD FILTER


//// ADD DISTO



s.latency=0.001;

s.meter;




