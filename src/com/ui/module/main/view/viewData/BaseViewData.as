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
		public var itemNum:int;
		public function BaseViewData(obj:*,$itemNum:int = 0)
		{
			itemNum = $itemNum;
			setViewData(obj);
		}
		public function setViewData(obj:*):void{
			
		}
		public function get jsonString():String{
			return "";
		}
		public function hasChange():Boolean{
			return false;
		}
	}
}