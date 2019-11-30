Ndef(\pulse,{

	|f1=8, f2=3, chaos=1.4, amp=0.0, fxBus=0, fxSend=0|
	var sig1, ampMap, chaosMap;
	chaos = chaos.clip(0.1, 1.9);
	sig1 = tanh(Impulse.kr(f1).lag*Crackle.ar(LFSaw.kr(f2).abs.lag*chaos))*10;
	sig1 = HPF.ar((sig1!2),1000);
	sig1;

});

Ndef(\pulse).play(2, 1);
Ndef(\pulse).set(\f2, 7, \chaos, 1.4)
Ndef(\pulse).set(\f2, 3, \chaos, 1.4)
Ndef(\pulse).set(\f2, 7, \chaos, 2)
Ndef(\pulse).set(\f2, 7, \chaos, 0.1)

Ndef(\pulse).stop;






