package com.ui.component
{
	import mornUI.com.TwoPathItemUI;
	
	/**
	 * @desc	:	TwoPathItem
	 * @author	:	brian.li
	 * 创建时间	:	2018-3-21 下午3:04:28
	 * 
	 */
	public class TwoPathItem extends TwoPathItemUI implements IBaseItem
	{
		private var pathData1:String;
		private var pathData2:String;
		private var viewClassName:String;
		private var twoObj:Object;
		public function TwoPathItem()
		{
			super();
		}
		public function set pathData(twoObj:Object):void{
			twoObj = twoObj;
			pathData1 = twoObj.path1;
			pathData2 = twoObj.path2;
			path1.path = pathData1;
			path2.path = pathData2;
			path1.ViewClassName = viewClassName;
			path2.ViewClassName = viewClassName;
		}
		public function get jsonObject():Object{
			twoObj.path1 = path1.jsonObject;
			twoObj.path2 = path2.jsonObject;
			return twoObj;
		}
		public function set ViewClassName(className:String):void{
			viewClassName = className;
		}
		public function save():void{
			path1.save();
			path2.save();
		}
	}
}