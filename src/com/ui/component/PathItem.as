package com.ui.component
{
	import com.Jarvis;
	import com.event.GlobalEvent;
	import com.ui.component.data.PathItemData;
	import com.util.FileUtil;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	
	import mornUI.com.PathItemUI;
	
	/**
	 * @desc	:	PathItem
	 * @author	:	brian.li
	 * 创建时间	:	2018-3-21 下午2:24:24
	 * 
	 */
	public class PathItem extends PathItemUI implements IBaseItem
	{
		private var _path:String = "";
		private var _pathData:PathItemData;
		public var tempPath:String = "";
		private var file:File;
		private var isChange:Boolean = false;
		private var viewClassName:String;
		public function PathItem()
		{
			super();
			initView();
			initEvent();
		}
		
		private function initView():void
		{
			input.isHtml = false;
		}
		
		private function initEvent():void
		{
			liulanBtn.addEventListener(MouseEvent.CLICK,liulanFunc);	
		}
		public function get jsonObject():*{
			return path;
		}
		public function set ViewClassName(className:String):void{
			viewClassName = className;
		}
		protected function inputText(event:Event):void
		{
			if(Jarvis.isCtrl){
				input.text = _path;
				return;
			};
			_pathData.data = input.text;
			Jarvis.dispatcherEvent(GlobalEvent.VIEW_CHANGED,viewClassName);
		}
		
		protected function liulanFunc(event:MouseEvent):void
		{
			if(file == null||path == "" ){
				file = FileUtil.browserNew();
				file.addEventListener(Event.SELECT,selectDic);
			}else{
				FileUtil.browser(file);
			}
		}
		
		protected function selectDic(event:Event):void
		{
			path = file.nativePath;
		}
		public function set pathData(pathObject:PathItemData):void{
			_pathData = pathObject;
			path = _pathData.path;
		}
		public function set path($path:String):void{
			_path = $path;
			input.text = _path;
			_pathData.data = _path;
			if(!input.hasEventListener(Event.CHANGE)){
				input.addEventListener(Event.CHANGE,inputText);	
			}
		}
		public function get pathData():PathItemData{
			return _pathData;
		}
		public function get path():String{
			return pathData.path;
		}
		public function dispose():void{
			file.removeEventListener(Event.SELECT,selectDic);
			input.removeEventListener(Event.CHANGE,inputText);	
		}
	}
}