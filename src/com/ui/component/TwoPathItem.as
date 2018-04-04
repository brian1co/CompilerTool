package com.ui.component
{
	import com.ui.component.data.PathItemData;
	import com.ui.component.data.TwoPathItemData;
	
	import mornUI.com.TwoPathItemUI;
	
	/**
	 * @desc	:	TwoPathItem
	 * @author	:	brian.li
	 * 创建时间	:	2018-3-21 下午3:04:28
	 * 
	 */
	public class TwoPathItem extends TwoPathItemUI implements IBaseItem
	{
		private var pathData1:PathItemData;
		private var pathData2:PathItemData;
		private var viewClassName:String;
		private var twoObj:TwoPathItemData;
		public function TwoPathItem()
		{
			super();
		}
		public function set pathData(twoObj:TwoPathItemData):void{
			twoObj = twoObj;
			pathData1 = twoObj.path1;
			pathData2 = twoObj.path2;
			path1.pathData = pathData1;
			path2.pathData = pathData2;
			path1.ViewClassName = viewClassName;
			path2.ViewClassName = viewClassName;
		}
		public function get jsonObject():*{
//			twoObj.path1.data = path1.jsonObject.path;
//			twoObj.path2.data = path2.jsonObject.path;
			return twoObj;
		}
		public function set ViewClassName(className:String):void{
			viewClassName = className;
		}
		public function save():void{
			twoObj.save();
		}
	}
}