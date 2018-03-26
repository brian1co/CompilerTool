package com.ui.module.main.view.viewData
{
	/**
	 * @desc	:	FilesRobocopyData
	 * @author	:	brian.li
	 * 创建时间	:	2018-3-26 下午2:30:36
	 * 
	 */
	public class FilesRobocopyData extends BaseViewData
	{
		public var path1:String ="";
		public var path2:String ="";
		public function FilesRobocopyData(obj:Object)
		{
			super(obj);
		}
		override public function setViewData(obj:Object):void{
			path1 = obj.pathItem[0].path1;
			path2 = obj.pathItem[0].path2;
			save();
		}
		public function save():void{
			var p1:String = path1
			jsonObject.pathList = [{
				"path1":path1,
				"path2":path2
			}]
		}
		
	}
}