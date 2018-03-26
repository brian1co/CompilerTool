package com.util
{
	import com.data.define.FileConst;
	import com.ui.module.main.MainModule;
	import com.ui.module.main.data.ToolData;
	import com.ui.module.main.view.FilesRobocopy;

	/**
	 * @desc	:	FormatJsonUtil
	 * @author	:	brian.li
	 * 创建时间	:	2018-3-24 下午4:50:18
	 * 
	 */
	public class FormatJsonUtil
	{
		public function FormatJsonUtil()
		{
		}
		public static function createFile(fileName:String,finalObj:Object = null):String{
			var fileString:String;
			if(fileName == FileConst.SAVEJSON){
				var s:String = '{';
				var views:Vector.<ToolData> = MainModule.toolDatas;
				for (var i:int = 0; i < views.length; i++) 
				{
					var finalItem:Object = null;
					if(finalObj != null){
						finalItem = finalObj[views[i].name];
					}
					var obj:Object = createToolObj(views[i],1,finalItem);
					s += addRT(1)+'"'+views[i].name + '"'+":"+obj;
					s += addRT(0)+'}';
				}
			}
			fileString = s;
			return fileString
		}
		
		private static function createToolObj(tData:ToolData,rt:int,finalObj:Object = null):String
		{
			var finalItem:Object = null;
			if(finalObj != null)finalItem = finalObj[tData.itemName];
			var s:String = "{";
			s += addRT(rt+1)+'"'+tData.itemName + '"'+":";
			s += createClassObject(tData.className,rt+1,finalItem);
			s += addRT(rt)+"}"
			return s;
		}
		private static function createClassObject(className:Class,rt:int,finalObj:Object = null):String
		{
			var obj:String;
			var item:Object = null;
			switch(className)
			{
				case FilesRobocopy:
				{
					var p1:String = "";
					var p2:String = "";
					if(finalObj){
						item = finalObj[0];
						p1 = item["path1"];
						p2 = item["path2"];
					}
					obj = createFilesRobocopyObject(p1,p2,rt);
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
			var s:String = '[';
			s += addRT(rt+1)+"{";
			s += addRT(rt+2)+createUnit("path1",p1)+','+addRT(rt+2)+createUnit("path2",p2);
			s += addRT(rt+1)+"}";
			s += addRT(rt)+']';
			return s;
		}
		private static function createUnit(unityItem:String,unitValue:String= "",rt:int = 0):String{
			var unitStr:String = "";
			var valueStr:String='""';
			if(unitValue!='""'){
				valueStr='"'+unitValue+'"';
			}
			unitStr += '"'+unityItem+'":'+valueStr;
			return unitStr;
		}
		private static function addRT(rt:int):String{
			var rts:String = "\r";
			for (var i:int = 0; i < rt; i++) 
			{
				rts+="\t";
			}
			return	rts
		}
		public static function formatXiegang(pStr:String):String{
			var arr:Array = pStr.split("/");
			var str:String = "";
			
			for (var i:int = 0; i < arr.length; i++) 
			{
				if(i==arr.length-1){
					str+=arr[i];
				}else
				str+=arr[i]+"/";
			}
			return str;
		}
	}
}