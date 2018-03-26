package com.util
{
	import com.Jarvis;
	import com.data.define.FileConst;
	import com.event.GlobalEvent;
	import com.ui.module.main.view.FilesRobocopy;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import avmplus.getQualifiedClassName;
	
	import json.JSONUtil;

	/**
	 * @desc	:	FileUtil
	 * @author	:	brian.li
	 * 创建时间	:	2018-3-22 下午4:05:43
	 * 
	 */
	public class FileUtil
	{
		private static var appDic:File;
		private static var rtNum:int = 0;
		private static var toolHash:HashMap = new HashMap();
		private static var saveJsonFile:File;
		private static var saveJsonFileStream:FileStream;
		public static function init():void
		{
			appDic = File.applicationDirectory;
			initToolHash();
			
		}
		
		private static function initToolHash():void
		{
			
//			var views:Array = MainModule.TabsObjs;
//			for (var i:int = 0; i < views.length; i++) 
//			{
//				var obj:Object = getViewObject(views[i]);
//				
//			}
			checkSaveJson(function():void{
				Jarvis.dispatcherEvent(GlobalEvent.SAVEJSON_LOADCOMPLETE);
			});
		}
		
		private static function checkSaveJson(loadComplete:Function):void
		{
			loadAppFile(appDic.nativePath,FileConst.SAVEJSON,loadComplete);
		}

		
		private static function loadFileByPath(path:String):void{
			
		}
		private static function getViewObject(viewObje:Object):Object{
			var classNameString:String = getQualifiedClassName(viewObje.className);
			var obj:Object = {
//				classNameString:
			};
			obj[viewObje.name] = getObjectByClass(viewObje.className);
			return obj;
		}
		private static function getObjectByClass(value:Class = null ):Object
		{
			var obj:Object;
			switch(value)
			{
				case FilesRobocopy:
				{
					obj = getFilesRobocopyObject();
					break;
				}
					
				default:
				{
					break;
				}
			}
			return {}
		}
		
		private static function getFilesRobocopyObject():Object
		{
			return null
		}
		private static function getPath(path:String = "",index:int = 1):Object{
			var key:* = "path"+index;
			var object:Object = {};
			object[key] = path;
			return object;
		}
		private static function loadAppFile(path:String,name:String,loadComplete:Function):void{
			var pth:String = path+"/"+name;
			var file:File = new File(pth);
			if(file.exists){
				var fileStream:FileStream = new FileStream();
				fileStream.open(file, FileMode.READ);
				var readStr:String = fileStream.readUTFBytes(fileStream.bytesAvailable);
				var jso:Object = JSONUtil.decode(readStr);
				fileStream.close();
				toolHash.put(name,jso);
				loadComplete();
			}else{
				Jarvis.addText(FileConst.SAVEJSON+" 文件不存在");
				Jarvis.addText("正在生成 "+FileConst.SAVEJSON+ " ...");
				var baseString:String = FormatJsonUtil.createFile(FileConst.SAVEJSON);
				saveJsonValue = baseString;
				loadAppFile(path,name,loadComplete);
			}
		}
		private static function writeAllString(str:String,fileName:String):void{
			saveJsonFile = new File(appDic.nativePath + "/"+fileName);
			saveJsonFileStream = new FileStream();
			saveJsonFileStream.open(saveJsonFile,FileMode.WRITE);
			saveJsonFileStream.writeUTFBytes(str);
			saveJsonFileStream.close();
		}
		private static function set saveJsonValue(str:String):void{
			saveJsonFile =new File(appDic.nativePath + "/"+FileConst.SAVEJSON);
			saveJsonFileStream = new FileStream();
			setFileText(saveJsonFile,saveJsonFileStream,str);
			
		}
		private static function setFileText(file:File,fileSteam:FileStream,str:String,type:String = FileMode.WRITE):void{
			fileSteam.open(file,type);
			fileSteam.writeUTFBytes(str);
			fileSteam.close();
		}
	}
}