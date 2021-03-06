package com.ui.module.startLoading
{
	import com.JUse;
	import com.Jarvis;
	import com.event.GlobalEvent;
	import com.ui.UIManager;
	import com.util.FileUtil;
	
	import flash.events.Event;
	
	import morn.dispose.Disposeable;
	
	import mornUI.startLoading.StartLoadingModuleUI;
	
	/**
	 * @desc	:	StartLoadingModule
	 * @author	:	brian.li
	 * 创建时间	:	2018-3-19 下午5:17:39
	 * 
	 */
	public class StartLoadingModule extends StartLoadingModuleUI implements Disposeable
	{
		private static var _instance : StartLoadingModule;
		public function StartLoadingModule()
		{
			super();
			initEvent();
			initView();
		}
		
		private function initEvent():void
		{
			addEventListener(Event.ADDED_TO_STAGE,addStage);
			
		}
		
		
		protected function addStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,addStage);
			Jarvis.showMainModule();
			
		}
		
		private function initView():void
		{
			icon.visible = false;
			bg.visible = false;
		}
		public static function instance():StartLoadingModule{
			if (!_instance) { 
				_instance = new StartLoadingModule();
			}
			return _instance;
		}
		public function onResize(w:int,h:int):void {
			icon.x = w*.5-icon.width*.5;
			icon.y = h*.5-icon.height*.5;
		}
		public function showLoadIcon(val:Boolean):void{
			icon.visible = val;
		}
		public function showLoadBg(val:Boolean):void{
			bg.visible = val;
		}
		public function dispose():void
		{
			_instance = null;
			UIManager.disposeAll(this);
		}
	}
}