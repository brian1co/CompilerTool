package com.util
{
	import com.Jarvis;
	import com.data.define.PathManager;
	import com.data.model.ConfigModel;

	/**
	 * @desc	:	AssetsCallBack
	 * @author	:	brian.li
	 * 创建时间	:	2018-3-19 下午2:02:45
	 * 
	 */
	public class AssetsCallBack
	{
		public static function asset(arr:Array):void{
			for(var i:int=0;i<arr.length;i++){
				configModel(arr[0]);
			}
		}
		public static function configModel(config:ConfigModel):void{
			var fileName:String = config.fileName;
			var data:String = App.loader.getResLoaded(PathManager.dUrls[fileName]);
			var ids:Array = config.keys;
			var className:Class = config.className;
			var callBack:Function = config.callBack;
			if(fileName.indexOf(".xml") >=0){
				var map:HashMap = Jarvis.model.parseXML(data,className,ids[0]);
				callBack.apply(null,[map]);
			}else if(fileName.indexOf(".json") >=0){
				var str:String = data.toString();
				var obj:Array = JSON.parse(str) as Array;
				var jList:HashMap = Jarvis.model.parseJSON(obj,className,ids);
				callBack.apply(null,[jList]);                   
			}else if(fileName.indexOf(".txt") >= 0){
				callBack.apply(null,[data]);
			}
		}
	}
}