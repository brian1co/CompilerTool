package com.ui.module.main.view
{
	import com.ui.module.main.view.viewData.BaseViewData;

	public interface IBaseView
	{
		function initData(mapName:String):void;
		function show():void;
		function hide():void;
		function save():void;
		function get ViewClassName():String;
		function get viewData():BaseViewData;
	}
}