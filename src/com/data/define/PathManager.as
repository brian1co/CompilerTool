package com.data.define
{
	import flash.utils.Dictionary;

	/**
	 * @desc	:	Path
	 * @author	:	brian.li
	 * 创建时间	:	2018-3-19 下午12:57:30
	 * 
	 */
	public class PathManager
	{
		public static var URL_SWF:String = "swf/";
		public static var URL_MORN:String = "assets/mornAssets/";
		public static var URL_CONFIG:String = "assets/config/";
		public static var URL_IMAGE:String = "image/";
		public static var dUrls	:	Dictionary = new Dictionary();
		public function PathManager()
		{
			PathManager.initURL();
		}
		public static function initURL(root:String = ""):void{
			if(root == null){
				root = "";
			}
			
			PathManager.dUrls[Path.ViewXML] = root + URL_CONFIG+Path.ViewXML;
			PathManager.dUrls[Path.CompSWF] = root + URL_MORN+Path.CompSWF;
		}
	}
}