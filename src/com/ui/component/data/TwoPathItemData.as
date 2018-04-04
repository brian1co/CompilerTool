package com.ui.component.data
{
	/**
	 * @desc	:	TwoPathItemData
	 * @author	:	brian.li
	 * 创建时间	:	2018-4-3 下午2:48:31
	 * 
	 */
	public class TwoPathItemData
	{
		public var path1:PathItemData;
		public var path2:PathItemData;
		public function TwoPathItemData()
		{
		}
		public function set pathData(obj:Object):void{
			if(path1){
				path1.data = obj.path1;
				path2.data = obj.path2;
			}else{
				path1 = new PathItemData(obj.path1);
				path2 = new PathItemData(obj.path2);
			}
		}
		public function save():void{
			path1.save();
			path2.save();
		}
		public function checkChange():Boolean{
			return path1.isChange||path2.isChange;
		}
	}
}