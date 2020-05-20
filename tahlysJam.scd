(
Buffer.freeAll;
~linnDir = "/home/julien/Dropbox/sounds/LinnDrum LM-2/Normalized";
~bufs = Array.newClear;

~bufs = ~bufs.add(Buffer.read(s, ~linnDir+/+"HatClosed1.aif"));
~bufs = ~bufs.add(Buffer.read(s, ~linnDir+/+"Kick.aif"));
~bufs.size

  Buffer.read(s, ~samplesDir +/+ "blipGlitch_comic_book.wav");
// See num frames:
~tac.numFrames;
)


(
SynthDef(\sampler, {
	|out=0, bufNum=0, amp=0.3, rate=1|
	var sig;
	sig = PlayBuf.ar(2, bufNum, rate * BufRateScale.kr(bufNum), doneAction:2);
	Out.ar(out, sig*amp);
}).add;
)


