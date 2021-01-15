// Explicitly set the path, or else all recordings get the same file name, since they are triggered at the same time.
(

~title = "rake-cccc_";
~timeStamp = Date.getDate.stamp;
~clipName = "clip-09_";
~clipsPrefix = thisProcess.platform.recordingsDir++"/"++~title++~clipName++~timeStamp;


~rec1 = Recorder(s);
~rec1.prepareForRecord(path: ~clipsPrefix++"_out-1.aiff", numChannels:1);

~rec2 = Recorder(s);
~rec2.prepareForRecord(path: ~clipsPrefix++"_out-2.aiff", numChannels:1);

~rec3 = Recorder(s);
~rec3.prepareForRecord(path: ~clipsPrefix++"_out-3.aiff", numChannels:1);

~rec4 = Recorder(s);
~rec4.prepareForRecord(path: ~clipsPrefix++"_out-4.aiff", numChannels:1);

~rec5 = Recorder(s);
~rec5.prepareForRecord(path: ~clipsPrefix++"_out-5.aiff", numChannels:1);

~rec6 = Recorder(s);
~rec6.prepareForRecord(path: ~clipsPrefix++"_out-6.aiff", numChannels:1);

~rec7 = Recorder(s);
~rec7.prepareForRecord(path: ~clipsPrefix++"_out-7.aiff", numChannels:1);

)


(
~recDur = 16;
TempoClock.sched(TempoClock.timeToNextBeat(quant:1),
	{
		~rec1.record(bus:~o1, duration:~recDur);
		~rec2.record(bus:~o2, duration:~recDur);
		~rec3.record(bus:~o3, duration:~recDur);
		~rec4.record(bus:~o4, duration:~recDur);
		~rec5.record(bus:~o5, duration:~recDur);
		~rec6.record(bus:~o6, duration:~recDur);
		~rec7.record(bus:~o7, duration:~recDur);
	}
);

)