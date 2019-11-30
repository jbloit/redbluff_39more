
// --------------------------------------------- PULSE
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


// ----------------------------------------------- BLIP
Ndef(\blip, { |freq = 30, numHarm = 10|
	Blip.ar(freq, numHarm, 30) * 0.2 }
);

Ndef(\blip).play(2, 1);
Ndef(\blip).set(\freq, 70, \numHarm, 1); // tone
Ndef(\blip).set(\freq, 70, \numHarm, 90); // buzz
Ndef(\blip).set(\freq, 3, \numHarm, 90); // pulses
Ndef(\blip).set(\freq, 10, \numHarm, 90); //pulses
Ndef(\blip).set(\freq, 10, \numHarm, 30); //pulses

Ndef(\blip).stop;


// ------------------------------------------------------------------------ Roof

// Ndef(\roof, {|x=200, y=100|
// 	a=Saw;
// 	x = x.linlin(0, 1, 100, 400);
// 	y = y.linlin(0, 1, 100, 400);
// 	Splay.ar(Formant.ar(a.ar((5,7..15)*19)*99+x, bwfreq:a.ar((3,5..11)*a.ar(3,2,3))*299+y))/3;
// });


Ndef(\roof, {|x=0.3, y=0.4|
	a=Saw;
	x = x.linlin(0, 1, 100, 400);
	y = y.linlin(0, 1, 100, 400);
	Splay.ar(Formant.ar(Saw.kr((5,7..15)*30)*x+y, Saw.kr((1,3..13)*29)*x+y, Saw.kr((3,5..11)*Saw.kr(3,2,3))*x+y, mul:0.1));

});


Ndef(\roof).play(0, 2);
Ndef(\roof).set(\x, 0.1, \y, 0.8);
Ndef(\roof).set(\x, 0.4, \y, 0.2);
Ndef(\roof).stop;

Ndef(\fo2, {Blip.ar(3, 2, 0.5, 0.5)});
Ndef(\roof).map(\x, Ndef(\fo2).play(5, 2));




play{
	a=Saw;
	Splay.ar(Formant.ar(a.ar((5,7..15)*19)*99+199, a.ar((1,3..13)*29)*199+299, a.ar((3,5..11)*a.ar(3,2,3))*299+399))/3}//#SuperCollider




// Y: F0, X: NOISE
{Splay.ar(Formant.ar(Saw.kr((5,7..15)*30)*MouseX.kr(99, 599)+MouseY.kr(100, 300), Saw.kr((1,3..13)*29)*MouseX.kr(99, 599)+MouseY.kr(100, 300), Saw.kr((3,5..11)*Saw.kr(3,2,3))*MouseX.kr(99, 899)+MouseY.kr(100, 300), mul:0.1))}.play;


// X: F0
play{
	a=Saw;
	Splay.ar(Formant.ar(a.ar((5,7..15)*19)*99+MouseX.kr(199, 299), a.ar((1,3..13)*29)*199+MouseX.kr(199, 399), a.ar((3,5..11)*a.ar(3,2,3))*299+MouseX.kr(199, 499)))/3}//#SuperCollider

// X: F0
// brighter
play{
	a=Saw;
	Splay.ar(Formant.ar(a.ar((5,7..15)*19)*99+MouseX.kr(199, 299), formfreq:a.ar((3,5..11)*a.ar(3,2,3))*299+MouseX.kr(199, 499)))/3}//#SuperCollider


// X: F0
// even brighter
play{
	a=Saw;
	Splay.ar(Formant.ar(a.ar((5,7..15)*19)*99+MouseX.kr(199, 299), bwfreq:a.ar((3,5..11)*a.ar(3,2,3))*299+MouseX.kr(199, 499)))/3}//#SuperCollider

// X: roughness?
// More cicada like
play{
	a=Saw;
	Splay.ar(Formant.ar(a.ar((5,7..15)*9)*39+MouseX.kr(99, 299), bwfreq:a.ar((1,3..13)*29)*99+MouseX.kr(99, 299), mul: 0.3))}//#SuperCollider

s.freeAll

// X: roughness?
// More cicada like
play{
	a=Saw;
	Splay.ar(Formant.ar(a.ar((5,7..15)*9)*MouseY.kr(19, 1059)+MouseX.kr(99, 299), bwfreq:a.ar((1,3..13)*29)*MouseY.kr(19, 1059)+MouseX.kr(99, 299), mul: 0.3))}//#SuperCollider

// X: roughness?
// More cicada like
play{
	a=Saw;
	Splay.ar(Formant.ar(a.ar((5,7..15)*MouseX.kr(9, 30))*MouseY.kr(19, 1059)+MouseX.kr(99, 299), bwfreq:a.ar((1,3..13)*MouseY.kr(30, 300))*MouseY.kr(19, 1059)+MouseX.kr(99, 299), mul: 0.3))}//#SuperCollider




s.freeAll

