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
		public var className:Class;
		public function ToolData(obj:Object)
		{
			label = obj.label;
			name = obj.name;
			itemName = obj.itemName;
			className = obj.className;
		}
	}
}