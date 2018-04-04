package com.ui.module.main
{
	import com.Jarvis;
	import com.event.GlobalEvent;
	import com.ui.module.main.data.TabsData;
	import com.ui.module.main.data.ToolData;
	import com.ui.module.main.view.FilesRobocopy;
	
	import morn.core.components.Button;
	import morn.core.components.View;
	import morn.core.handlers.Handler;
	
	import mornUI.main.LeftTabUI;
	
	/**
	 * @desc	:	LeftTab
	 * @author	:	brian.li
	 * 创建时间	:	2018-3-20 下午12:07:12
	 * 
	 */
	public class LeftTab extends LeftTabUI
	{
		private var labels:String = "";
		private var datas:Vector.<ToolData>;
		
		public function LeftTab()
		{
			super();
			initEvent();
		}
		
		private function initEvent():void
		{
			Jarvis.addEventListener(GlobalEvent.VIEW_CHANGED,viewChange);
			Jarvis.addEventListener(GlobalEvent.VIEW_SAVE,viewSave);
		}
		
		private function viewSave(e:GlobalEvent):void
		{
			var viewName:String = e.data;
			for (var i:int = 0; i < datas.length; i++) 
			{
				var toolData:ToolData = datas[i];
				if(toolData.name == viewName){
					toolData.isChanged = false;
					var btn:Button = tabs.items[i] as Button;
					btn.label = toolData.labelText;
				}
			}
		}
		
		private function viewChange(e:GlobalEvent):void
		{
			var viewName:String = e.data;
			for (var i:int = 0; i < datas.length; i++) 
			{
				var toolData:ToolData = datas[i];
				if(toolData.name == viewName){
					toolData.isChanged = true;
					var btn:Button = tabs.items[i] as Button;
					btn.label = toolData.labelText;
				}
			}
		}
		
		private function initView():void
		{
			tabs.selectHandler = new Handler(tabClick);
			tabs.selectedIndex = 0;
		}
		
		private function tabClick(index:int):void
		{
			Jarvis.dispatcherEvent(GlobalEvent.SWITCH_VIEW,index);
		}
		public function set tabsData(arr:Vector.<ToolData>):void{
			datas = arr;
			for (var i:int = 0; i < arr.length; i++) 
			{
				var tabsData:ToolData = arr[i];	
				labels += tabsData.labelText;
				i!=arr.length-1?labels+=",":null;
			}
			refreshView();
		}
		
		private function refreshView():void
		{
			tabs.labels = labels;	
			setTabsFont();
			initView();
		}
		private function setTabsFont():void{
			for (var i:int = 0; i < tabs.items.length; i++) 
			{
				var btn:Button = tabs.items[i] as Button;
				btn.labelFont = "Arial";
			}
		}
	}
}