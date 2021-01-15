// Explicitly set the path, or else all recordings get the same file name, since they are triggered at the same time.
(

~clipsPrefix = "rake_bbb_";
// ~clipName = Date.getDate.stamp;
~clipName = "clip-6";


~rec1 = Recorder(s);
~rec1.prepareForRecord(path: thisProcess.platform.recordingsDir++"/"++~clipsPrefix++~clipName++"_out-1"".aiff", numChannels:1);
~rec2 = Recorder(s);
~rec2.prepareForRecord(path: thisProcess.platform.recordingsDir++"/"++~clipsPrefix++~clipName++"_out-2"".aiff", numChannels:1);
~rec3 = Recorder(s);
~rec3.prepareForRecord(path: thisProcess.platform.recordingsDir++"/"++~clipsPrefix++~clipName++"_out-3"".aiff", numChannels:1);
~rec4 = Recorder(s);
~rec4.prepareForRecord(path: thisProcess.platform.recordingsDir++"/"++~clipsPrefix++~clipName++"_out-4"".aiff", numChannels:1);
~rec5 = Recorder(s);
~rec5.prepareForRecord(path: thisProcess.platform.recordingsDir++"/"++~clipsPrefix++~clipName++"_out-5"".aiff", numChannels:1);
~rec6 = Recorder(s);
~rec6.prepareForRecord(path: thisProcess.platform.recordingsDir++"/"++~clipsPrefix++~clipName++"_out-6"".aiff", numChannels:1);

)


(
~recDur = 24;
TempoClock.sched(TempoClock.timeToNextBeat(quant:1),
	{
		~rec1.record(bus:~o1, duration:~recDur);
		~rec2.record(bus:~o2, duration:~recDur);
		~rec3.record(bus:~o3, duration:~recDur);
		~rec4.record(bus:~o4, duration:~recDur);
		~rec5.record(bus:~o5, duration:~recDur);
		~rec6.record(bus:~o6, duration:~recDur);
	}
);

)