package com.ui.module.main
{
	import com.ui.module.main.data.TabsData;
	
	import flash.events.Event;
	
	import morn.dispose.Disposeable;
	
	import mornUI.main.MainModuleUI;
	
	/**
	 * @desc	:	MainModule
	 * @author	:	brian.li
	 * 创建时间	:	2018-3-19 下午1:18:23
	 * 
	 */
	public class MainModule extends MainModuleUI implements Disposeable
	{
		private static var _instance : MainModule;
		private const TabsObjs:Array = [
			{
				label:"文件同步"
//				className:
			}
		];
		private var dataVec:Vector.<TabsData>;
		public function MainModule()
		{
			super();
			initEvent();
			initView();
		}
		
		private function initEvent():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE,addToStage);
		}
		private function initView():void{
			dataVec = new Vector.<TabsData>();
			for (var i:int = 0; i < TabsObjs.length; i++) 
			{
				var objData:Object = TabsObjs[i];
				var tabsData:TabsData = new TabsData(objData);
				dataVec.push(tabsData);
			}
			tabPanel.tabsData = dataVec;
		}
		protected function addToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,addToStage);
		}
		
		public static function instance():MainModule{
			if (!_instance) { 
				_instance = new MainModule();
			}
			return _instance;
		}
		public function dispose():void{
			
		}
	}
}