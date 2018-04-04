package com.ui.component.data
{
	/**
	 * @desc	:	BaseData
	 * @author	:	brian.li
	 * 创建时间	:	2018-4-3 下午4:14:38
	 * 
	 */
	public class BaseData
	{
		protected var tempData:*
		protected var $isChange:Boolean = false;
		public function BaseData()
		{
		}
		public function set data($data:*):void{
			if(tempData==$data)return;
			tempData = $data;
			$isChange = true;
		}
		public function set oriData($data:*):void{
			tempData = $data;
		}
		public function get isChange():Boolean
		{
			return $isChange;
		}
		
	}
}