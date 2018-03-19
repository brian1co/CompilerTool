package com.data.model
{
	/**
	 * @desc	:	ConfigModel
	 * @author	:	brian.li
	 * 创建时间	:	2018-3-19 下午3:26:26
	 * 
	 */
	public class ConfigModel extends BaseModel
	{
		/**文件名*/
		private var _fileName:String;
		/**内部key名*/
		private var _keys:Array;
		/**实例类*/
		private var _className:Class;
		/**解析方法*/
		private var _callBack:Function;
		public function ConfigModel(fileName:String,keys:Array,className:Class,callBack:Function)
		{
			_fileName = fileName;
			_keys = keys;
			_className = className;
			_callBack = callBack;
		}
		public static function New(fileName:String,keys:Array,className:Class,callBack:Function):ConfigModel{
			return new ConfigModel(fileName,keys,className,callBack);
		}
		public function get fileName():String 
		{
			return _fileName;
		}
		public function get keys():Array 
		{
			return _keys;
		}
		public function get className():Class 
		{
			return _className;
		}
		public function get callBack():Function 
		{
			return _callBack;
		}
	}
}