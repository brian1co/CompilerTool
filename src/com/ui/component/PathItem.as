package com.ui.component
{
	import com.Jarvis;
	import com.event.GlobalEvent;
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
		public var tempPath:String = "";
		private var file:File;
		private var isChange:Boolean = false;
		private var viewClassName:String;
		public function PathItem()
		{
			super();
			initEvent();
		}
		
		private function initEvent():void
		{
			liulanBtn.addEventListener(MouseEvent.CLICK,liulanFunc);	
		}
		public function get jsonObject():Object{
			return path;
		}
		public function set ViewClassName(className:String):void{
			viewClassName = className;
		}
		protected function inputText(event:Event):void
		{
			if(Jarvis.isCtrl){
				input.text = tempPath;
				return;
			};
			tempPath = input.text;
			Jarvis.dispatcherEvent(GlobalEvent.VIEW_CHANGED,viewClassName);
		}
		
		protected function liulanFunc(event:MouseEvent):void
		{
			if(file == null||path == "" || path == "请选择路径"){
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
		public function save():void{
			_path = tempPath;
		}
		public function set path(pathStr:String):void{
			_path = pathStr;
			input.text = _path==""?"请选择路径":_path;
			tempPath = input.text;
			if(!input.hasEventListener(Event.CHANGE)){
				input.addEventListener(Event.CHANGE,inputText);	
			}
		}
		public function get path():String{
			return _path;
		}
		public function dispose():void{
			file.removeEventListener(Event.SELECT,selectDic);
			input.removeEventListener(Event.CHANGE,inputText);	
		}
	}
}