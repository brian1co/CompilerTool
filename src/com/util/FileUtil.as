package com.util
{
	import com.Jarvis;
	import com.data.define.FileConst;
	import com.event.GlobalEvent;
	import com.ui.module.main.MainModule;
	import com.ui.module.main.data.ToolData;
	import com.ui.module.main.view.IBaseView;
	import com.ui.module.main.view.viewData.BaseViewData;
	import com.ui.module.main.view.viewData.FilesRobocopyData;
	
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import json.JSONUtil;
	
	import morn.core.components.View;
	import morn.core.handlers.Handler;

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
		/**
		 *工具配置数据集合 
		 */		
		private static var toolHash:HashMap = new HashMap();
		/**
		 *工具配置数据类集合 
		 */	
		private static var viewDataHash:HashMap = new HashMap();
		
		private static var saveJsonFile:File;
		private static var saveJsonFileStream:FileStream;
		public static function init():void
		{
			appDic = File.applicationDirectory;
			initToolHash();
			
		}
		
		private static function initToolHash():void
		{
			checkSaveJson(function():void{
				initAllData();
				Jarvis.dispatcherEvent(GlobalEvent.SAVEJSON_LOADCOMPLETE);
			});
		}
		
		private static function initAllData():void
		{
				var views:Vector.<ToolData> = MainModule.toolDatas;
				for (var i:int = 0; i < views.length; i++) 
				{
					var obj:Object = getViewObject(views[i]);
					var viewData:BaseViewData = getViewData(views[i],obj);
					viewDataHash.put(views[i].name,viewData);
				}
		}
		/**
		 * 根据mapName获取ToolData的数据集 
		 * @return 
		 * 
		 */		
		public static function getViewDataVecByMapName(mapName:String):BaseViewData{
			return viewDataHash.getValue(mapName);
		}
		public static function browserNew():File{
			var fileRef:File = File.applicationDirectory;
			fileRef.browseForDirectory("选择一个路径");
			return fileRef;
		}
		
		public static function browser(file:File):File{
			file.browseForDirectory("选择一个路径");
			return file;
		}
		public static function saveAllFile():void{
			var finalObj:Object = {};
			var allViews:Vector.<IBaseView> = Jarvis.views;
			for  (var i:int=0 ;i<allViews.length;i++) 
			{
				var view:IBaseView = allViews[i];
				view.save();
				var str1:String = view.ViewClassName;
				var obj:Object = view.viewData.jsonObject;
				finalObj[str1] = obj;
			}
			var str:String = FormatJsonUtil.createFile(FileConst.SAVEJSON,finalObj);
			saveJsonValue=str;
		}
		
		
		
		
		
		
		
		private static function checkSaveJson(loadComplete:Function):void
		{
			loadAppFile(appDic.nativePath,FileConst.SAVEJSON,loadComplete);
		}
		private static function loadFileByPath(path:String):void{
			
		}
		private static function getViewDataVec(toolData:ToolData,obj):Vector.<BaseViewData>{
			var vec:Vector.<BaseViewData> = new Vector.<BaseViewData>();
			var dataArr:Array = obj[toolData.itemName];
			for (var i:int = 0; i < dataArr.length; i++) 
			{
				var viewData:BaseViewData = new toolData.classData(dataArr[i]);
				vec.push(viewData);
			}
			return vec;
		}
		private static function getViewData(toolData:ToolData,obj:Object):BaseViewData
		{
			var viewData:BaseViewData = new toolData.classData(obj);
			return viewData;
		}
		
		private static function getViewObject(viewObje:ToolData):Object{
//			var classNameString:String = getQualifiedClassName(viewObje.className);
			var obj:Object = toolHash.getValue(viewObje.name);
			return obj;
		}
		private static function getFilesRobocopyData(id:int):FilesRobocopyData
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
			trace(file.exists);
			if(file.exists){
//				var fileStream:FileStream = new FileStream();
//				fileStream.open(file, FileMode.READ);
//				var readStr:String = fileStream.readUTFBytes(fileStream.bytesAvailable);
//				var jso:Object = JSON.parse(readStr);
//				fileStream.close();
				App.loader.loadTXT(pth,new Handler(function(str:String):void{
					var obj:* = JSON.parse(str);
					for(var i:String in obj) 
					{
						toolHash.put(i,obj[i]);
					}
					loadComplete();
				}));
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