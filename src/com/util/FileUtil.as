package com.util
{
	import com.Jarvis;
	import com.data.define.FileConst;
	import com.ui.module.main.MainModule;
	import com.ui.module.main.data.ToolData;
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
		public static function init():void
		{
			appDic = File.applicationDirectory;
			loadAppFile(FileConst.SAVEJSON);
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
		}
		private static function loadAppFile(fileName:String):void{
			var path:String = appDic.nativePath+"/"+fileName;
			var file:File = new File(path);
			if(file.exists){
				var fileStream:FileStream = new FileStream();
				fileStream.open(file, FileMode.READ);
				var jso:Object = JSON.parse(fileStream.readUTFBytes(fileStream.bytesAvailable));
				fileStream.close();
				trace(jso);
			}else{
				Jarvis.addText(FileConst.SAVEJSON+" 文件不存在");
				Jarvis.addText("正在生成 "+FileConst.SAVEJSON+ " ...");
				createFile(FileConst.SAVEJSON);
			}
			
		}
		private static function loadFileByPath(path:String):void{
			
		}
		public static function createFile(fileName:String):void{
			var fileString:String;
			if(fileName == FileConst.SAVEJSON){
				var s:String = "{";
				var views:Vector.<ToolData> = MainModule.toolDatas;
				for (var i:int = 0; i < views.length; i++) 
				{
					var obj:Object = createToolObj(views[i],0);
					s += views[i].name + ":"+obj;
					s += addRT(0)+"}";
				}
			}
			fileString = s;
		}
		
		private static function createToolObj(tData:ToolData,rt:int):String
		{
			var s:String = addRT(rt+1)+"{";
			s += tData.itemName + ":";
			s += createClassObject(tData.className,rt+1);
			s += addRT(rt+1)+"}"
			return s;
		}
		
		private static function createClassObject(className:Class,rt:int):String
		{
			var obj:String;
			switch(className)
			{
				case FilesRobocopy:
				{
					obj = createFilesRobocopyObject("","",rt);
					break;
				}
					
				default:
				{
					break;
				}
			}
			return obj;
		}
		
		private static function createFilesRobocopyObject(p1:String ="",p2:String="",rt:int = 0):String
		{
			if(p1=="")p1='""';
			if(p2=="")p2='""';
			var s:String = addRT(rt+1)+"[";
			s += addRT(rt+2)+"{";
			s += addRT(rt+3)+'"path1":'+p1+','+addRT(rt+3)+'"path2":'+p2;
			s += addRT(rt+2)+"}";
			s += addRT(rt+1)+"]";
			return s;
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
			// TODO Auto Generated method stub
			return null;
		}
		private static function getPath(path:String = "",index:int = 1):Object{
			var key:* = "path"+index;
			var object:Object = {};
			object[key] = path;
			return object;
		}
		private static function addRT(rt:int):String{
			var rts:String = "\r";
			for (var i:int = 0; i < rt; i++) 
			{
				rts+="\t";
			}
			return	rts
		}
	}
}