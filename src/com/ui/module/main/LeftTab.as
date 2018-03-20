package com.ui.module.main
{
	import com.ui.module.main.data.TabsData;
	
	import morn.core.components.Button;
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
		private var datas:Vector.<TabsData>;
		public function LeftTab()
		{
			super();
			initView();
		}
		
		private function initView():void
		{
			tabs.selectHandler = new Handler(tabClick);
			tabs.selectedIndex = 0;
		}
		
		private function tabClick(index:int):void
		{
			
//			switch(index){
//				case 0:
//					break;
//				case 1:
//					
//					break;
//			}
//			this.addChild(view);
		}
		public function set tabsData(arr:Vector.<TabsData>):void{
			datas = arr;
			for (var i:int = 0; i < arr.length; i++) 
			{
				var tabsData:TabsData = arr[i];	
				labels += tabsData.label;
				i!=arr.length-1?labels+=",":null;
			}
			refreshView();
		}
		
		private function refreshView():void
		{
			tabs.labels = labels;	
			setTabsFont();
		}
		private function setTabsFont():void{
			for (var i:int = 0; i < tabs.items.length; i++) 
			{
				var btn:Button = tabs.items[i] as Button;
				btn.labelFont = "微软雅黑";
			}
		}
	}
}