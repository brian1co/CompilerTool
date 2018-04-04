package com.util
{
	import com.Jarvis;
	import com.data.define.FileConst;
	
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.NativeProcessExitEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.utils.IDataInput;

	/**
	 * @desc	:	CopyUtil
	 * @author	:	brian.li
	 * 创建时间	:	2018-4-3 下午5:25:16
	 * 
	 */
	public class CopyUtil
	{
		public static var process:NativeProcess 
		public function CopyUtil()
		{
		}
		public static function RobocopyAtoB(pathA:String,pathB:String,complete:Function):void{
			var batStr:String = "robocopy "+pathA+" "+pathB+" "+"/E";
//			FileUtil.createBat(batStr,complete);
			doCopy(batStr);
//			trace(batStr);
		}
		private static function doCopy(batStr:String = null):void{
		　	var fileCmd:File = File.applicationDirectory;
		　	var fileBat:File = File.applicationDirectory;
			fileCmd = fileCmd.resolvePath(FileUtil.getCMDPath());
			fileBat = fileBat.resolvePath(FileUtil.getBatPath());
			var info:NativeProcessStartupInfo = new NativeProcessStartupInfo();//启动参数
			info.executable = fileCmd;
			var processArg:Vector.<String> = new Vector.<String>();
			processArg[0] = "/c";//cmd参数，也是bat内的执行命令
			processArg[1] = batStr;//cmd参数，也是bat内的执行命令
//			trace(FileUtil.getBatPath());
//			trace(FileUtil.getCMDPath());
//			trace(fileBat.nativePath);
//			trace(fileCmd.nativePath);
			info.arguments = processArg;
			process = new NativeProcess();
			process.addEventListener(NativeProcessExitEvent.EXIT,packageOverHandler);
			process.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA,outputHandler);
			process.addEventListener(ProgressEvent.PROGRESS,progressHandler);
			process.addEventListener(ProgressEvent.STANDARD_INPUT_PROGRESS, inputProgressListener);
			process.start(info);
//			if(process.running)
//				process.closeInput()
		}
		
		protected static function progressHandler(event:ProgressEvent):void
		{
			var stdOut:IDataInput = IDataInput(event.target.standardOutput);
			var data:String = stdOut.readUTFBytes(process.standardOutput.bytesAvailable); 
			trace("Progress: ", data); 
		}
		protected static function inputProgressListener(event:ProgressEvent):void
		{
			var stdOut:IDataInput = IDataInput(event.target.standardOutput);
			var data:String = stdOut.readUTFBytes(process.standardOutput.bytesAvailable); 
			data = data.replace(
			trace("NewGot: ", data); 
		}
		
		protected static function outputHandler(event:ProgressEvent):void
		{
			var stdOut:IDataInput = IDataInput(event.target.standardOutput);
			var data:String = stdOut.readUTFBytes(process.standardOutput.bytesAvailable); 
			Jarvis.addText(data);
		}
		protected static function packageOverHandler(event:NativeProcessExitEvent):void
		{
			trace("NativeProcessExitEvent:",event);
		}
	}
}