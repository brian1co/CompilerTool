package com.ui.module.main.view.viewData
{
	/**
	 * @desc	:	BaseViewData
	 * @author	:	brian.li
	 * 创建时间	:	2018-3-26 下午3:02:10
	 * 
	 */
	public class BaseViewData implements IBaseViewData
	{
		public var jsonObject:Object = {};
		public function BaseViewData(obj:Object)
		{
		}
		public function setViewData(obj:Object):void{
			
		}
		public function get jsonString():String{
			return "";
		}
	}
}