package com.ui.component.data
{
	/**
	 * @desc	:	PathItemData
	 * @author	:	brian.li
	 * 创建时间	:	2018-4-3 下午2:48:54
	 * 
	 */
	public class PathItemData extends BaseData
	{
		private var _path:String = "";
		
		public function PathItemData(oriPath:String)
		{
			oriData = oriPath;
			_path = oriPath;
		}
		
		public function get path():String{
			return _path;
		}
		public function save():void{
			_path = tempData;
			$isChange = false;
		}
		
		
	}
}