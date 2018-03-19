package com.ui.module.startLoading
{
	import com.ui.UIManager;
	
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
			initView();
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
		public function dispose():void
		{
			_instance = null;
			UIManager.disposeAll(this);
		}
	}
}