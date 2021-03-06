package com.ui.module.main
{
	import com.Jarvis;
	import com.event.GlobalEvent;
	import com.ui.module.main.data.ToolData;
	import com.ui.module.main.view.FilesRobocopy;
	import com.ui.module.main.view.IBaseView;
	import com.ui.module.main.view.viewData.FilesRobocopyData;
	import com.util.FileUtil;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import morn.core.components.Box;
	import morn.core.components.View;
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
		private var movePoint:Point = new Point();
		private var rightView:Box;
		private var currentView:IBaseView;
		
		public static var toolDatas:Vector.<ToolData> = new Vector.<ToolData>();
		private static var objArr:Array=[
			{
				label:"文件同步",
				name:"filesRobocopy",
				itemNum:"itemNum",
				itemName:"pathList",
				className:FilesRobocopy,
				classData:FilesRobocopyData
			}
		]
		public function MainModule()
		{
			super();
			initEvent();
		}
		
		private function initView():void
		{
			
			for (var i:int = 0; i < toolDatas.length; i++) 
			{
				var view:View = new toolDatas[i].className() as View;
				view.visible = false;
				viewBox.addChild(view);
				Jarvis.views.push(view);
			}
		}
		
		private function initEvent():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE,addToStage);
			this.bg.addEventListener(MouseEvent.MOUSE_OUT,mouseUp);
			this.bg.addEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
			this.bg.addEventListener(MouseEvent.MOUSE_UP,mouseUp);
			Jarvis.addEventListener(GlobalEvent.SWITCH_VIEW,switchView);
			Jarvis.addEventListener(GlobalEvent.SAVEJSON_LOADCOMPLETE,saveJsonComplete);
		}
		
		protected function clickHande(event:MouseEvent):void
		{
		}
		
		private function saveJsonComplete(e:GlobalEvent):void
		{
			updateView();
		}
		
		protected function mouseUp(event:MouseEvent):void
		{
			this.bg.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
		}
		
		protected function mouseDown(event:MouseEvent):void
		{
			movePoint.x = event.localX;
			movePoint.y = event.localY;
			this.bg.addEventListener(MouseEvent.MOUSE_MOVE,mouseMove);
		}
		
		protected function mouseMove(event:MouseEvent):void
		{
			var dx:int = event.stageX-movePoint.x;
			var dy:int = event.stageY-movePoint.y;
			Jarvis.move(dx,dy);			
		}
		
		private function switchView(index:int):void
		{
			if(currentView){
				currentView.hide();
			}
			currentView = Jarvis.views[index] ;
			currentView.initData(objArr[index].name);
			currentView.show();
		}
		
		private function updateView():void{
			
			tabPanel.tabsData = toolDatas;
		}
		protected function addToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,addToStage);
			rightView = viewBox;
			Jarvis.setConsole(console);
			for (var i:int = 0; i < objArr.length; i++) 
			{
				var tobj:Object = objArr[i];
				var tData:ToolData = new ToolData(tobj);
				toolDatas.push(tData);
			}
			FileUtil.init();
			initView();
		}
		
		public static function instance():MainModule{
			if (!_instance) { 
				_instance = new MainModule();
			}
			return _instance;
		}
		public function dispose():void{
			removeEvent();
		}
		
		private function removeEvent():void
		{
			Jarvis.removeEventListener(GlobalEvent.SWITCH_VIEW,switchView);
			Jarvis.removeEventListener(GlobalEvent.SAVEJSON_LOADCOMPLETE,saveJsonComplete);
			this.bg.removeEventListener(MouseEvent.MOUSE_DOWN,mouseDown);
		}
	}
}