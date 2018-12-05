//--tweet0084 SOFTLY BLOWING THE ROOF
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



