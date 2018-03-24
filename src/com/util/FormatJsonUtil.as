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
		public static function createFile(fileName:String):String{
			var fileString:String;
			if(fileName == FileConst.SAVEJSON){
				var s:String = "{";
				var views:Vector.<ToolData> = MainModule.toolDatas;
				for (var i:int = 0; i < views.length; i++) 
				{
					var obj:Object = createToolObj(views[i],0);
					s += '"'+views[i].name + '"'+":"+obj;
					s += addRT(0)+"}";
				}
			}
			fileString = s;
			return fileString
		}
		
		private static function createToolObj(tData:ToolData,rt:int):String
		{
			var s:String = addRT(rt+1)+"{";
			s += '"'+tData.itemName + '"'+":";
			s += createClassObject(tData.className,rt+1);
			s += addRT(rt+1)+"}"
			return s;
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
		
//		private static function createFilesRobocopyObject(p1:String ="",p2:String="",rt:int = 0):String
//		{
//			if(p1=="")p1='""';
//			if(p2=="")p2='""';
//			var s:String = addRT(rt+1)+"[";
//			s += addRT(rt+2)+"{";
//			s += addRT(rt+3)+'"path1":'+p1+','+addRT(rt+3)+'"path2":'+p2;
//			s += addRT(rt+2)+"}";
//			s += addRT(rt+1)+"]";
//			return s;
//		}
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