package com.ui.module.main.data
{
	/**
	 * @desc	:	ToolData
	 * @author	:	brian.li
	 * 创建时间	:	2018-3-22 下午7:16:18
	 * 
	 */
	public class ToolData
	{
		public var label:String;
		public var name:String;
		public var itemName:String;
		public var itemNum:String;
		public var className:Class;
		public var classData:Class;
		private var _isChanged:Boolean = false;
		public function ToolData(obj:Object)
		{
			label = obj.label;
			name = obj.name;
			itemNum = obj.itemNum;
			itemName = obj.itemName;
			className = obj.className;
			classData = obj.classData;
		}
		public function set isChanged(boo:Boolean):void{
			_isChanged = boo;
		}
		public function get isChanged():Boolean{
			return _isChanged
		}
		public function get labelText():String{
			return isChanged?"*"+label:label;
		}
	}
}