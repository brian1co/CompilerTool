package com.ui.module.main.view
{
	import com.Jarvis;
	import com.event.GlobalEvent;
	import com.ui.component.TwoPathItem;
	import com.ui.module.main.view.viewData.BaseViewData;
	import com.ui.module.main.view.viewData.FilesRobocopyData;
	import com.util.FileUtil;
	
	import flash.display.BitmapData;
	
	import morn.core.handlers.Handler;
	
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
			initEvent();
		}
		
		private function initEvent():void
		{
			list.renderHandler = new Handler(listRender);
			btnCopy.clickHandler = new Handler(clickCopy)
			btnTest.clickHandler = new Handler(clickTest)
			btnPlus.clickHandler = new Handler(clickPlus)
			btnMinus.clickHandler = new Handler(clickMinus)
		}
		
		private function clickPlus():void
		{
			
		}
		
		private function clickMinus():void
		{
			
		}
		
		private function clickTest():void
		{
//			var btd:BitmapData = Jarvis.test("");
//			image.width = image.height = 300;
//			image.bitmapData = btd;
		}
		
		private function clickCopy():void
		{
			Jarvis.copy();
		}
		
		private function listRender(item:TwoPathItem,index:int):void
		{
			if(index < list.length){
				item.ViewClassName = viewClassName;
				item.pathData = list.array[index];
			}
		}
		public function initData(mapName:String):void
		{
			fileData = FileUtil.getViewDataVecByMapName(mapName) as FilesRobocopyData;
			ViewClassName = mapName;
			listData = fileData;
		}
		private function set listData(fileData:FilesRobocopyData):void{
			list.array = fileData.pathList;
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
			fileData.save();
			Jarvis.dispatcherEvent(GlobalEvent.VIEW_SAVE,ViewClassName);
		}
		public function hasChange():Boolean{
			return fileData.hasChange();
		}
	}
}