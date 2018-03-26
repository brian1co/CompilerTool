package com.ui.module.main.view
{
	import com.ui.module.main.view.viewData.BaseViewData;
	import com.ui.module.main.view.viewData.FilesRobocopyData;
	import com.util.FileUtil;
	
	import mornUI.main.view.filesRobocopy.FilesRobocopyUI;
	
	/**
	 * @desc	:	FilesRobocopy
	 * @author	:	brian.li
	 * 创建时间	:	2018-3-21 下午2:28:18
	 * 
	 */
	public class FilesRobocopy extends FilesRobocopyUI implements IBaseView
	{
		private var fileData:FilesRobocopyData;
		private var viewClassName:String;
		public function FilesRobocopy()
		{
			super();
		}
		public function initData(mapName:String):void
		{
			fileData = FileUtil.getViewDataVecByMapName(mapName) as FilesRobocopyData;
			ViewClassName = item.ViewClassName = mapName
			item.pathData = fileData;
		}
		public function get viewData():BaseViewData{
			return fileData;
		}
		public function set ViewClassName(className:String):void{
			viewClassName = className;
		}
		public function get ViewClassName():String{
			return viewClassName;
		}
		public function show():void{
			visible = true;
		}
		public function hide():void{
			visible = false;
		}
		public function save():void{
			item.save();
			fileData.path1 = item.path1.path;
			fileData.path2 = item.path2.path;
			fileData.save();
			fileData.jsonObject = fileData.jsonObject;
		}
	}
}