package com.ui.component
{
	import flash.events.MouseEvent;
	
	import mornUI.com.PathItemUI;
	
	/**
	 * @desc	:	PathItem
	 * @author	:	brian.li
	 * 创建时间	:	2018-3-21 下午2:24:24
	 * 
	 */
	public class PathItem extends PathItemUI
	{
		private var _path:String = "";
		public function PathItem()
		{
			super();
			initEvent();
		}
		
		private function initEvent():void
		{
			liulanBtn.addEventListener(MouseEvent.CLICK,liulanFunc);			
		}
		
		protected function liulanFunc(event:MouseEvent):void
		{
			
		}
		public function set path(pathStr:String):void{
			_path = pathStr;
			input.text = _path;
		}
		public function get path():String{
			return _path;
		}
	}
}